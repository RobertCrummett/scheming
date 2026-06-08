#lang sicp

(define (make-account balance account-password)
  (define call-the-cops (lambda (unused) "Call the cops!"))
  (let ((failed-logins 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin
            (set! balance (- balance amount))
            balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (dispatch password m)
      (if (eq? password account-password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT"
                           m)))
        (begin
          (set! failed-logins (+ failed-logins 1))
          (if (>= failed-logins 7)
              call-the-cops
              (lambda (unused) "Incorrect password")))))
    dispatch))

(define acc (make-account 100 'secret-password))

(display ((acc 'secret-password 'withdraw) 50))
(newline)
(display ((acc 'secret-password 'withdraw) 60))
(newline)
(display ((acc 'secret-password 'deposit) 40))
(newline)
(display ((acc 'extra-secret-password 'withdraw) 60))
(newline)
(newline)

;; Experiment: Does this have the same behavior?

(define acc2 (make-account 100 'secret-password))

(define withdraw (acc2 'secret-password 'withdraw))
(define deposit  (acc2 'secret-password 'deposit))

(display (withdraw 50))
(newline)
(display (withdraw 60))
(newline)
(display (deposit 40))
(newline)
(display (withdraw 60))

;; It does!!
