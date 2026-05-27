; Multiplication by repeated addition.
(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

(display (* 5 41))
(newline)

; But this is a recursive procedure, not an iterative one.
; Use invariant that $b \cdot a + sum = 0$
(define (* a b)
  (define (accumulate a b sum)
    (if (= b 0)
      sum
      (accumulate a (- b 1) (+ sum a))))
  (accumulate a b 0))

(display (* 5 41))
(newline)

; Both algorithms still have a linear number of steps. However,
; can get logarithmically scaling by using double and halve
(define (double a)
  (+ a a))

(define (halve a)
  (define (dec k times)
    (if (= k 0)
      times
      (dec (- k 2) (+ times 1))))
  (dec a 0))

(define (* a b)
  (define (accumulate a b sum)
    (cond ((= b 0) sum)
          ((even? b) (accumulate (double a) (halve b) sum))
          (else (accumulate a (- b 1) (+ sum a)))))
  (accumulate a b 0))

(display (* 5 41))
(newline)

(exit)
