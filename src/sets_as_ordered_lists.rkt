#lang sicp

;; We must have a comparison operator to order
;; our lists. For ease, we will only store numbers
;; in the lists so that we can use <, > and =.

(define (element-of-set? x s)
  (cond ((null? s) false)
        ((= x (car s)) true)
        ((< x (car s)) false)
        (else (element-of-set? x (cdr s)))))

;; This item does not check for equality because it is assumed
;; the item is not in the set to begin with!

(define (insert-new-item-into-set item s)
  (if (< item (car s))
      (cons item s)
      (cons (car s) (insert-new-item-into-set item (cdr s)))))
        
(define (adjoin-set x s)
  (if (element-of-set? x s)
      s
      (insert-new-item-into-set x s)))

(define (intersection-set s1 s2)
  (if (or (null? s1) (null? s2))
      '()
      (let ((x1 (car s1)) (x2 (car s2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr s1) (cdr s2))))
              ((< x1 x2)
               (intersection-set (cdr s1) s2))
              ((< x2 x1)
               (intersection-set s1 (cdr s2)))))))

(define (union-set s1 s2)
  (if (or (null? s1) (null? s2))
      (append s1 s2)
      (let ((x1 (car s1)) (x2 (car s2)))
        (cond ((= x1 x2)
               (cons x1 (union-set (cdr s1) (cdr s2))))
              ((< x1 x2)
               (cons x1 (union-set (cdr s1) s2)))
              ((< x2 x1)
               (cons x2 (union-set s1 (cdr s2))))))))

(define s1 '(1 2 3 4))
(define s2 '(3 4 5 6 7 8))

(display (intersection-set s1 s2))
(newline)
(display (union-set s1 s2))
(newline)
