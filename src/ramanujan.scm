#lang sicp

;;; Numbers that can be exressed as the sum of cubes
;;; in more than one way --- Ramanujan numbers.

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
	((pred (stream-car stream))
	 (cons-stream (stream-car stream)
		      (stream-filter
			pred
			(stream-cdr stream))))
	(else (stream-filter pred (stream-cdr stream)))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream (apply proc (map stream-car argstreams))
		 (apply stream-map
			(cons proc (map stream-cdr argstreams))))))

(define (merge-weighted s1 s2 weight)
  (cond
    ((stream-null? s1) s2)
    ((stream-null? s2) s1)
    (else
      (let ((s1car (stream-car s1))
	    (s2car (stream-car s2)))
	(if (weight s1car s2car)
	  (cons-stream s1car
		       (merge-weighted (stream-cdr s1)
				       s2
				       weight))
	  (cons-stream s2car
		       (merge-weighted s1
				       (stream-cdr s2)
				       weight)))))))

(define (pairs-weighted s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x)
		    (list (stream-car s) x))
		  (stream-cdr t))
      (pairs-weighted (stream-cdr s) (stream-cdr t) weight)
      weight)))

(define integers
  (cons-stream 1 (stream-map (lambda (x) (+ x 1)) integers)))

(define (cube x) (* x x x))

(define (sum-of-cubes s) (apply + (map cube s)))

(define sum-of-cubes-weight
  (lambda (p1 p2)
    (<= (sum-of-cubes p1) (sum-of-cubes p2))))

(define (double-filter stream)
  (if (= (stream-car stream) 
	 (stream-car (stream-cdr stream)))
    (cons-stream (stream-car stream)
		 (double-filter
		   (stream-cdr
		     (stream-cdr stream))))
    (double-filter (stream-cdr stream))))

(define ramanujan-numbers
  (double-filter
    (stream-map (lambda (x) (sum-of-cubes x))
		(pairs-weighted integers
				integers
				sum-of-cubes-weight))))

(define (display-stream-n stream n)
  (if (= n 0)
    'done
    (begin
      (display (stream-car stream))
      (newline)
      (display-stream-n (stream-cdr stream) (- n 1)))))

(display "Ramanujan numbers:\n")
(display-stream-n ramanujan-numbers 5)
