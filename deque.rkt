#lang sicp

(define (make-node value prev next)
  (cons value (cons prev next)))

(define (node-value node) (car node))
(define (node-prev node) (car (cdr node)))
(define (node-next node) (cdr (cdr node)))

(define (set-prev! node new-prev) (set-car! (cdr node) new-prev))
(define (set-next! node new-next) (set-cdr! (cdr node) new-next))

(define (make-deque) (cons '() '()))
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))

(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (empty-deque? deque) (null? (front-ptr deque)))

(define (front-insert-deque! deque item)
  (let ((new-node (make-node item '() '())))
    (cond ((empty-deque? deque)
            (set-front-ptr! deque new-node)
            (set-rear-ptr! deque new-node)
            deque)
          (else
            (set-next! new-node (front-ptr deque))
            (set-prev! (front-ptr deque) new-node)
            (set-front-ptr! deque new-node)
            deque))))

(define (rear-insert-deque! deque item)
  (let ((new-node (make-node item '() '())))
    (cond ((empty-deque? deque)
            (set-front-ptr! deque new-node)
            (set-rear-ptr! deque new-node)
            deque)
          (else
            (set-prev! new-node (rear-ptr deque))
            (set-next! (rear-ptr deque) new-node)
            (set-rear-ptr! deque new-node)
            deque))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
          (error "FRONT-DELETE! called with empty deque" deque))
        ((eq? (front-ptr deque) (rear-ptr deque))
          (set-front-ptr! deque '())
          (set-rear-ptr! deque '())
          deque)
        (else
          (set-front-ptr! deque (node-next (front-ptr deque)))
          (set-prev! (front-ptr deque) '())
          deque)))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
          (error "REAR-DELETE! called with empty deque" deque))
        ((eq? (front-ptr deque) (rear-ptr deque))
          (set-front-ptr! deque '())
          (set-rear-ptr! deque '())
          deque)
        (else
          (set-rear-ptr! deque (node-prev (rear-ptr deque)))
          (set-next! (rear-ptr deque) '())
          deque)))

(define q (make-deque))

(rear-insert-deque! q 'a)
(rear-insert-deque! q 'b)
(rear-insert-deque! q 'c)
(rear-insert-deque! q 'd)
(rear-delete-deque! q)
(rear-delete-deque! q)
(front-insert-deque! q 'c)
(front-insert-deque! q 'd)
(front-delete-deque! q)
(front-delete-deque! q)
(front-delete-deque! q)
