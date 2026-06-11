#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

;; (accumulate
;;   append
;;   nil
;;   (map (lambda (i)
;;          (map (lambda (j) (list i j))
;;               (enumerate-interval 1 (- i 1))))
;;        (enumerate-interval 1 n))))

;; Mapping and iteration is so common together, 
;; we will abstract it.

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (define (divides? a b)
        (= (remainder b a) 0))
      (define (square x)
        (* x x))
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))
  (= n (smallest-divisor n)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (let ((1st (car pair))
        (2nd (cadr pair)))
    (list 1st 2nd (+ 1st 2nd))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (flatmap
                            (lambda (i)
                              (map (lambda (j) (list i j))
                                   (enumerate-interval 1 (- i 1))))
                            (enumerate-interval 1 n)))))

(display (prime-sum-pairs 6))
