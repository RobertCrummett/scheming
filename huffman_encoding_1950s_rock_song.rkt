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

(define (successive-merge leaf-set)
  (define (merge-leaf-set s n)
    (cond ((> n 2)
           (make-code-tree (car s) (merge-leaf-set (cdr s) (- n 1))))
          ((= n 2) (make-code-tree (car s) (cadr s)))
          ((= n 1) (error "leaf-set is too short: SUCCESSIVE-MERGE" n s))))
  (merge-leaf-set (reverse leaf-set) (length leaf-set)))

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

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

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

;; SICP Exercise 2.70

(define song '(GET A JOB 
              SHA NA NA NA NA NA NA NA NA
              GET A JOB
              SHA NA NA NA NA NA NA NA NA
              WHA YIP YIP YIP YIP YIP YIP YIP YIP YIP
              SHA BOOM))

(define song-symbol-frequency-pairs '((NA 16)
                                      (YIP 9)
                                      (SHA 3)
                                      (A 2)
                                      (GET 2)
                                      (JOB 2)
                                      (BOOM 1)
                                      (WHA 1)))

(define huffman-tree (generate-huffman-tree song-symbol-frequency-pairs))
(define encoded-song (encode song huffman-tree))

(newline)
(display "The song is encoded as")
(newline)
(for-each display encoded-song)
(newline)
(newline)
(display "The Huffman encoding is ")
(display (length encoded-song))
(display " bits, ")
(display (- (* 3 (length song)) (length encoded-song)))
(display " bits shorter than a fixed-width encoding.")
(newline)
