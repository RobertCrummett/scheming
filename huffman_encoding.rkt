#lang sicp

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define symbol-leaf cadr)
(define weight-leaf caddr)

(define left-branch car)
(define right-branch cadr)
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
                (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (adjoin-set x s)
  (cond ((null? s) (list x))
        ((< (weight x) (weight (car s))) (cons x s))
        (else (cons (car s)
                    (adjoin-set x (cdr s))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) (cadr pair))
                    (make-leaf-set (cdr pairs))))))

;; Exercise 2.67

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(display sample-tree)
(newline)
(define decoded-message (decode sample-message sample-tree))
(display decoded-message)
(newline)

(define (encode-symbol symbol tree)
  (define (exists-in? x s)
    (cond ((null? s) false)
          ((eq? x (car s)) true)
          (else (exists-in? x (cdr s)))))
  (cond ((leaf? tree) '())
        ((exists-in? symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((exists-in? symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "unexpected symbol: ENCODE-SYMBOL" symbol))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(newline)
(display (encode decoded-message sample-tree))
(newline)
(display sample-message)
(newline)
(display "Reversible decoding and encoding? ")
(display (equal? sample-message 
                 (encode (decode sample-message sample-tree) sample-tree)))
(newline)

;; This code implicitly relies upon the ordered set representation of the sample
;; tree and sample pairs. If this were not the case, we would probably have to
;; order the sample pairs ourselves.

(define (successive-merge leaf-set)
  (define (merge-leaf-set s n)
    (cond ((> n 2)
           (make-code-tree (car s) (merge-leaf-set (cdr s) (- n 1))))
          ((= n 2) (make-code-tree (car s) (cadr s)))
          ((= n 1) (error "leaf-set is too short: SUCCESSIVE-MERGE" n s))))
  (merge-leaf-set (reverse leaf-set) (length leaf-set)))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define sample-pairs '((A 4) (B 2) (C 1) (D 1)))

(newline)
(display sample-pairs)
(newline)
(display (generate-huffman-tree sample-pairs))
(newline)
(display sample-tree)
