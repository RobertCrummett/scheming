#lang sicp

;; Can you reason through what the result of this
;; program will be?

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))
(define w (mystery v))

(display v)
(newline)
(display w)
(newline)
