; Square roots by Newton's method.

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))

(define (abs x)
  (if (< x 0)
    (- x)
    x))

; NOTE: The `if` special form cannot be replaced by this function, although
; it seems that it could. One will observe infinite recursion if it is tried.
; Recall the previous example: Scheme will apply applicative order evaluation
; of the function forever, instead of waiting for a termination condition.
;
; (define (new-if predicate then-clause else-clause)
;   (cond (predicate then-clause)
;         (else else-clause)))
;
; This is Example 1.6 of the book.

(define a 2)
(display (format "The square root of ~a is ~a~%" a (sqrt a)))
(exit)

; REFERENCES
; https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html
