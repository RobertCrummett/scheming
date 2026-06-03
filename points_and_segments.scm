#lang sicp
; Constructors and selectors for points
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

; Constructors and selectors for segments
(define (make-segment r s)
  (cons r s))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

; Procedures on segments
(define (average x y)
  (/ (+ x y) 2.0))

(define (midpoint-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (make-point (average (x-point start) (x-point end))
                (average (y-point start) (y-point end)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define start (make-point -1 -1))
(define end (make-point 2 4))

(print-point start)
(print-point end)

(define seg (make-segment start end))

(print-point (midpoint-segment seg))

