#lang sicp
; IMPLEMENTATION ONE, a linear recursive process
; Program state not encapsulated by arguments.
(define (factorial n)
  (if (= n 1)
    1
    (* n (factorial (- n 1)))))

(define a 6)
(display (format "The factorial of ~a is ~a~%" a (factorial a)))

; IMPLEMENTATION TWO, a linear iterative process
; Program state completely encapsulated by arguments.
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
      product
      (iter (* counter product)
            (+ counter 1))))
  (iter 1 1))

(display (format "The factorial of ~a is ~a~%" a (factorial a)))
(exit)

; REFERENCES
