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

(define (stream-ref stream n)
  (if (= n 0)
    (stream-car stream)
    (stream-ref (stream-cdr stream) (- n 1))))

(define (add-streams s1 s2) (stream-map + s1 s2))
(define (mul-streams s1 s2) (stream-map * s1 s2))
(define (div-streams s1 s2) (stream-map / s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (mul-series s1 s2)
  (cons-stream 
    (* (stream-car s1) (stream-car s2))
    (add-streams
      (scale-stream (stream-cdr s2) (stream-car s1))
      (mul-series (stream-cdr s1) s2))))

(define (invert-unit-series series)
  (define s
    (cons-stream
      1
      (scale-stream
	(mul-series (stream-cdr series) s) -1)))
  s)

;; Find the inverse of the harmonic series

(define ones (cons-stream 1 ones))

(define natural-nums
  (cons-stream 1 (add-streams ones natural-nums)))

(define harmonic-series (div-streams ones natural-nums))

(display "Harmonic series:\n")
(display (stream-ref harmonic-series 0)) (display ", ")
(display (stream-ref harmonic-series 1)) (display ", ")
(display (stream-ref harmonic-series 2)) (display ", ")
(display (stream-ref harmonic-series 3)) (display ", ")
(display (stream-ref harmonic-series 4)) (display ", ")
(display (stream-ref harmonic-series 5)) (display "...\n")

(define inverse-harmonic-series (invert-unit-series harmonic-series))

(display "Inverse of harmonic series:\n")
(display (stream-ref inverse-harmonic-series 0)) (display ", ")
(display (stream-ref inverse-harmonic-series 1)) (display ", ")
(display (stream-ref inverse-harmonic-series 2)) (display ", ")
(display (stream-ref inverse-harmonic-series 3)) (display ", ")
(display (stream-ref inverse-harmonic-series 4)) (display ", ")
(display (stream-ref inverse-harmonic-series 5)) (display "...\n")

(define just-one (mul-series harmonic-series inverse-harmonic-series))

(display "Should be just one of these series invert eachother:\n")
(display (stream-ref just-one 0)) (display ", ")
(display (stream-ref just-one 1)) (display ", ")
(display (stream-ref just-one 2)) (display ", ")
(display (stream-ref just-one 3)) (display ", ")
(display (stream-ref just-one 4)) (display ", ")
(display (stream-ref just-one 5)) (display "...\n")

(define (div-series s1 s2)
  (let ((s2car (stream-car s2)))
    (if (= s2car 0)
      (error "The first term of the denominator cannot be zero - DIV-SERIES")
      (mul-series
	(scale-stream s1 s2car)
	(invert-unit-series (scale-stream s2 (/ 1 s2car)))))))


;; Now define a power series for the tangent function
(define (integrate-series stream)
  (mul-streams stream harmonic-series))
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define tangent-series (div-series sine-series cosine-series))

(newline)
(display "Cosine power series:\n")
(display (stream-ref cosine-series 0)) (display ", ")
(display (stream-ref cosine-series 1)) (display ", ")
(display (stream-ref cosine-series 2)) (display ", ")
(display (stream-ref cosine-series 3)) (display ", ")
(display (stream-ref cosine-series 4)) (display ", ")
(display (stream-ref cosine-series 5)) (display "...\n")

(display "Sine power series:\n")
(display (stream-ref sine-series 0)) (display ", ")
(display (stream-ref sine-series 1)) (display ", ")
(display (stream-ref sine-series 2)) (display ", ")
(display (stream-ref sine-series 3)) (display ", ")
(display (stream-ref sine-series 4)) (display ", ")
(display (stream-ref sine-series 5)) (display "...\n")

(display "Tangent power series:\n")
(display (stream-ref tangent-series 0)) (display ", ")
(display (stream-ref tangent-series 1)) (display ", ")
(display (stream-ref tangent-series 2)) (display ", ")
(display (stream-ref tangent-series 3)) (display ", ")
(display (stream-ref tangent-series 4)) (display ", ")
(display (stream-ref tangent-series 5)) (display "...\n")
