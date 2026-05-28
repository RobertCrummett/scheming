; Here we use lambdas.
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (+ (term a)
         (iter (next a) result))))
  (iter a 0))

(define (sum-integers a b)
  (sum (lambda (x) x)
       a
       (lambda (x) (+ x 1))
       b))

(display (sum-integers 1 10))

(define (integral f a b dx)
  (* (sum f
          (+ a (/ dx 2.0))
          (lambda (x) (+ x dx))
          b)
     dx))

(exit)
