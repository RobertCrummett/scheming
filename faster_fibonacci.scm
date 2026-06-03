#lang sicp
; This is an iterative procedure to generate Fibonacci numbers
; in logarithmic time and constant space. The trick is to find
; an operator to describe the state transition, and then to square
; it and show that the squared operator can be solved for in terms
; of the parameter of the first operator.

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* q q) (* 2 (* p q)))
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))

(display "The 40th Fibonacci number is ")
(display (fib 40))
(display " (expected 102334155)")
(newline)

