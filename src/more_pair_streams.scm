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

;; This generates all pairs of integers!
(define (more-pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (interleave
	(stream-map (lambda (x) (list (stream-car s) x))
		    (stream-cdr t))
	(stream-map (lambda (x) (list x (stream-car t)))
		    (stream-cdr s)))
      (more-pairs (stream-cdr s) (stream-cdr t)))))

(define ones (cons-stream 1 ones))
(define integers
  (cons-stream 1 (stream-map + ones integers)))

(define int-pairs (more-pairs integers integers))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
        (stream-for-each proc (stream-cdr s)))))

(display (stream-ref int-pairs 0)) (newline)
(display (stream-ref int-pairs 1)) (newline)
(display (stream-ref int-pairs 2)) (newline)
(display (stream-ref int-pairs 3)) (newline)
(display (stream-ref int-pairs 4)) (newline)
(display (stream-ref int-pairs 5)) (newline)
(display (stream-ref int-pairs 6)) (newline)
(display (stream-ref int-pairs 7)) (newline)
(display (stream-ref int-pairs 8)) (newline)
(display (stream-ref int-pairs 9)) (newline)
