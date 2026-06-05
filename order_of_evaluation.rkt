#lang sicp

(define f
  (let ((y 1))
    (lambda (x)
      (if (= x 0)
          (begin (set! y x) y)
          y))))

(+ (f 0) (f 1))

;; This example shows that evaluation of the arguments is left to right.
