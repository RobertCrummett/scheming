#lang sicp

;; A procedure to find all ordered triples of distinct positive
;; integers i, j, k less than or equal to given integer n, such
;; that the sum of i, j and k is equal to a given integer s.

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define n 5)
(define sum 8)

(display (unique-triples n))
(newline)

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (sums-to? sum)
  (lambda (x) (= sum (accumulate + 0 x))))

(define (unique-triples-less-than-n-with-constant-sum n sum)
  (filter (sums-to? sum) (unique-triples n)))

(display (unique-triples-less-than-n-with-constant-sum n sum))
