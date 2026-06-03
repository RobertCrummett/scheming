#lang sicp

;; fold-right is also known as accumulate
(define (fold-right op initial sequence) ;; recursive process
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)  ;; iterative process
  (define (iter result seq)
    (if (null? seq)
        result
        (iter (op result (car seq))
              (cdr seq))))
  (iter initial sequence))

(define xs (list 1 2 3 4 5))

(display (fold-right + 0 xs))
(newline)
(display (fold-left + 0 xs))

(newline)
(newline)
(display (fold-right / 1 xs))
(newline)
(display (fold-left / 1 xs))

(newline)
(newline)
(display (fold-right list nil xs))
(newline)
(display (fold-left list nil xs))

;; For fold-right and fold-left to produce the same result, the
;; operation must be symmetric in the arguments.
