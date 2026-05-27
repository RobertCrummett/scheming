; IMPLEMENTATION ONE
(define (>= x y)
  (or (> x y) (= x y)))

; IMPLEMENTATION TWO
(define (>= x y)
  (not (< x y)))

(exit)
