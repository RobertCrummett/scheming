#lang sicp
(define x (cons (list 1 2) (list 3 4)))

(newline)
(display (length x))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(newline)
(display (count-leaves x))

(define (deep-reverse x)
  (if (not (pair? x))
    x
    (reverse
      (map deep-reverse x))))

(define x (list (list 1 2) (list 3 4)))

(newline)
(newline)
(display x)
(newline)
(display (reverse x))
(newline)
(display (deep-reverse x))

(define (fringe x)
  (cond ((null? x)
         nil)
        ((not (pair? x))
         (list x))
        (else
          (append (fringe (car x))
                  (fringe (cdr x))))))

(newline)
(newline)
(display (fringe (list x x)))

; A tree is not just a sequence of elements which may or may not be lists; a tree
; is a pair of subtrees! This property is recursive.

; Together, recursion and maps are a powerful means to navigate trees.

(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))


(define test-list (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(newline)
(newline)
(display (scale-tree test-list 10))

(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (scale-tree sub-tree factor)
           (* sub-tree factor)))
       tree))

(newline)
(display (scale-tree test-list 10))

(define square (lambda (x) (* x x)))

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(newline)
(newline)
(display (square-tree test-list))

; Conceptual abstraction of the mapping over a general tree.
(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (square-tree sub-tree)
           (proc sub-tree)))
       tree))

(define (square-tree tree) (tree-map square tree))

(newline)
(display (square-tree test-list))

