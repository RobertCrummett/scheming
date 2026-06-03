#lang sicp

(define (my-memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(display (memq 'apple '(pear banana prune)))
(newline)
(display (memq 'apple '(x (apple sauce) y apple pear)))
(newline)

(define (my-equal? 1st 2nd)
  (cond ((or (null? 1st) (null? 2nd)) true)
        ((not (eq? (car 1st) (car 2nd))) false)
        (else (my-equal? (cdr 1st) (cdr 2nd)))))

(newline)
(display "True?  ")
(display (equal? '(apple banana pear) '(apple banana pear)))
(newline)
(display "False? ")
(display (equal? '(apple banana pear tomato) '(apple banana pear)))
(newline)
(display "False? ")
(display (equal? '(apple banana pear) '(apple banana pear tomato)))
(newline)
(display "False? ")
(display (equal? '(apple banana pear orange) '(apple banana pear tomato)))
