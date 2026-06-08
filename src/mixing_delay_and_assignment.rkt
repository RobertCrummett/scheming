#lang sicp

(define the-empty-stream '())
(define stream-null? null?)

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
       the-empty-stream
       (cons-stream
         (apply proc (map stream-car argstreams))
         (apply stream-map
                (cons proc (map stream-cdr argstreams))))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
        low
        (stream-enumerate-interval (+ low 1) high))))

(define (display-line x) (newline) (display x))

;; EXAMPLE
;; Try to figure out what will be printed when evaluating
;; each response.

(define (show x) (display-line x) x)

(define x
  (stream-map show
              (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)

;; This is tough for me to wrap my head around. So
;; obviously the first call produces:
;;
;; 0
;; 1
;; 2
;; 3
;; 4
;; 55
;;
;; Where the '55' at the end is really just '5' printed
;; twice without a newline.
;;
;; So I guess this sequence of 6 thunks exists in memory now.
;; So stream map has called 'show' on the previous 6 elements
;; already, which outputs a list of values (not procedures).
;; 
;; So if (stream-ref x 2) is called, nothing gets printed
;; except the returned value, 2. This is because the displays
;; have already been applied.
;;
;; So if (stream-ref x 7) is called after, only the delayed
;; portions of the stream get displayed and the result is
;; returned as before:
;;
;; ...
;; 4
;; 55              <- previous call
;;                 <- newline from previous call
;; 6               <- the beginning of this call
;; 77              <- '7' printed and '7' returned
;;
;; This is interesting to me!
