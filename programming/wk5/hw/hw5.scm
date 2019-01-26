;; 1.2.29: Binary mobiles

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; 1.2.29a: Write the corresponding selectors `left-branch` and `right-branch`, which return the branches of a mobile,
;;          and `branch-length` and `branch-structure`, which return the components of a branch.

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

;; 1.2.29b: Define a procedure `total-weight` that returns the total weight of the mobile.
(define (branch? branch)
  (not (null? (branch-structure branch))))

;; todo: fix this because it doesn't work as expected
(define (weight? branch)
  (not (pair? (branch-structure branch))))

(define (get-weight branch)
  (cadr branch))

(define (total-weight mobile)
  (cond ((branch? mobile) (get-weight mobile)) ;; this is a stopping point, though -- :thinking:
        ((weight? mobile) (get-weight mobile))
        (else (+ (total-weight (left-branch mobile))
                 (total-weight (right-branch mobile))))))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

