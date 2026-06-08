#lang sicp

(define (make-accumulator initial)
  (define (accumulator x)
    (begin
      (set! initial (+ initial x))
        initial))
  accumulator)

(define A (make-accumulator 5))

(display (A 10))
(newline)
(display (A 10))
(newline)
