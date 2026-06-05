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

(display "Estimate pi with    100 iterations: ")
(display (estimate-pi 100))
(newline)
(display "Estimate pi with   1000 iterations: ")
(display (estimate-pi 1000))
(newline)
(display "Estimate pi with  10000 iterations: ")
(display (estimate-pi 10000))
(newline)
(display "Estimate pi with 100000 iterations: ")
(display (estimate-pi 100000))
(newline)
