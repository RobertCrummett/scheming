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

(define (adjoin-coordinate col row rest)
  (cons (cons col row) rest))

(define (get-row col partial-board)
  (cond ((null? partial-board) #f)
    ((= (caar partial-board) col) (cdar partial-board))
    (else (get-row col (cdr partial-board)))))

(define (trans-col type col row n)
  (cond ((eq? type 'h)    col)
        ((eq? type 'v)    (- (+ n 1) col))
        ((eq? type 'r180) (- (+ n 1) col))
        ((eq? type 'd1)   row)
        ((eq? type 'r90)  row)
        ((eq? type 'r270) (- (+ n 1) row))
        ((eq? type 'd2)   (- (+ n 1) row))))

(define (trans-row type col row n)
  (cond ((eq? type 'h)    (- (+ n 1) row))
        ((eq? type 'v)    row)
        ((eq? type 'r180) (- (+ n 1) row))
        ((eq? type 'd1)   col)
        ((eq? type 'r90)  (- (+ n 1) col))
        ((eq? type 'r270) col)
        ((eq? type 'd2)   (- (+ n 1) col))))

(define (get-transformed-row target-col partial-board type n)
  (if (null? partial-board)
      #f
      (let* ((queen (car partial-board))
             (q-col (car queen))
             (q-row (cdr queen))
             (t-col (trans-col type q-col q-row n)))
        (if (= t-col target-col)
            (trans-row type q-col q-row n)
            (get-transformed-row target-col (cdr partial-board) type n)))))

(define (transformation-smaller? type partial-board k n)
  (define (scan-columns col)
    (if (> col k)
        #f
        (let ((actual-row (get-row col partial-board))
              (trans-row (get-transformed-row col partial-board type n)))
          (cond ((not trans-row) #f)
                ((< trans-row actual-row) #t)
                ((> trans-row actual-row) #f)
                (else (scan-columns (+ col 1)))))))
  (scan-columns 1))

(define (partial-canonical? partial-board k n)
  (not (or (transformation-smaller? 'h    partial-board k n)
           (transformation-smaller? 'v    partial-board k n)
           (transformation-smaller? 'r180 partial-board k n)
           (transformation-smaller? 'd1   partial-board k n)
           (transformation-smaller? 'r90  partial-board k n)
           (transformation-smaller? 'r270 partial-board k n)
           (transformation-smaller? 'd2   partial-board k n))))

(define (safe? positions)
  (let* ((new-queen (car positions))
         (new-col (car new-queen))
         (new-row (cdr new-queen)))
    (define (conflict? other-queen)
      (let ((other-col (car other-queen))
            (other-row (cdr other-queen)))
        (or (= other-row new-row)
            (= (abs (- other-row new-row))
               (abs (- other-col new-col))))))
    (define (check rest-of-queens)
      (cond ((null? rest-of-queens) #t)
            ((conflict? (car rest-of-queens)) #f)
            (else (check (cdr rest-of-queens)))))
    (check (cdr positions))))

(define (map-i q n)    q)
(define (map-h q n)    (cons (car q) (- (+ n 1) (cdr q))))
(define (map-v q n)    (cons (- (+ n 1) (car q)) (cdr q)))
(define (map-r180 q n) (cons (- (+ n 1) (car q)) (- (+ n 1) (cdr q))))
(define (map-d1 q n)   (cons (cdr q) (car q)))
(define (map-r90 q n)  (cons (cdr q) (- (+ n 1) (car q))))
(define (map-r270 q n) (cons (- (+ n 1) (cdr q)) (car q)))
(define (map-d2 q n)   (cons (- (+ n 1) (cdr q)) (- (+ n 1) (car q))))

(define transformers 
  (list map-i map-h map-v map-r180 map-d1 map-r90 map-r270 map-d2))

(define (coords->flat-board coords n)
  (map (lambda (col) (get-row col coords))
       (reverse (enumerate-interval 1 n))))

(define (element-of-set? x items)
  (cond ((null? items) #f)
        ((equal? x (car items)) #t)
        (else (element-of-set? x (cdr items)))))

(define (remove-duplicates sequence)
  (cond ((null? sequence) nil)
        ((element-of-set? (car sequence) (cdr sequence))
         (remove-duplicates (cdr sequence)))
        (else (cons (car sequence)
                    (remove-duplicates (cdr sequence))))))

(define (expand-solution coords n)
  (remove-duplicates
    (map (lambda (transform)
           (let ((transformed-coords (map (lambda (q) (transform q n)) coords)))
             (coords->flat-board transformed-coords n)))
         transformers)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list nil)
        (filter
          (lambda (positions)
            (and (safe? positions)
                 (partial-canonical? positions k board-size)))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row) (adjoin-coordinate k new-row rest-of-queens))
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (let ((fundamental-solutions (queen-cols board-size)))
    (flatmap (lambda (board) (expand-solution board board-size)) fundamental-solutions)))

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

(display (length (queens n)))

;; Profiling reveals this implementation works better at scale (n=12).
;; For lower n values (n=8), this implementation works just as well as the fast version.
