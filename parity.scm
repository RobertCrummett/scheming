#lang sicp
; Functions with variable number of arguments (the 
; final argument is a list with the 'dot' syntax).

(define (same-parity x . args)
  (define parity?
    (if (odd? x) odd? even?))
  (define (iter result rest)
    (if (null? rest)
      (reverse result)
      (if (parity? (car rest))
        (iter (cons (car rest) result) (cdr rest))
        (iter result (cdr rest)))))
  (cons x (iter '() args)))

(newline)
(newline)
(display (same-parity 1 2 3 4 5 6))
(newline)
(display (same-parity 2 3 4 5 6 7))

