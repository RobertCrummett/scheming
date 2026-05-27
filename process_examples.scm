(define (inc a) (+ a 1))
(define (dec a) (- a 1))

; IMPLEMENTATION ONE, a recursive procedure
(define (+ a b)
  (if (= a 0)
    b
    (inc (+ (dec a) b))))

(define a 5)
(define b 4)
(display (format "a + b = ~a~%" (+ a b)))

; IMPLEMENTATION TWO
;
; This implementation is an interative procedure, and so it
; can be said to be tail-recursive. All of the state is contained
; in the arguments. Of the former implementation, the same cannot
; be said; it must be a recursive procedure.
(define (+ a b)
  (if (= a 0)
    b
    (+ (dec a) (inc b))))

(display (format "a + b = ~a~%" (+ a b)))

(exit)
