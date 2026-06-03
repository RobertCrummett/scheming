#lang sicp
; Euclid's algorithm: An iterative process for the greatest
; common divisior with a logarithmic number of steps.
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define a 206)
(define b 40)

(display "The greatest common divisor of ")
(display a)
(display " and ")
(display b)
(display " is ")
(display (gcd a b))
(newline)

