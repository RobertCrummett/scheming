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

(define s (cons-stream 1 (add-streams s s)))
(define t (cons-stream 1 (scale-stream s 2))) 

(newline)
(display (stream-ref s 0)) (newline)
(display (stream-ref s 1)) (newline)
(display (stream-ref s 2)) (newline)

(newline)
(display (stream-ref t 0)) (newline)
(display (stream-ref t 1)) (newline)
(display (stream-ref t 2)) (newline)
