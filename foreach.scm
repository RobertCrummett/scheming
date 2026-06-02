(for-each (lambda (x)
            (newline)
            (display x))
          (list 57 321 88))

; This is an implementation of a recursive process

(define (my-for-each proc items)
  (if (null? items)
    #t
    (begin
      (proc (car items))
      (my-for-each proc (cdr items)))))

(newline)
(my-for-each (lambda (x)
               (newline)
               (display x))
             (list 13 24 35))

; This is an implementation of an iterative process

(define (my-for-each proc items)
  (define (loop xs)
    (if (null? xs)
      #t
      (begin
        (proc (car xs))
        (loop (cdr xs)))))
  (loop items))

(newline)
(my-for-each (lambda (x)
               (newline)
               (display x))
             (list 14 25 36))

(exit)
