; Church numerals.
; Church numerals are actions, not objects. Apply f to x zero times:

(define zero
  (lambda (f)
    (lambda (x) x))) ; ZERO APPICATION OF F

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

; Now to define one and two directly.

(define one
  (lambda (f)
    (lambda (x)
      (f x)))) ; ONE APPLICATION OF F

(define two
  (lambda (f)
    (lambda (x)
      (f (f x))))) ; TWO APPLICATION OF F

(exit)
