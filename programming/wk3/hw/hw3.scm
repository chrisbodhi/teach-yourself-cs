;; 1a. 1.16: Design a procedure that evolves an iterative exponentiation
;;           process that uses successive squaring and uses a logarithmic
;;           number of steps, as does `fast-expt`.

(define (fast-expt-iter b n)
  (iter-expt b n 1))

;; does not use successive squaring...
(define (iter-expt-without base n a)
  (if (= n 0)
      a
      (iter-expt base (- n 1) (* a base))))

(define (iter-expt base n a)
  (define (square num) (* num num))
  (define (even? num) (= 0 (remainder num 2)))
  (cond ((= n 0) a)
        ((even? n) (square (iter-expt base (/ n 2) a)))
        (else (iter-expt base (- n 1) (* base a)))))

(fast-expt-iter 2 10)


(define (even-iter base n a)
  (define (square num) (* num num))
  (if (= n 1)
      a
      (even-iter base (/ n 2) (square (* a base)))))

(even-iter 2 8 1)


;; 1b. 1.35: Show that the golden ratio is a fixed point of the
;;           transformation x -> 1 + 1/x, and use this fact to
;;           compute by means of the fixed-point procedure.



;; 1c. 1.37: 

;; 1d. 1.38
