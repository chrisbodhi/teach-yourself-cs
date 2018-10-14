;; 1a. 1.16: Design a procedure that evolves an iterative exponentiation
;;           process that uses successive squaring and uses a logarithmic
;;           number of steps, as does `fast-expt`.

(define (fast-expt-iter b n)
  (iter-expt 1 b n))

;; does not use successive squaring...
(define (iter-expt-without base n a)
  (if (= n 0)
      a
      (iter-expt base (- n 1) (* a base))))

(define (iter-expt a base n)
  (define (square num) (* num num))
  (define (even? num) (= 0 (remainder num 2)))
  (cond ((= n 0) a)
        ((even? n) (iter-expt a (square base) (/ n 2)))
        (else (iter-expt (* a base) base (- n 1)))))

(fast-expt-iter 2 10) ;; 1024

;; 1b. 1.35: Show that the golden ratio is a fixed point of the
;;           transformation x -> 1 + 1/x, and use this fact to
;;           compute by means of the fixed-point procedure.

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)


;; 1c. 1.37a: Define a procedure `cont-frac` such that evaluating
;;            `(cont-frac n d k)` computes the value of the k-term
;;            finite continued fraction.

(define (n i) 1.0)
(define (d i) 1.0)
(define (cont-frac n d k)
  (if (= k 0)
      1
      (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

;; (define k 10) to get 0.6180
(cont-frac n d 10)
;; => 0.6180555...

;; 1c. 1.37b: If that was recursive, re-write it iteratively.
(define (n i) 1.0)
(define (d i) 1.0)
(define (b-cont-frac n d k)
  (cont-frac-iter n d k 1.0))

(define (cont-frac-iter n d k a)
  (if (= k 0)
      a
      (cont-frac-iter n d (- k 1) (/ (n k) (+ (d k) a)))))

(b-cont-frac n d 10)
;; => 0.6180555...

;; 1d. 1.38: Write a program that uses your `cont-frac` procedure
;;           from exercise 1.37 to approximate e, based on Euler's
;;           expansion.

(define (make-d k)
  (iter-make k '(1 2 1)))

(define (iter-make k s)
  (if (>= (length s) k)
      s
      (iter-make k (se s (next-triplet s)))))

(define (next-triplet s)
  (se '(1) (get-next-n s) '(1)))

(define (get-next-n s)
  (+ 2 (get-num s)))

(define (get-num s)
  (last (butlast s)))

(define (truncate-sentence n s)
  (if (= (length s) n)
      s
      (truncate-sentence n (butlast s))))

(define (d-euler i)
  (last (truncate-sentence i (make-d i))))

(define (n i) 1.0)

(define (euler-expansion n d-euler k)
  (+ 2 (cont-frac n d-euler k)))

(euler-expansion n d-euler 3)
;; => 2.71428571

(euler-expansion n d-euler 10)
;; => 2.53546511
;; /shrug

