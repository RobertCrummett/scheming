#lang sicp
; EXAMPLE ONE
(define (cube x) (* x x x))

(define (inc x) (+ x 1))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (sum-cubes a b)
  (sum cube a inc b))

(display (sum-cubes 1 10))
(newline)

; EXAMPLE TWO
(define (identity x) x)

(define (sum-integers a b)
  (sum identity a inc b))

(display (sum-integers 1 10))
(newline)

; EXAMPLE THREE
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(display "A slow way to approximate pi: ")
(display (* 8 (pi-sum 1 1000)))
(newline)

; EXAMPLE FOUR (numeric integration)
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(display (integral cube 0 1 0.01))
(newline)
(display (integral cube 0 1 0.001))
(newline)

; EXAMPLE FIVE (Simpson's rule)
(define (even? x)
  (= (remainder x 2) 0))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (y count)
    (define value (+ a (* count h)))
    (cond ((or (= count 0) (= count n)) (f value))
          ((even? count) (* 2 (f value)))
          (else (* 4 (f value)))))
  (* (sum y 0 inc n)
     (/ (/ (- b a) n) 3.0)))

(display (simpson cube 0 1 100))
(newline)
(display (simpson cube 0 1 1000))
(newline)
(newline)

; Redefinition of sum as an iterative procedure.
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (+ (term a)
         (iter (next a) result))))
  (iter a 0))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(display (integral cube 0 1 0.01))
(newline)
(display (integral cube 0 1 0.001))
(newline)

