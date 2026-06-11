#lang sicp

(define vec (list 1 1 1 1))
(define mat (list (list 1 2 3 4) (list 5 6 7 8) (list 9 10 11 12)))
(define other-mat (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(newline)
(display (matrix-*-vector mat vec))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

(define (transpose m)
  (accumulate-n cons nil m))

(newline)
(newline)
(display mat)
(newline)
(display (transpose mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (xm) (matrix-*-vector cols xm)) m)))

(newline)
(newline)
(display mat)
(newline)
(display "*")
(newline)
(display other-mat)
(newline)
(display "=")
(newline)
(display (matrix-*-matrix mat other-mat))

