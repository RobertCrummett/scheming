#lang sicp

(define (previous-pair? x previous-pairs)
  (cond ((null? previous-pairs) false)
        ((eq? x (car previous-pairs)) true)
        (else (previous-pair? x (cdr previous-pairs)))))

(define (contains-cycle-1? x)
  (let ((previous-pairs '()))
    (define (iter current)
      (cond ((not (pair? current)) false)
            ((previous-pair? current previous-pairs) true)
            (else
              (set! previous-pairs (cons current previous-pairs))
              (or (iter (car current))
                  (iter (cdr current))))))
    (iter x)))

(define (contains-cycle-2? x)
  (define (iter tortoise hare)
    (cond ((or (null? hare) (not (pair? hare))) false)
          ((or (null? (cdr hare)) (not (pair? (cdr hare)))) false)
          ((eq? tortoise hare) true)
          (else
            (iter (cdr tortoise) (cdr (cdr hare))))))
  (if (not (pair? x))
      false
      (iter x (cdr x))))



(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define linear-list   (cons 'a (cons 'b (cons 'c '()))))
(define circular-list (make-cycle (cons 'a (cons 'b (cons 'c '())))))

(display "Linear list test: (expect no)\n")
(display "(1) Contains cycle? ")
(display (if (contains-cycle-1? linear-list) "yes\n" "no\n"))
(display "(2) Contains cycle? ")
(display (if (contains-cycle-2? linear-list) "yes\n" "no\n"))
(newline)

(display "Circular list test: (expect yes)\n")
(display "(1) Contains cycle? ")
(display (if (contains-cycle-1? circular-list) "yes\n" "no\n"))
(display "(2) Contains cycle? ")
(display (if (contains-cycle-2? circular-list) "yes\n" "no\n"))
