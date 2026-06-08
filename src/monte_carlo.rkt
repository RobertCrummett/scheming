#lang sicp

;; xor-shift random number generator

(define (shift-left x n)
  (modulo (* x (expt 2 n)) 4294967296))

(define (shift-right x n)
  (quotient x (expt 2 n)))

(define (bit-xor a b)
  (if (and (= a 0) (= b 0))
      0
      (let ((bit-a (modulo a 2))
            (bit-b (modulo b 2)))
        (+ (if (= bit-a bit-b) 0 1)
           (* 2 (bit-xor (quotient a 2)
                         (quotient b 2)))))))

(define xor-shift-init 123456)

(define (xor-shift-update state)
  (let ((x1 (bit-xor state (shift-left state 13))))
    (let ((x2 (bit-xor x1 (shift-right x1 17))))
      (let ((x3 (bit-xor x2 (shift-left x2 5))))
        x3))))

(define random-init xor-shift-init)
(define rand-update xor-shift-update)

(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

;; Monte-Carlo trials

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))

;; Estimation of $\pi$

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

;; Warm up the pseudo-random number generator

(define (spin-up proc times)
  (if (= times 0)
      (values)
      (begin
        (proc)
        (spin-up proc (- times 1)))))

(spin-up rand 10000)

(display "Estimate pi with   100 iterations: ")
(display (estimate-pi 100))
(newline)
(display "Estimate pi with  1000 iterations: ")
(display (estimate-pi 1000))
(newline)
(display "Estimate pi with 10000 iterations: ")
(display (estimate-pi 10000))
(newline)
