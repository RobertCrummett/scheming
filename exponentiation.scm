; Linear recursive process => THETA(n) steps and THETA(n) space
(define (expt b n)
  (if (= n 0)
    1
    (* b (expt b (- n 1)))))

(display (expt 2 8))
(newline)

; Linear iterative process => THETA(n) steps and THETA(1) space
(define (expt b n)
  (define (iter counter product)
    (if (= counter 0)
      product
      (iter (- counter 1) (* b product))))
  (iter n 1))

(display (expt 2 8))
(newline)

(exit)
