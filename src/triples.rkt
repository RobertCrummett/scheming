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

(define (triples r s t)
  (cons-stream
    (list (stream-car r) (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (p) (cons (stream-car r) p))
		  (pairs s t))
      (triples (stream-cdr r) (stream-cdr s) (stream-cdr t)))))

(define ones (cons-stream 1 ones))
(define integers
  (cons-stream 1
	       (stream-map + ones integers)))

(define (square x) (* x x))

(define pythagoean-triples
  (stream-filter (lambda (t) (= (+ (square (car t))
				   (square (cadr t)))
				(square (caddr t))))
		 (triples integers integers integers)))

;;; NOTE: This will take a bit to run.
;;;
;;; You can observe that alot of the triples recovered
;;; are simply scaled versions of eachother. If there
;;; was a way to remove these 'redundant' triples from
;;; the search space I wonder if we could do better (?)
(display "Some pythagoean triples:\n")
(display (stream-ref pythagoean-triples 0)) (newline)
(display (stream-ref pythagoean-triples 1)) (newline)
(display (stream-ref pythagoean-triples 2)) (newline)
(display (stream-ref pythagoean-triples 3)) (newline)
(display (stream-ref pythagoean-triples 4)) (newline)
(display (stream-ref pythagoean-triples 5)) (newline)
(display (stream-ref pythagoean-triples 6)) (newline)
(display (stream-ref pythagoean-triples 7)) (newline)
(display (stream-ref pythagoean-triples 8)) (newline)
(display (stream-ref pythagoean-triples 9)) (newline)
