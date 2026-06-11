#lang sicp
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

; Find a fixed point of the cosine function
(display (fixed-point cos 1.0))
(newline)

; Find a solution to the equation $y = \sin y + \cos y$
(display (fixed-point (lambda (y) (+ (sin y) (cos y)))
                      1.0))
(newline)

; IMPLEMENTATION ONE --- sqrt function that will not converge
(define (fixed-point-root x) 
  (fixed-point (lambda (y) (/ x y))
               1.0))
; The solutions will oscillate between values forever!
; This is just like when a markov chain finds a cycle. How to break the cycle?
; Idea: force the solutions not to change as much without changing the equation.
; Realization: add y to both sides of the fixed point equation and divide by two!

; IMPLEMENTATION TWO --- sqrt function that will not converge
(define (average x y) (/ (+ x y) 2.0))

(define (modified-fixed-point-root x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

(display "The square root of 2.0 is ")
(display (modified-fixed-point-root 2.0))
(newline)

; In some places, this technique of modified successive approximations is referred
; to as average damping.

