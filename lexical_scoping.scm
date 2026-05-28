; Square roots by Newton's method, this time with lexical scoping of x.

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

(define (average x y) (/ (+ x y) 2))

(define (square x) (* x x))

(define (abs x)
  (if (< x 0)
    (- x)
    x))

(define a 2)
(display (format "The square root of ~a is ~a~%" a (sqrt a)))
(exit)

; REFERENCES
; https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html
