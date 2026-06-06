#lang sicp

(define (my-cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefined operation: CONS" m))))
  dispatch)

(define (my-car z) (z 'car))
(define (my-cdr z) (z 'cdr))
(define (my-set-car! z new-value)
  ((z 'set-car!) new-value) z)
(define (my-set-cdr! z new-value)
  ((z 'set-cdr!) new-value) z)

;; Assigment is all that is necessary toaccount for mutable data.
