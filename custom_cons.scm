; Is this data?!

(define (my-cons x y)
  (define (dispatch m)
    (if m x y))
  dispatch)

(define (my-car z) (z #t))
(define (my-cdr z) (z #f))

(define pair (my-cons 1 2))

(display (my-car pair))
(newline)
(display (my-cdr pair))
(newline)

(exit)
