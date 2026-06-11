#lang sicp
; Faster exponentiation, via iterated logarithms

; In this implementation, the number of calls grows
; logarithmically, and so does the space. Therefore procedure is
; => THETA(log(n)) steps and THETA(log(n)) space
(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(display (fast-expt 2 8))
(newline)
(display (fast-expt 2 9))
(newline)
(newline)

; This can also be accomplished by successive squaring.
; The invariant will be the quantity $a \cdot b^n$. This is an
; iterative procedure that has THETA(log(n)) steps and THETA(1)
; space after tail-recursion is optimized.
(define (fast-expt b n)
  (define (iter b n a)
    (cond ((= n 0) a)
          ((even? n) (iter (square b) (/ n 2) a))
          (else (iter b (- n 1) (* a b)))))
  (iter b n 1))

(display (fast-expt 2 8))
(newline)
(display (fast-expt 2 9))
(newline)

