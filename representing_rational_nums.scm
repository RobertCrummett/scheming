(define (make-rat n d) (cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define one-half (make-rat 2 4))

(display "One half as a rational: ")
(print-rat one-half)

; We can integrate the greatest common denominator
; algorithm to get a make-rat function that reduces
; rationals to lowest terms.
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define one-half (make-rat 2 4))

(newline)
(display "One half as a rational: ")
(print-rat one-half)

; We can also handle negative signs.
(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d)))
        (sign (if (positive? (* n d))
                +
                -)))
    (cons (sign (/ (abs n) g)) (/ (abs d) g))))

(define one-half (make-rat -2 4))

(newline)
(display "One half as a rational: ")
(print-rat one-half)

(exit)
