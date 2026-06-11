#lang sicp

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (make-alt-harmonic n sign)
  (cons-stream (/ sign n)
	       (make-alt-harmonic (+ n 1)
				  (- sign))))
(define log2-series
  (make-alt-harmonic 1 1))

(define S log2-series)

(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(display "Basic sequence:\n")
(display (stream-ref S 0)) (newline)
(display (stream-ref S 1)) (newline)
(display (stream-ref S 2)) (newline)
(display (stream-ref S 3)) (newline)
(display (stream-ref S 4)) (newline)
(display (stream-ref S 5)) (newline)
(newline)

(define (square x) (* x x))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
			  (+ s0 (* -2 s1) s2)))
		 (euler-transform (stream-cdr s)))))

(define T (euler-transform log2-series))

(display "Accelerated sequence:\n")
(display (stream-ref T 0)) (newline)
(display (stream-ref T 1)) (newline)
(display (stream-ref T 2)) (newline)
(display (stream-ref T 3)) (newline)
(display (stream-ref T 4)) (newline)
(display (stream-ref T 5)) (newline)
(newline)

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
       the-empty-stream
       (cons-stream
         (apply proc (map stream-car argstreams))
         (apply stream-map
                (cons proc (map stream-cdr argstreams))))))

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))


(define U (accelerated-sequence euler-transform
				log2-series))

(display "Further accelerated sequence:\n")
(display (* 1.0 (stream-ref U 0))) (newline)
(display (* 1.0 (stream-ref U 1))) (newline)
(display (* 1.0 (stream-ref U 2))) (newline)
(display (* 1.0 (stream-ref U 3))) (newline)
(display (* 1.0 (stream-ref U 4))) (newline)
(display (* 1.0 (stream-ref U 5))) (newline)
(newline)
