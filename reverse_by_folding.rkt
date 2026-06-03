#lang sicp

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result seq)
    (if (null? seq)
        result
        (iter (op result (car seq))
              (cdr seq))))
  (iter initial sequence))

(define (reverse-by-fold-right sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define (reverse-by-fold-left sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))

(define xs (list 1 2 3 4 5))

(display (reverse-by-fold-right xs))
(newline)
(display (reverse-by-fold-left xs))
