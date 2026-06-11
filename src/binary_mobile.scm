#lang sicp
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define left-branch car)
(define right-branch (lambda (x) (car (cdr x))))

(define branch-length car)
(define branch-structure (lambda (x) (car (cdr x))))

(define (total-weight mobile)
  (define (branch-weight branch)
    (let ((structure (branch-structure branch)))
      (if (pair? structure)
        (total-weight structure)
        structure)))
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; This function computes the total-weight of a mobile.
(define (total-weight mobile)
  (if (pair? mobile)
    (+ (total-weight (branch-structure (left-branch mobile)))
       (total-weight (branch-structure (right-branch mobile))))
    mobile))

(define my-mobile (make-mobile (make-branch 10 5)
                               (make-branch 5 (make-mobile (make-branch 2 2)
                                                           (make-branch 1 1)))))

(newline)
(display my-mobile)
(newline)
(newline)
(display (branch-structure (left-branch my-mobile)))
(newline)
(display (right-branch my-mobile))
(newline)
(display (total-weight my-mobile))

; If the constructors change, only the getters need to be modified to make
; the rest of the code work.

