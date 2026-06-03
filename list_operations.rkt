#lang sicp
(define (my-list-ref items n)
  (if (= n 0)
    (car items)
    (my-list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25 36))

(newline)
(display (my-list-ref squares 3))
(newline)
(display (list-ref squares 3))

(define (my-length items) ; Recursive procedure
  (if (null? items)
    0
    (+ 1 (my-length (cdr items)))))

(define (my-length items) ; Iterative procedure
  (define (length-iter a count)
    (if (null? a)
      count
      (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

(define odds (list 1 3 5 7))

(newline)
(newline)
(display (my-length odds))
(newline)
(display (length odds))

(define (my-append list1 list2) ; Recursive procedure
  (if (null? list1)
    list2
    (cons (car list1) (my-append (cdr list1) list2))))

(newline)
(newline)
(display (my-append odds squares))
(newline)
(display (append odds squares))

; Warning. Error on empty list input.
(define (last-pair items)
  (define (lagged-iter current last)
    (if (null? current)
      last
      (lagged-iter (cdr current) current)))
  (if (null? items)
    (error #f "last-pair: empty list")
    (lagged-iter (cdr items) items)))

(newline)
(newline)
(display (last-pair squares))

(define (my-reverse items)
  (define (reversal-iter partial reversed)
    (if (null? partial)
      reversed
      (reversal-iter (cdr partial) (cons (car partial) reversed))))
  (reversal-iter items nil))

(newline)
(newline)
(display (my-reverse squares))
(newline)
(display (reverse squares))

