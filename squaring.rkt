#lang sicp

(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))

(define a 10)

(display "The square of ")
(display a)
(display " is ")
(display (square a))
