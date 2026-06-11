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

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))

(define double (cons-stream 1 (scale-stream double 2)))
