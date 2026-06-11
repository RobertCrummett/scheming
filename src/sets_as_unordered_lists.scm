#lang sicp

(define (element-of-set? x s)
  (cond ((null? s) false)
        ((equal? x (car s)) true)
        (else (element-of-set? x (cdr s)))))

;; If you do not care about size and adjoining is of the essence, you 
;; could implement the set as a list of duplicate points. Then, adjoin
;; would just be an alias for cons. However, other operations would get
;; more expensive, and there would not be so many early escape sequences.

(define (adjoin-set x s)
  (if (element-of-set? x s) s (cons x s)))

(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) '())
        ((element-of-set? (car s1) s2)
         (cons (car s1) (intersection-set (cdr s1) s2)))
        (else (intersection-set (cdr s1) s2))))

(define (remove-existing-item-from-set item s)
  (define (iter head tail)
    (let ((current (car tail)))
      (if (equal? current item)
          (append head (cdr tail))
          (iter (cons current head) (cdr tail)))))
  (iter '() s))

(define (union-set s1 s2)
  (define (prune bush clippers)
    (if (null? clippers)
        bush
        (prune (remove-existing-item-from-set (car clippers) bush) (cdr clippers))))
  (prune (append s1 s2) (intersection-set s1 s2)))
      
(define s1 '(1 2 3 4))
(define s2 '(3 4 5 6))

(display (intersection-set s1 s2))
(newline)
(display (union-set s1 s2))
(newline)


