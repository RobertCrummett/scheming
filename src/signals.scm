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

;;; An implicit definition of a definite integral
(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
		 (add-streams (scale-stream integrand dt)
			      int)))
  int)

;;; Voltage of a circuit as a stream, given a stream of current values
(define ones (cons-stream 1 ones))

(define (RC R C dt)
  (lambda (current capacitor-voltage)
    (add-streams (scale-stream ones capacitor-voltage)
		 (add-streams (scale-stream (integral current 0.0 dt) (/ 1.0 C))
			      (scale-stream current R)))))

(define RC1 (RC 5 1 0.5))
