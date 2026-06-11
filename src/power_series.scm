#lang sicp

;; Power series as streams

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

(define ones (cons-stream 1 ones))

(define natural-nums
  (cons-stream 1 (add-streams ones natural-nums)))

;; IMPLEMENTATION ONE (element-wise reciprocation)
(define harmonic-series
  (div-streams ones natural-nums))

(define (partial-application proc stream)
  ;; Abstraction of the partial sum function. This will
  ;; partially apply any function that reduces two streams
  ;; to one stream.
  (define s
    (cons-stream (stream-car stream)
                 (proc (stream-cdr stream) s)))
  s)

(define (partial-prod stream)
  (partial-application mul-streams stream))

;; IMPLEMENTATION TWO (telescoping ratios of offset natural nums)
(define ratios-of-natural-nums
  (div-streams natural-nums (stream-cdr natural-nums)))

(define harmonic-series-2
  (partial-prod ratios-of-natural-nums))

(define (integrate-series stream)
  (mul-streams stream harmonic-series))

;; Since the functon $e^x$ is its own derivative, it is also
;; its own integral. The series of this function can be generated
;; as follows:
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

;; We can pull tricks with the trig functions as well:
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
;; Because delayed evaluation from the cons-stream special form, we
;; are safe to use sine-series before we define it, so long as we
;; define it before we force the cdr of this stream.

;; Power series can be represented as a series S, which itself
;; is defined in terms of a tail series T: $S = a + x \cdot T$
;;
;; The product of two power series is therefore:
;; $ S_1 \cdot S_2 = (a_1 + x \cdot T_1) \cdot (a_2 + x \cdot T_2)    $
;; $               = a_1 \cdot a_2 + a_1 \cdot x \cdot T_2 +          $
;; $                 a_2 \cdot x \cdot T_1 + x^2 \cdot T_1 \cdot T_2  $
;; and so we have
;; $ S_1 S_2 = a_1 a_2 + x (a_1 T_2 + a_2 T_1) + x^2 T_1 T_2          $
;; This is a recursive definition of a product of series.
;;         (product of series in terms of product of tail series)
;;
;; Multiplication of series is therefore given by
;; $ S_1 S_2 = a_1 a_2 + x (a_1 T_2 + a_2 T_1 + x T_1 T_2)            $
;;
;; The second term can be solved for by
;; $ S_1 T_2 = (a_1 + x T_1) T_2 = a_1 T_2 + T_1 T_2                  $
;; so we need to add $a_2 \cdot T_1$ to this to get our recursive of a
;; multiplication of series is terms of a series.
(define (mul-series s1 s2)
  (cons-stream 
    (* (stream-car s1) (stream-car s2))
    (add-streams
      (scale-stream (stream-cdr s2) (stream-car s1))
      (mul-series (stream-cdr s1) s2))))
;; NOTE The second term can also be solved for by adding $a_1 T_2$ to
;; $ S_2 T_1 = (a_2 + x T_2) T_1 = a_2 T_1 + T_2 T_1                  $
;; which verifies that mutliplication of series is commutative.

;; We demonstrate that $\cos(x)^2 + \sin(x)^2 = 1$:

(define (square-series stream) (mul-series stream stream))

(define just-one
  (add-streams (square-series cosine-series)
	       (square-series sine-series)))

(display "This should be just one:\n")
(display (stream-ref just-one 0)) (display ", ")
(display (stream-ref just-one 1)) (display ", ")
(display (stream-ref just-one 2)) (display ", ")
(display (stream-ref just-one 3)) (display ", ")
(display (stream-ref just-one 4)) (display ", ")
(display (stream-ref just-one 5)) (display ", ")
(display (stream-ref just-one 6)) (display ", ")
(display (stream-ref just-one 7)) (newline)
