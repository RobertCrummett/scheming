#lang sicp
(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x)) dx)))

; Now we can compute the derivative of
; any function we like!
(define (cube x) (* x x x))

(display ((deriv cube) 5))
(newline)
(newline)

; Newton's method generalized

; First the fixed-point code needs to be
; copied and pasted to be reused.
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

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

; So now we can have another sqrt procedure:
(define (square x) (* x x))

(define (newton-sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))

(display "The square root of 2.0 is ")
(display (newton-sqrt 2.0))
(newline)

