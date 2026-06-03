#lang sicp
; Ben Bitdiddle's test:

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

(test 0 (p))

; If the interpreter uses applicative-order evaluation, then (p) will be
; recursively defined in the call to test forever, without evaluating the
; actual function test.

; Otherwise, if the interpreter uses normal-order evaluation, then (p)
; never needs to be evaluated, and the test returns zero.

; Which evaluation model is used by Scheme? Run the program to see whether
; you enter into infinite recursion or not.

(exit)

