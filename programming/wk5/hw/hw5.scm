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
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

;; 1.2.29b: Define a procedure `total-weight` that returns the total weight of the mobile.
(define (weight? branch)
  (not (pair? (branch-structure branch))))

(define (get-weight branch)
  (cadr branch))

(define (total-weight mobile)
  (cond ((number? mobile) 0)
        ((weight? mobile) (get-weight mobile))
        (else (+
               (total-weight (left-branch mobile))
               (total-weight (right-branch mobile))))))

