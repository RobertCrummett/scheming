#lang sicp

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define empty-board (list))

(define (adjoin-position new-row rest-of-queens)
  (cons new-row rest-of-queens))

(define (safe? k positions)
  (let ((new-row (car positions)))
    (define (conflict? row col)
      (or (= row new-row)
          (= (abs (- row new-row))
             (abs (- col k)))))
    (define (check rest-of-queens col)
      (cond ((null? rest-of-queens) #t)
        ((conflict? (car rest-of-queens) col) #f)
        (else (check (cdr rest-of-queens) (- col 1)))))
    (check (cdr positions) (- k 1))))

;; This solution relies on implicity encoding the column position as the list
;; index, building the board from right to left. The numbers in the list are the
;; row indices.

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position new-row rest-of-queens))
                   (if (= k 1)
                       (enumerate-interval 1 (quotient board-size 2))
                       (enumerate-interval 1 board-size))))
            (queen-cols (- k 1))))))

  ;; Vertical reflection cuts work in half
  (let ((half-solutions (queen-cols board-size)))
    (flatmap
      (lambda (sol)
        (list sol
              (map (lambda (row) (- (+ board-size 1) row)) sol)))
      half-solutions)))

;; Stress test solution

(define (mean-runtime proc trials)
  (define (iter number accum-time)
    (if (= number 0)
        (/ accum-time trials)
        (let ((start (runtime)))
          (proc)
          (let ((end (runtime)))
            (iter (- number 1)
                  (+ accum-time (- end start)))))))
  (iter trials 0.0))

(define n 8)
(define trials 1000)

(display "Size of board: ")
(display n)
(newline)
(display "Runtime averaged over 10 trials: ")
(display (mean-runtime (lambda () (queens n)) 10))
(display " microseconds (warm-up)")
(newline)
(display "Runtime averaged over ")
(display trials)
(display " trials: ")
(display (mean-runtime (lambda () (queens n)) trials))
(display " microseconds")
(newline)
