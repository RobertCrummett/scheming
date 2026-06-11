#lang sicp

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(newline)
(display (filter odd? (list 1 2 3 4 5)))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(newline)
(newline)
(display (accumulate + 0 (list 1 2 3 4 5)))
(newline)
(display (accumulate * 1 (list 1 2 3 4 5)))
(newline)
(display (accumulate cons nil (list 1 2 3 4 5)))

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(newline)
(newline)
(display (enumerate-interval 2 7))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(newline)
(newline)
(display (enumerate-tree (list 1 (list 2 (list 3 4) 5))))

(define (square x) (* x x))

(define (sum-odd-squares tree)
  (accumulate
    + 0 (filter odd? (map square (enumerate-tree tree)))))

(newline)
(newline)
(display (sum-odd-squares (list 1 (list 2 (list 3 4) 5))))

(define (fib n)
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (fib-iter a
                     b
                     (+ (* p p) (* q q))
                     (+ (* q q) (* 2 (* p q)))
                     (/ count 2)))
           (else (fib-iter (+ (* b q) (* a q) (* a p))
                           (+ (* b p) (* a q))
                           p
                           q
                           (- count 1)))))
  (fib-iter 1 0 0 1 n))

(define (even-fibs n)
  (accumulate
    cons
    nil
    (filter even? (map fib (enumerate-interval 0 n)))))

(newline)
(newline)
(display (even-fibs 20))

(define (my-map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(newline)
(newline)
(display (my-map square (list 1 2 3 4 5)))

(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))

(newline)
(newline)
(display (my-append (list 1 2 3) (list 4 5 6)))

(define (my-length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

(newline)
(newline)
(display (my-length (list 0 1 2 3 4 5)))

; Horner's rule
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

(newline)
(newline)
(display (horner-eval 2 (list 1 3 0 5 0 1)))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(newline)
(newline)
(display (count-leaves (list 1 (list 2 (list 3 4) 5))))

(define (count-leaves-2 t)
  (accumulate + 0 (map (lambda (x)
                         (if (pair? x)
                           (count-leaves x)
                           1))
                       t)))

(newline)
(display (count-leaves-2 (list 1 (list 2 (list 3 4) 5))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

(define seqs (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

(newline)
(newline)
(display (accumulate-n + 0 seqs))

