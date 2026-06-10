#lang sicp

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map (cons proc (map stream-cdr argstreams))))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))

;; Merge two streams ordered streams into a single ordered stream.
;; Streams should be ordered with the '<' operator.
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream
                   s2car
                   (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1) (stream-cdr s2)))))))))

;; Richard Hamming's stream
(define S (cons-stream
           1
           (merge
            (scale-stream S 2)
            (merge
             (scale-stream S 3)
             (scale-stream S 5)))))

(define (stream-ref stream n)
  (if (= n 0)
      (stream-car stream)
      (stream-ref (stream-cdr stream) (- n 1))))

(newline)
(display "Hamming's sequence\n")
(display (stream-ref S 0)) (newline)
(display (stream-ref S 1)) (newline)
(display (stream-ref S 2)) (newline)
(display (stream-ref S 3)) (newline)
(display (stream-ref S 4)) (newline)
(display (stream-ref S 5)) (newline)
(display (stream-ref S 6)) (newline)
(display (stream-ref S 7)) (newline)
(display (stream-ref S 8)) (newline)
