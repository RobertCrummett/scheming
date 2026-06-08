#lang sicp

;; Same as previous implementation of the queue, except this
;; time instead of modifying a pair of pointers, we build
;; the queue as a procedure with local state.

;; This example underscores the equipotence of assignment
;; and mutation. Either can be defined in terms of the other.

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (insert! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               (values))
              (else
               (set-cdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)
               (values)))))
    (define (delete!)
      (cond ((empty-queue?)
             (error "DELETE called with an empty queue"))
            (else
             (set! front-ptr (cdr front-ptr))
             (values))))
    (define (show)
      (display front-ptr))
    (define (dispatch m)
      (cond ((eq? m 'insert!) insert!)
            ((eq? m 'delete!) delete!)
            ((eq? m 'show) show)
            (else (error "Unknown message: DISPATCH" m))))
    dispatch))

(define q (make-queue))

(define insert-queue! (lambda (q a) ((q 'insert!) a)))
(define delete-queue! (lambda (q) ((q 'delete!))))
(define show-queue    (lambda (q) ((q 'show))))

(display "Original: ")
(show-queue q)
(newline)

(display "Insert a: ")
(insert-queue! q 'a)
(show-queue q)
(newline)

(display "Insert b: ")
(insert-queue! q 'b)
(show-queue q)
(newline)

(display "Delete a: ")
(delete-queue! q)
(show-queue q)
(newline)

(display "Insert c: ")
(insert-queue! q 'c)
(show-queue q)
(newline)
