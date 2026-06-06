#lang sicp

(define (assoc key records key-equal?)
  (cond ((null? records) false)
        ((key-equal? key (caar records)) (car records))
        (else (assoc key (cdr records) key-equal?))))

(define (make-table key-equal?)
  (let ((local-table (list '*table*)))

    (define (make-subtable-chain keys value)
      (if (null? (cdr keys))
          (cons (car keys) value)
          (list (car keys) (make-subtable-chain (cdr keys) value))))

    (define (split-keys-and-value lst)
      (if (null? (cdr lst))
          (cons '() (car lst))
          (let ((rest (split-keys-and-value (cdr lst))))
            (cons (cons (car lst) (car rest)) (cdr rest)))))

    (define (lookup . keys)
      (define (iter current-table remaining-keys)
        (let ((subtable (assoc (car remaining-keys) (cdr current-table) key-equal?)))
          (if subtable
              (if (null? (cdr remaining-keys))
                  (cdr subtable)
                  (iter subtable (cdr remaining-keys)))
              false)))
      (if (null? keys) false (iter local-table keys)))

    (define (insert! . keys-and-value)
      (let ((split (split-keys-and-value keys-and-value)))
        (let ((all-keys (car split)) (value (cdr split)))

          (define (iter current-table remaining-keys)
            (let ((subtable (assoc (car remaining-keys) (cdr current-table) key-equal?)))
              (if subtable
                  (if (null? (cdr remaining-keys))
                      (set-cdr! subtable value)
                      (iter subtable (cdr remaining-keys)))
                  (set-cdr! current-table
                            (cons (make-subtable-chain remaining-keys value)
                                  (cdr current-table))))))
          (if (not (null? all-keys))
              (iter local-table all-keys))
          'ok)))

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define operation-table (make-table equal?))
(define get (operation-table 'loopup-proc))
(define put (operation-table 'insert-proc!))
