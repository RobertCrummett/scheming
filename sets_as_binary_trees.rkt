#lang sicp

(define entry car)
(define left-branch cadr)
(define right-branch caddr)
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x s)
  (cond ((null? s) false)
        ((= x (entry s)) true)
        ((< x (entry s))
         (element-of-set? x (left-branch s)))
        ((> x (entry s))
         (element-of-set? x (right-branch s)))))

(define (adjoin-set x s)
  (cond ((null? s) (make-tree x '() '()))
        ((= x (entry s)) s)
        ((< x (entry s))
         (make-tree (entry s)
                    (adjoin-set x (left-branch s))
                    (right-branch s)))
        ((> x (entry s))
         (make-tree (entry s)
                    (left-branch s)
                    (adjoin-set x (right-branch s))))))

;; Two different functions to convert tree to an ordered list.
;; The results of both are equivalent for any binary tree.
;; The first procedure is recursive, while the second is
;; iterative.

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result)
    (if (null? tree)
        result
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree)
                              result)))))
  (copy-to-list tree '()))

;; Some trees from Figure 2.16 of SICP
(define tree-1
  (make-tree 7
             (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 5 '() '()))
             (make-tree 9
                        '()
                        (make-tree 11 '() '()))))

(define tree-2
  (make-tree 3
             (make-tree 1 '() '())
             (make-tree 7
                        (make-tree 5 '() '())
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '())))))

(define tree-3
  (make-tree 5
             (make-tree 3
                        (make-tree 1 '() '())
                        '())
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))

(display "Tree #1:")
(newline)
(display "(1): ")
(display (tree->list-1 tree-1))
(newline)
(display "(2): ")
(display (tree->list-2 tree-1))
(newline)

(display "Tree #2:")
(newline)
(display "(1): ")
(display (tree->list-1 tree-2))
(newline)
(display "(2): ")
(display (tree->list-2 tree-2))
(newline)

(display "Tree #3:")
(newline)
(display "(1): ")
(display (tree->list-1 tree-3))
(newline)
(display "(2): ")
(display (tree->list-2 tree-3))
(newline)

;; This procedure constructs a balanced tree of the list of elements
;; by recursively dividing the ordered list into left and right subtrees.

(define (list->tree elements)
  (define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let ((left-size (quotient (- n 1) 2)))
          (let ((left-result
                  (partial-tree elts left-size)))
            (let ((left-tree (car left-result))
                  (non-left-elts (cdr left-result))
                  (right-size (- n (+ left-size 1))))
              (let ((this-entry (car non-left-elts))
                    (right-result
                      (partial-tree (cdr non-left-elts) right-size)))
                (let ((right-tree (car right-result))
                      (remaining-elts (cdr right-result)))
                  (cons (make-tree this-entry
                                   left-tree
                                   right-tree)
                        remaining-elts))))))))
  (car (partial-tree elements (length elements))))

(newline)
(display tree-1)
(newline)
(display (list->tree (tree->list-2 tree-1)))
(newline)

;; THETA(n) set intersection and union operations.
;;
;; The trick is to turn the binary trees into ordered lists, perform the
;; desired operation on the sorted lists, and then convert back to trees.

(define (intersection-set s1 s2)
  (define (ordered-list-intersection l1 l2)
    (cond ((or (null? l1) (null? l2)) '())
          ((= (car l1) (car l2))
           (cons (car l1) (ordered-list-intersection (cdr l1) (cdr l2))))
          ((< (car l1) (car l2)) (ordered-list-intersection (cdr l1) l2))
          ((< (car l2) (car l1)) (ordered-list-intersection l1 (cdr l2)))))
  (let ((l1 (tree->list-2 s1))
        (l2 (tree->list-2 s2)))
      (list->tree (ordered-list-intersection l1 l2))))

(define (union-set s1 s2)
  (define (ordered-list-union l1 l2)
    (cond ((or (null? l1) (null? l2)) '())
          ((= (car l1) (car l2))
           (cons (car l1) (ordered-list-union (cdr l1) (cdr l2))))
          ((< (car l1) (car l2))
           (cons (car l1) (ordered-list-union (cdr l1) l2)))
          ((< (car l2) (car l1))
           (cons (car l2) (ordered-list-union l1 (cdr l2))))))
  (let ((l1 (tree->list-2 s1))
        (l2 (tree->list-2 s2)))
      (list->tree (ordered-list-union l1 l2))))

(define test-tree
  (make-tree 4
             (make-tree 3 '() '())
             (make-tree 5
                        '()
                        (make-tree 11 '() '()))))

(newline)
(display (intersection-set tree-1 test-tree))
(newline)
(display (union-set tree-1 test-tree))
