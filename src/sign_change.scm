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

(define ones (cons-stream 1 ones))

(define (sign-change-detector current last-value)
  ;;; Zero is considered positive; therefore, we require unary negations.
  (cond ((and (positive? (- current)) (negative? (- last-value)))  1)
        ((and (negative? (- current)) (positive? (- last-value))) -1)
        (else 0)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
    (sign-change-detector
      (stream-car input-stream)
      last-value)
    (make-zero-crossings
      (stream-cdr input-stream)
      (stream-car input-stream))))

;;; Placeholder sensor data here
(define sense-data ones)

(define zero-crossings
  (make-zero-crossings sense-data 0))

(define zero-crossings
  (stream-map sign-change-detector
	      sense-data
	      (cons-stream 0 sense-data)))
