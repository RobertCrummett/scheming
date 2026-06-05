#lang sicp

;; An implementation of the xor-shift algorithm
;; https://en.wikipedia.org/wiki/Xorshift

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

(display (rand))
(newline)
(display (rand))
(newline)
(display (rand))
(newline)
