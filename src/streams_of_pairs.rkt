#lang sicp

;;; Streams of pairs

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

(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (define (divides? a b)
	(= (remainder b a) 0))
      (define (square x)
	(* x x))
      (cond ((> (square test-divisor) n) n)
	    ((divides? test-divisor n) test-divisor)
	    (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))
  (= n (smallest-divisor n)))

;;; interleave is to streams what appending is to lists.
;;; It is a way of ensuring that elements from both streams
;;; are used. Straightforward appending would result in
;;; the contents of the second stream never begin seen if
;;; the first stream is infinite.
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

(define (pairs-2 s t)
  (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
		t)
    (pairs (stream-cdr s) (stream-cdr t))))

(define ones (cons-stream 1 ones))
(define integers
  (cons-stream 1
	       (stream-map + ones integers)))

(define int-pairs (pairs integers integers))
(define int-pairs-2 (pairs-2 integers integers))

(define prime-pairs
  (stream-filter
    (lambda (pair) (prime? (+ (car pair) (cadr pair))))
    int-pairs))

(define prime-pairs-2
  (stream-filter
    (lambda (pair) (prime? (+ (car pair) (cadr pair))))
    int-pairs-2))

(display "Pairs of integers summing to a prime:\n")
(display (stream-ref prime-pairs 0)) (newline)
(display (stream-ref prime-pairs 1)) (newline)
(display (stream-ref prime-pairs 2)) (newline)
(display (stream-ref prime-pairs 3)) (newline)
(display (stream-ref prime-pairs 4)) (newline)
(display (stream-ref prime-pairs 5)) (newline)
(display (stream-ref prime-pairs 6)) (newline)
(display (stream-ref prime-pairs 7)) (newline)
(newline)

(display "Pairs of integers summing to a prime:\n")
(display (stream-ref prime-pairs-2 0)) (newline)
(display (stream-ref prime-pairs-2 1)) (newline)
(display (stream-ref prime-pairs-2 2)) (newline)
(display (stream-ref prime-pairs-2 3)) (newline)
(display (stream-ref prime-pairs-2 4)) (newline)
(display (stream-ref prime-pairs-2 5)) (newline)
(display (stream-ref prime-pairs-2 6)) (newline)
(display (stream-ref prime-pairs-2 7)) (newline)
