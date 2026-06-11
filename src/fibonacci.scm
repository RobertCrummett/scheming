#lang sicp
; A prototypical example of tree recursion; two calls to fib each time, in general.
;
; Recusive procedure definition of Fibonacci sequence
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
; This definition is cognitavely easy, and mimics the mathematics closely.
; However, it is computationally expensive.

(define n 40)
(display (fib n))
(newline)

; Iterative procedure definition
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))
; This definition is tougher, but tail-recursive.

(display (fib n))
(newline)

