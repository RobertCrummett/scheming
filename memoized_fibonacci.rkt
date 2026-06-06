#lang sicp

;; The claim in SICP is that memo-fib computes the
;; next Fibonacci number in a number of steps
;; proportional to n. But I think this is false.
;; Clearly if table lookup is THETA(1) this is true.
;; But table lookup is currently linear (in n) in
;; the worst case. Therefore this should have
;; number of computational steps proportional to n^2.

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

;; This is a linear search!
(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)

(define (make-table) (list '*table*))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result
              (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

;; Every recursive call is made to the memoized version,
;; so every single step gets cached.

(define memo-fib
  (memoize
    (lambda (n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (memo-fib (- n 1)) ;; Calls to memoized version
                     (memo-fib (- n 2))))))))

(display (memo-fib 50))

;; If we use this implementation, only the top number
;; of the recusion is cached in the table. The rest
;; of the numbers are computed with the non-memoized
;; fib function.
;;
;; (define (fib n)
;;   (cond ((= n 0) 0)
;;         ((= n 1) 1)
;;         (else (+ (fib (- n 1)) ;; Hardcoded native version (not memoized)
;;                  (fib (- n 2))))))
;;
;; (define memo-fib-2 (memoize fib))
;;
;; (display (memo-fib-2 50))
