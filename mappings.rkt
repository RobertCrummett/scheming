#lang sicp
(define (scale-list items factor)
  (if (null? items)
    '()
    (cons (* (car items) factor)
          (scale-list (cdr items)
                      factor))))

(newline)
(display (scale-list (list 1 2 3 4 5) 10))

; We can abstract this pattern into a mapping procedure

(define (my-map proc items)
  (if (null? items)
    '()
    (cons (proc (car items))
          (my-map proc (cdr items)))))

(define test-list (list -10 2.0 -11.6 17))

(newline)
(newline)
(display (my-map abs test-list))
(newline)
(display (map abs test-list))

; These routines are sort of equivalent. The computer does the
; same exact thing in each, but we think about each differently.
(define test-list (list 1 2 3 4))

(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
    '()
    (cons (square (car items))
          (square-list (cdr items)))))

(newline)
(newline)
(display (square-list test-list))

(define (square-list items)
  (map (lambda (x) (square x)) 
       items))

(newline)
(display (square-list test-list))

