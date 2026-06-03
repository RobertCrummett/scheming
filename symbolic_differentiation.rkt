#lang sicp

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? expr num) (and (number? expr) (= expr num)))

(define (make-sum a1 . a2)
  (define (reduce-sum inputs sum reduced)
    (if (null? inputs)
        (let ((all-terms (append (reverse reduced) (if (= sum 0) '() (list sum)))))
          (cond ((null? all-terms) 0)
                ((null? (cdr all-terms)) (car all-terms))
                (else (cons '+ all-terms))))
        (let ((expr (car inputs)))
          (cond ((=number? expr 0) (reduce-sum (cdr inputs) sum reduced))
                ((number? expr)    (reduce-sum (cdr inputs) (+ sum expr) reduced))
                (else              (reduce-sum (cdr inputs) sum (cons expr reduced)))))))
  (reduce-sum (cons a1 a2) 0 '()))

(define (make-product m1 . m2)
  (define (reduce-product inputs product reduced)
    (if (null? inputs)
        (let ((all-terms (append (if (= product 1) '() (list product)) (reverse reduced))))
          (cond ((null? all-terms) 1)
                ((null? (cdr all-terms)) (car all-terms))
                (else (cons '* all-terms))))
        (let ((expr (car inputs)))
          (cond ((=number? expr 0) 0)
                ((=number? expr 1) (reduce-product (cdr inputs) product reduced))
                ((number? expr)    (reduce-product (cdr inputs) (* product expr) reduced))
                (else              (reduce-product (cdr inputs) product (cons expr reduced)))))))
  (reduce-product (cons m1 m2) 1 '()))


(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        ((and (number? b) (number? e)) (expt b e))
        (else (list '** b e))))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define addend cadr)

(define (augend expr)
  (let ((tail (cddr expr)))
    (if (null? (cdr tail))
        (car tail)
        (cons '+ tail))))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define multiplier cadr)

(define (multiplicand expr)
  (let ((tail (cddr expr)))
    (if (null? (cdr tail))
        (car tail)
        (cons '* tail))))

(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))

(define base cadr)
(define exponent caddr)

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        ((sum? expr) (make-sum (deriv (addend expr) var)
                               (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (multiplier expr) var)
                         (multiplicand expr))))
        ((exponentiation? expr)
         (let ((base-expr (base expr))
               (exp-expr (exponent expr)))
           (make-product
             (make-product
               exp-expr
               (make-exponentiation base-expr (make-sum exp-expr -1)))
           (deriv base-expr var))))
        (else
          (error "unknown expression type: DERIV" expr))))

(display "Hello, World")
(newline)
(display (deriv '(* 2 y x) 'x))
(newline)
