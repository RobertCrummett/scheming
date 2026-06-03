#lang sicp

; This was tough to think through, even after looking up the solution.

(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(display (subsets (list 1 2 3)))

; So thinking through this, I begin at the base case.
; => rest is (nil)
; => (car s) is 3
; => map (lambda (x) (cons (car s) x)) rest => (cons 3 nil) => (3)
; After being appended to rest, the returned value is the two element list (nil 3)
;
; This is returned from subsets into the previous stack frame. In this frame
; => rest is (nil 3)
; => (car s) is 2
; => map (lambda (x) (cons (car s) x)) rest => (cons 2 nil) and (cons 2 3)
;                                           => (2 nil) and (2 3) => (2) and (2 3)
; So the next rest is (nil 3 2 (2 3))
;
; This process will continue, each time duplicating the current rest list but
; appending a new number to the second.
