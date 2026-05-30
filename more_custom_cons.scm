; We can represent pairs as procedures!

(define (my-cons x y)
  (lambda (m) (m x y)))

(define (my-car z)
  (z (lambda (p q) p)))

(define (my-cdr z)
  (z (lambda (p q) q)))

(define pair (my-cons 1 2))

(newline)
(display (my-car pair))
(newline)
(display (my-cdr pair))

; This example is crazy. We can represent pairs of
; nonegative numbers as integers, and bake a recipe into
; car and cdr to retrieve the values!

(define (my-cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (my-car p)
  (define (iter pair count)
    (if (= (remainder pair 2) 0)
      (iter (/ pair 2) (+ count 1))
      count))
  (iter p 0))

(define (my-cdr p)
  (define (iter pair count)
    (if (= (remainder pair 3) 0)
      (iter (/ pair 3) (+ count 1))
      count))
  (iter p 0))

(define pair (my-cons 12 5))

(newline)
(display (my-car pair))
(newline)
(display (my-cdr pair))

(exit)
