#lang sicp
; Approximate sine of an angle (specified in radians)

(define (cube x) (* x x x))

(define (p x)
  (display "Hey!")
  (newline)
  (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
    angle
    (p (sine (/ angle 3.0)))))

(display (sine 12.15))
(newline)
(display (sin 12.15))
(newline)

