#lang sicp

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

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
		 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
		  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

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

(define sum-weight
  (lambda (p1 p2)
    (<= (+ (car p1) (cadr p1))
        (+ (car p2) (cadr p2)))))

(define ordered-sum-pairs
  (pairs-weighted integers integers sum-weight))

(define (display-stream-n stream n)
  (if (= n 0)
    (values)
    (begin
      (display (stream-car stream))
      (newline)
      (display-stream-n (stream-cdr stream) (- n 1)))))

(display "Ordered sum pairs:\n")
(display-stream-n ordered-sum-pairs 10)

(define (div-by-2-3-or-5? x)
  (cond 
    ((= (remainder x 2) 0) true)
    ((= (remainder x 3) 0) true)
    ((= (remainder x 5) 0) true)
    (else false)))

(define tricky-weight
  (lambda (p1 p2)
    (let ((i1 (car p1))
	  (i2 (car p2))
	  (j1 (cadr p1))
	  (j2 (cadr p2)))
      (<= (+ (* 2 i1) (* 3 j1) (* 5 i1 j1))
	  (+ (* 2 i2) (* 3 j2) (* 5 i2 j2))))))

(define tricky-series
  (stream-filter (lambda (x)
		   (and (not (div-by-2-3-or-5? (car x)))
			(not (div-by-2-3-or-5? (cadr x)))))
		 (pairs-weighted integers
				 integers
				 tricky-weight)))

(display "\nTricky series:\n")
(display-stream-n tricky-series 10)
