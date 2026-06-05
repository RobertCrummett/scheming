#lang sicp

;; Monte-Carlo integration

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (let ((area (* (- y2 y1) (- x2 x1)))
        (proc (lambda () (P (random-in-range x1 x2) (random-in-range y1 y2)))))
    (* area (monte-carlo trials proc))))

;; Estimate $\pi$

(define (square x) (* x x))

(define (estimate-pi trials)
  (let ((x-center 5.0) (y-center 7.0) (radius 3.0))
    (let ((radius-squared (square radius)))
      (/ (estimate-integral
           (lambda (x y)
             (<= (+ (square (- x x-center))
                    (square (- y y-center)))
                 radius-squared))
           (- x-center radius)
           (+ x-center radius)
           (- y-center radius)
           (+ y-center radius)
           trials)
         radius-squared))))

(define (count-digits n)
  (let ((sign (if (< n 0) 1 0)))
    (if (> (abs n) 9)
        (+ sign 1 (count-digits (abs (quotient n 10))))
        (+ sign 1))))

(define (left-pad num width)
  (define (iter size result)
    (if (> size 0)
        (iter (- size 1) (string-append " " result))
        result))
  (string-append (iter (- width (count-digits num)) "")
                 (number->string num)))

(for-each (lambda (it)
            (display "Estimate pi with ")
            (display (left-pad it 6))
            (display " iterations: ")
            (display (estimate-pi it))
            (newline))
          '(100 1000 10000 100000))
