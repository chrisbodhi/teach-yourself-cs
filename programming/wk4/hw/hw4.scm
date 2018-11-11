;; exercises 2.7, 2.8, 2.10, 2.12, 2.17, 2.20, 2.22, 2.23

;; Exercise 2.7: Alyssa's program is incomplete because she has not specified the implementation of the interval abstraction.
;;               Here is a definition of the interval constructor:
                 (define (make-interval a b) (cons a b))
;;               Define selectors upper-bound and lower-bound to complete the implementation.

(define (upper-bound interval)
  (cdr interval))

(define (lower-bound interval)
  (car interval))

;; Exercise 2.8: Using reasoning analogous to Alyssa's, describe how the difference of two intervals may be computed. Define a
;;               corresponding subtraction procedure, called `sub-interval`.

;; "She reasons that the minimum value the sum could be is the sum of the two lower bounds and the maximum value it could be is
;;  the sum of the two upper bounds." Therefore, we will reason that the minimum value will be the absolute value of lesser lower bound subtracted
;;  from the greater lower bound, and likewise with the upper bounds.


(define (sub-interval x y)
  (make-interval (abs (- (lower-bound x) (lower-bound y)))
                 (abs (- (upper-bound x) (upper-bound y)))))

;; Exercise 2.10: Ben Bitdiddle, an expert systems programmer, looks over Alyssa's shoulder and comments that it is not clear what it means
;;                to divide by an interval that spans zero. Modify Alyssa's code to check for this condition and to signal an error if it occurs.

;; From SICP:
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;; Also from SICP:
(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (safe-div-interval x y))
