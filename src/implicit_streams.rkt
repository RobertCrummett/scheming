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

(define (add-streams s1 s2) (stream-map + s1 s2))
(define (mul-streams s1 s2) (stream-map * s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define ones (cons-stream 1 ones))
(define (integers-starting-from n)
  (cons-stream n (add-streams ones (integers-starting-from n))))

(define factorials
  (cons-stream 1 (mul-streams factorials
                              (integers-starting-from 2))))

;; Alternatively, we can use the natural numbers directly:
;;
;; (define integers
;;   (cons-stream 1 (add-streams ones integers)))
;; (define factorials
;;   (cons-stream 1 (mul-streams factorials
;;                               (stream-cdr integers))))

(display (stream-ref factorials 0)) (newline)
(display (stream-ref factorials 1)) (newline)
(display (stream-ref factorials 2)) (newline)
(display (stream-ref factorials 3)) (newline)
(display (stream-ref factorials 4)) (newline)

; We can either use recursive addition of iterated streams
; or recursive scaling to get the exact same result.

(define s (cons-stream 1 (add-streams s s)))  ;; Both sequences produce powers of two
(define t (cons-stream 1 (scale-stream s 2))) 

(newline)
(display (stream-ref s 0)) (newline)
(display (stream-ref s 1)) (newline)
(display (stream-ref s 2)) (newline)

(newline)
(display (stream-ref t 0)) (newline)
(display (stream-ref t 1)) (newline)
(display (stream-ref t 2)) (newline)

;; Partial sums

;; (define (partial-sums stream)
;;   (cons-stream 0
;;                (add-streams (scale-stream ones (stream-car stream))
;;                             (partial-sums (stream-cdr stream)))))

;; Accidentily wrote a function that repeatedly multiplies the result by three.
;; Not sure how yet!
;;
;; (define (mystery stream)
;;   (define s
;;     (cons-stream (stream-car stream)
;;                  (add-streams (mystery (stream-cdr stream)) s)))
;;   s)
;;
;; EXPLANATION relies on a key idea: a stream growing by a constant factor
;; K, the result of (stream-cdr stream) = (scale-stream stream K)
(define (upgrade-power-base stream)
  (define output-stream
    (cons-stream (stream-car stream)
                 (add-streams (upgrade-power-base (stream-cdr stream)) 
                              output-stream)))
  output-stream)

(define powers-of-two   (upgrade-power-base ones))
(define powers-of-three (upgrade-power-base powers-of-two))
(define powers-of-four  (upgrade-power-base powers-of-three)) ;; Wow!

(newline)
(display "Powers of three\n")
(display (stream-ref powers-of-three 0)) (newline)
(display (stream-ref powers-of-three 1)) (newline)
(display (stream-ref powers-of-three 2)) (newline)
(display (stream-ref powers-of-three 3)) (newline)
(display (stream-ref powers-of-three 4)) (newline)

(newline)
(display "Powers of four:\n")
(display (stream-ref powers-of-four 0)) (newline)
(display (stream-ref powers-of-four 1)) (newline)
(display (stream-ref powers-of-four 2)) (newline)
(display (stream-ref powers-of-four 3)) (newline)
(display (stream-ref powers-of-four 4)) (newline)

;; What this reveals is that the additive definition of the
;; powers of two extends to higher powers as well!
;; Clearly the sclaing version also extends. The equivalence
;; of these two approaches is therefore independent of the
;; constant factor. This was very difficult for me to see.

;; Partial sums

(define (partial-sums stream)
  (define s
    (cons-stream (stream-car stream)
                 (add-streams (stream-cdr stream) s)))
  s)

(define pst (partial-sums t))

(newline)
(display "Partial sums:\n")
(display (stream-ref t 0)) (display " ") (display (stream-ref pst 0)) (newline)
(display (stream-ref t 1)) (display " ") (display (stream-ref pst 1)) (newline)
(display (stream-ref t 2)) (display " ") (display (stream-ref pst 2)) (newline)
(display (stream-ref t 3)) (display " ") (display (stream-ref pst 3)) (newline)
(display (stream-ref t 4)) (display " ") (display (stream-ref pst 4)) (newline)
