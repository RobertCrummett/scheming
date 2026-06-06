#lang racket
(require racket/unsafe/ops)

(define (call-with-deep-time-limit secs thunk)
  (let* ([result #f]
         [t (thread (lambda () (set! result (thunk))))])
    (if (sync/timeout secs t)
        result
        (begin (kill-thread t) #f))))

(define (test-case name proc input expected)
  (display (string-append name ": "))
  (let ([result (call-with-deep-time-limit 0.5 (lambda () (proc input)))])
    (if (not result)
        (display "FAIL (Infinite Loop / Timeout Detected)\n")
        (if (= result expected)
            (display (string-append "PASS (Got " (number->string result) ")\n"))
            (display (string-append "FAIL (Expected " (number->string expected)
                       ", got " (number->string result) ")\n"))))))

(define (run-tests proc)
  (define (last-pair x) (if (null? (cdr x)) x (last-pair (cdr x))))
  (define (make-cycle x) (unsafe-set-immutable-cdr! (last-pair x) x) x)

  ;; Case 3: Standard List
  (define example-3-actual (cons 'a (cons 'b (cons 'c '()))))
  (test-case "Testing 3-pair list" proc example-3-actual 3)

  ;; Case 4: Shared Sublist
  (define pair-z (cons 'z '()))
  (define example-4-actual (cons 'a (cons pair-z pair-z))) 
  (test-case "Testing 4-count sharing" proc example-4-actual 3)

  ;; Case 7: Maximum Sharing
  (define pair-y (cons pair-z pair-z))
  (define example-7-actual (cons pair-y pair-y))
  (test-case "Testing 7-count sharing" proc example-7-actual 3)

  ;; Case Infinite: Circular List
  (define circular-list (make-cycle (cons 'a (cons 'b (cons 'c '())))))
  (test-case "Testing infinite loop" proc circular-list 3))


;; An implementation that is not correct
(define (count-pairs-incorrect x)
  (if (not (pair? x))
      0
      (+ (count-pairs-incorrect (car x))
         (count-pairs-incorrect (cdr x))
         1)))

;; An implementation that is correct
(define (previous-pair? x previous-pairs)
  (cond ((null? previous-pairs) false)
        ((eq? x (car previous-pairs)) true)
        (else (previous-pair? x (cdr previous-pairs)))))

(define (count-distinct-pairs x)
  (let ((previous-pairs '()))
    (define (helper current)
      (cond ((not (pair? current)) 0)
            ((previous-pair? current previous-pairs) 0)
            (else
             (set! previous-pairs (cons current previous-pairs))
             (+ (helper (car current))
                (helper (cdr current))
                1))))
    (helper x)))

(run-tests count-pairs-incorrect)
(newline)

(run-tests count-distinct-pairs)
(newline)
