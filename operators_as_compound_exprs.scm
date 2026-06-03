#lang sicp
; Here, the operators are outputs of the function!
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
