#lang sicp
; Iterative procedure to compute k-term finite continued fractions
(define (cont-frac n-term d-term k)
  (define (iter step bottom)
    (if (= step 0)
      bottom
      (iter (- step 1) 
            (/ (n-term step) 
               (+ bottom (d-term step))))))
  (iter k 0.0))

; Experiments with the golden ratio!
(define golden-ratio (/ (+ 1.0 (sqrt 5)) 2.0))

(display "The golden ratio is ")
(display golden-ratio)
(newline)

(define k 5)

(display "The ")
(display k)
(display "-term finite continued fraction approximation to the golden ratio is ")
(display (/ 1.0 (cont-frac (lambda (x) 1.0)
                           (lambda (x) 1.0)
                           k)))
(newline)

; We can appoximate Euler's number as well.
(define (d-term x)
  (if (= (remainder (+ x 1) 3) 0)
    (/ (* 2 (+ x 1)) 3)
    1))

(define e (exp 1))

(newline)
(display "Euler's number is ")
(display e)
(newline)

(display "The ")
(display k)
(display "-term finite continued fraction approximation to Euler's number is ")
(display (+ 2 (cont-frac (lambda (x) 1.0)
                         d-term
                         k)))
(newline)
(newline)

; We can also compute the tangent function by continued fractions!

; This is a formula due to J. H. Lambert
(define (square x) (* x x))

(define (tan-cf r k)
  (let ((negative-r-squared (- (square r))))
    (define (n-term x)
      (if (= x 1)
        r
        negative-r-squared))
    (define (d-term x)
      (- (* x 2) 1))
    (cont-frac n-term
               d-term
               k)))

(define r 1.0)

(display "The tangent of ")
(display r)
(display " is ")
(display (tan r))
(newline)

(display "The ")
(display k)
(display "-term finite continued fraction approximation of the tangent of ")
(display r)
(display " is ")
(display (tan-cf r k))
(newline)

