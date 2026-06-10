#lang sicp

;; These are the basic procedures called over
;; and over again to estimate the square root
;; in our original formulation.

(define (average . args)
  (/ (apply + args)
     (length args)))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

;; Rather than treating the guess as a state
;; variable, we can treat the guess as an
;; infinite stream of successive guesses.

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
       the-empty-stream
       (cons-stream
         (apply proc (map stream-car argstreams))
         (apply stream-map
                (cons proc (map stream-cdr argstreams))))))

(define (sqrt-stream x)
  (define guesses
    (cons-stream
      1.0
      (stream-map (lambda (guess) (sqrt-improve guess x))
		  guesses)))
  guesses)

(define (stream-ref stream n)
  (if (= n 0)
    (stream-car stream)
    (stream-ref (stream-cdr stream) (- n 1))))

(define sqrt2 (sqrt-stream 2))

(display "Estimating sqrt(2):\n")
(display (stream-ref sqrt2 0)) (newline)
(display (stream-ref sqrt2 1)) (newline)
(display (stream-ref sqrt2 2)) (newline)
(display (stream-ref sqrt2 3)) (newline)
(display (stream-ref sqrt2 4)) (newline)
(display (stream-ref sqrt2 5)) (newline)
