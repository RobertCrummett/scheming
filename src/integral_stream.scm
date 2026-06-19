#lang sicp

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
       the-empty-stream
       (cons-stream
         (apply proc (map stream-car argstreams))
         (apply stream-map
                (cons proc (map stream-cdr argstreams))))))

(define (add-streams s1 s2)
  (stream-map (lambda (x1 x2) (+ x1 x2)) s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

;;; IMPLEMENTATION ONE
;;; Redefinition of integral to expect an integrand stream as a
;;; delayed argument.
;;; (define (integral delayed-integrand initial-value dt)
  ;;; (define int
    ;;; (cons-stream
      ;;; initial-value
      ;;; (let ((integrand (force delayed-integrand)))
	;;; (add-streams (scale-stream integrand dt) int))))
  ;;; int)

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;;; IMPLEMENTATION TWO
(define (integral delayed-integrand initial-value dt)
  (cons-stream
    initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
	the-empty-stream
	(integral (stream-cdr integrand)
		  (+ (* dt (stream-car integrand))
		     initial-value)
		  dt)))))

;;; Approximate e = 2.718...
;;;
;;; Equation is dy/dt = y at y = 1, with initial condition y(0) = 1

(define (stream-ref stream n)
  (if (= n 0)
    (stream-car stream)
    (stream-ref (stream-cdr stream) (- n 1))))

;;; TODO Will not work with either definition of integral because
;;; of how racket handles internal definitions.
(display
  (stream-ref (solve (lambda (y) y)
		     1
		     0.001)
	      1000))

