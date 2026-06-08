#lang sicp

(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (define (divides? a b)
        (= (remainder b a) 0))
      (define (square x)
        (* x x))
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))
  (= n (smallest-divisor n)))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;; IMPLEMENTATION ONE

(define (sum-primes-1 a b)
  (define (iter cnt accum)
    (cond ((> cnt b) accum)
          ((prime? cnt)
           (iter (+ cnt 1) (+ cnt accum)))
          (else (iter (+ cnt 1) accum))))
  (iter a 0))

;; IMPLEMENTATION TWO

(define (sum-primes-2 a b)
  (accumulate +
              0
              (filter prime?
                      (enumerate-interval a b))))

(define a 100)
(define b 200)

(display "Sum of primes: ")
(display (sum-primes-1 a b))
(newline)

(display "Sum of primes: ")
(display (sum-primes-2 a b))
(newline)

;; In contrast to the first, the second implementation
;; incurs outrageous intermediate spatial growth.
