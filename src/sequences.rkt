#lang sicp
; These are sequences!

(newline)
(display 
  (cons 1
        (cons 2
              (cons 3
                    (cons 4 nil)))))

(newline)
(display
  (list 1 2 3 4))

(define one-through-four (list 1 2 3 4))

; Print the second element.
(newline)
(display (car (cdr one-through-four)))

; View the entire list.
(define (view-list my-list)
  (newline)
  (if (null? my-list)
    (display "END")
    (begin
      (display (car my-list))
      (view-list (cdr my-list)))))

(view-list one-through-four)

