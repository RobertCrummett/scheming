; IMPLEMENTATION ONE
(define (abs x)
  (cond
    ((> x 0) x)
    ((= x 0) 0)
    ((< x 0) (- x))))

; IMPLEMENTATION TWO
(define (abs x)
  (cond
    ((< x 0) (- x))
    (else x)))

; IMPLEMENTATION THREE
(define (abs x)
  (if (< x 0)
    (- x)
    x))

(define a -5)
(display (format "The absolute value of ~a is ~a~%" a (abs a)))
(exit)
