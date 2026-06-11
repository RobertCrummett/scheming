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

(define (sum-streams s1 s2) (stream-map + s1 s2))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (partial-application proc stream)
  ;; Abstraction of the partial sum function. This will
  ;; partially apply any function that reduces two streams
  ;; to one stream.
  (define s
    (cons-stream (stream-car stream)
                 (proc (stream-cdr stream) s)))
  s)

(define (partial-sums stream)
  (partial-application sum-streams stream))

;; Estimation of $pi$

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
	       (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

(define (stream-ref stream n)
  (if (= n 0)
    (stream-car stream)
    (stream-ref (stream-cdr stream) (- n 1))))

(display "Approximation of pi:\n")
(display (stream-ref pi-stream 0)) (newline)
(display (stream-ref pi-stream 1)) (newline)
(display (stream-ref pi-stream 2)) (newline)
(display (stream-ref pi-stream 3)) (newline)
(display (stream-ref pi-stream 4)) (newline)
(display (stream-ref pi-stream 5)) (newline)
(display (stream-ref pi-stream 6)) (newline)
(display (stream-ref pi-stream 7)) (newline)

;; Euler's sequence accelerator
;;
;; This is a method for transforming a sequence such that it
;; converges faster. This is crazy!

(define (square x) (* x x))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
			  (+ s0 (* -2 s1) s2)))
		 (euler-transform (stream-cdr s)))))

(define accelerated-pi-stream (euler-transform pi-stream))

(newline)
(display "Accelerated approximation of pi:\n")
(display (stream-ref accelerated-pi-stream 0)) (newline)
(display (stream-ref accelerated-pi-stream 1)) (newline)
(display (stream-ref accelerated-pi-stream 2)) (newline)
(display (stream-ref accelerated-pi-stream 3)) (newline)
(display (stream-ref accelerated-pi-stream 4)) (newline)
(display (stream-ref accelerated-pi-stream 5)) (newline)
(display (stream-ref accelerated-pi-stream 6)) (newline)
(display (stream-ref accelerated-pi-stream 7)) (newline)

;; We can accelerate the accelerated sequences recursively too!

tdefine (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

(define E (accelerated-sequence euler-transform pi-stream))

(newline)
(display "Even more accelerated approximation of pi:\n")
(display (stream-ref E 0)) (newline)
(display (stream-ref E 1)) (newline)
(display (stream-ref E 2)) (newline)
(display (stream-ref E 3)) (newline)
(display (stream-ref E 4)) (newline)
(display (stream-ref E 5)) (newline)
(display (stream-ref E 6)) (newline)
(display (stream-ref E 7)) (newline)
