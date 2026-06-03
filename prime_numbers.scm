#lang sicp
; Some algorithms to test for prime numbers.

; IMPLEMENTATION ONE, with growth THETA(sqrt(n))
(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define number 6153) ; <- THIS IS NOT A PRIME
; (define number 6151) ; <- THIS IS A PRIME

(display "Is ")
(display number)
(display " prime? ")
(display (prime? number))
(newline)

; IMPLEMENTATION TWO, a probabilistic method with THETA(log(n))
; growth. This algorithm utilizes Fermat's Little Theorem.
(define (even? n)
  (= (remainder n 2) 0))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(display "Is ")
(display number)
(display " prime? ")
(display (fast-prime? number 10))
(display " (probably)")
(newline)

