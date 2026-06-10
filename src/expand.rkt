#lang sicp

;; Expression of rational numbers in radix bases.

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref stream n)
  (if (= n 0)
    (car stream)
    (stream-ref (stream-cdr stream) (- n 1))))

(define S (expand 1 7 10))

(display (stream-ref S 0)) (newline)
(display (stream-ref S 1)) (newline)
(display (stream-ref S 2)) (newline)
(display (stream-ref S 3)) (newline)
(display (stream-ref S 4)) (newline)
(display (stream-ref S 5)) (newline)
(display (stream-ref S 6)) (newline)

(define T (expand 3 8 10))

(newline)
(display (stream-ref T 0)) (newline)
(display (stream-ref T 1)) (newline)
(display (stream-ref T 2)) (newline)
(display (stream-ref T 3)) (newline)
(display (stream-ref T 4)) (newline)
(display (stream-ref T 5)) (newline)
(display (stream-ref T 6)) (newline)
