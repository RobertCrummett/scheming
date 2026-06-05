#lang sicp

;; IMPLEMENTATION ONE

(define balance 100)
(define (withdraw amount)
  (if (>= balance amount)
      (begin
        (set! balance (- balance amount))
        balance)
      "Insufficient funds"))

(display "First withdraw implementation:\n")
(display "balance := ")
(display (withdraw 25))
(display " (global)\n")
(display "balance := ")
(display (withdraw 25))
(display " (global)\n")
(display "balance := ")
(display (withdraw 25))
(display " (global)\n")

;; IMPLEMENTATION TWO

(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
          (begin
            (set! balance (- balance amount))
            balance)
          "Insufficient funds"))))

(newline)
(display "Second withdraw implementation:\n")
(display "balance := ")
(display (new-withdraw 15))
(newline)
(display "balance := ")
(display (new-withdraw 15))
(newline)
(display "balance := ")
(display balance)
(display " (global)\n")
