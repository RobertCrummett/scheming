#lang sicp

;; A stream of all ones!
(define ones (cons-stream 1 ones))

;; Element-wise addition to get the result of the numbers.

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

(define twos (add-streams ones ones))

;; or define the integers like this:

(define integers
  (cons-stream 1 (add-streams one integers)))

;; instead of like:
;;
;; (define (integers-starting-from n)
;;   (cons-stream n (integers-starting-from (+ n 1))))
;; (define integers (integers-starting-from 1))

;; In the same style, we can create Fibonacci numbers

(define fibs
  (cons-stream 0
               (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))
