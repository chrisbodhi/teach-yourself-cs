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
  (last mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (last branch))

;; 1.2.29b: Define a procedure `total-weight` that returns the total weight of the mobile.
(define (is-rod? branch)
  (not (pair? branch)))

(define (is-weight? branch)
  (not (pair? (branch-structure branch))))

(define (get-weight branch)
  (last branch))

(define (total-weight mobile)
  (cond ((is-rod? mobile) 0)
        ((is-weight? mobile) (get-weight mobile))
        (else (+
               (total-weight (left-branch mobile))
               (total-weight (right-branch mobile))))))

(total-weight (make-mobile (make-branch 1 2) (make-branch 3 4)))
;; => 6
(total-weight (make-mobile (make-branch 1 2) (make-branch (make-branch 3 4) (make-branch 5 6))))
;; => 12
(total-weight (make-mobile (make-branch (make-branch 1 2) (make-branch 7 8)) (make-branch (make-branch 3 4) (make-branch 5 6))))
;; => 20

;; 1.2.29c: Design a predicate that tests whether a binary mobile is balanced.
(define (calc-torque branch)
  (* (branch-length branch) (branch-structure branch)))

(calc-torque (make-branch 3 5))
;; => 15

(define (is-left-branch-a-mobile? mobile)
  (and
   (not (is-weight? (left-branch mobile)))
   (is-weight? (right-branch mobile))))

(is-left-branch-a-mobile? (make-mobile
                           (make-branch 2
                                        (make-mobile
                                         (make-branch 1 2)
                                         (make-branch 3 4)))
                           (make-branch 5 6)))
;; => #t

(is-left-branch-a-mobile? (make-mobile
                           (make-branch 1 2)
                           (make-branch 5 6)))
;; => #f

(define (is-right-branch-a-mobile? mobile)
  (and
   (is-weight? (left-branch mobile))
   (not (is-weight? (right-branch mobile)))))

(is-right-branch-a-mobile? (make-mobile
                            (make-branch 7
                                         (make-mobile
                                          (make-branch 1 2)
                                          (make-branch 3 4)))
                            (make-branch 5 6)))
;; => #f

(is-right-branch-a-mobile? (make-mobile
                            (make-branch 1 2)
                            (make-branch 5 6)))
;; => #f

(is-right-branch-a-mobile? (make-mobile
                            (make-branch 1 2)
                            (make-branch 7 
                                         (make-mobile
                                          (make-branch 3 4)
                                          (make-branch 5 6)))))
;; => #t

(define (are-both-sides-weights? mobile)
  (and
   (is-weight? (left-branch mobile))
   (is-weight? (right-branch mobile))))

(define (are-torques-equal? mobile)
  (equal?
   (calc-torque (left-branch mobile))
   (calc-torque (right-branch mobile))))

(define (is-balanced? mobile)
  (cond ((are-both-sides-weights? mobile)
         (are-torques-equal? mobile))
        ((is-left-branch-a-mobile? mobile)
         (is-balanced? (left-branch mobile)))
        ((is-right-branch-a-mobile? mobile)
         (is-balanced? (right-branch mobile)))
        (else (equal?
               (is-balanced? (left-branch mobile))
               (is-balanced? (right-branch mobile))))))


;; "dynamic wind" in japanese is "Dainamikku kaze"

(is-balanced? (make-mobile (make-branch 1 5) (make-branch 5 1)))
;; => #t

(is-balanced? (make-mobile (make-branch 4 6) (make-branch 3 (make-mobile (make-branch 2 3) (make-branch 2 2)))))
;; => #f

(is-balanced? (make-mobile (make-mobile (make-branch 4 6) (make-branch 1 1)) (make-branch (make-branch 2 3) (make-branch 2 3))))
;; => #f

(is-balanced? (make-mobile (make-branch 4 6) (make-branch 3 (make-mobile (make-branch 2 3) (make-branch 2 2)))))
;; => #f

(is-balanced? (make-mobile
               (make-branch 5
                            (make-mobile
                             (make-branch 2 3)
                             (make-branch 1 4)))
               (make-branch 5
                            (make-mobile
                             (make-branch 2 2)
                             (make-branch 2 2)))))
;; => #f

(is-balanced? (make-mobile
               (make-branch 5
                            (make-mobile
                             (make-branch 2 2)
                             (make-branch 2 2)))
               (make-branch 5
                            (make-mobile
                             (make-branch 2 2)
                             (make-branch 2 2)))))
;; => #t

;; 1.2.29d: Suppose we change the representation of mobiles so that the constructors use `cons`, rather than `list`. How much do you need to change your programs to convert to the new representation?

;; Had to change accessors to use `cdr`, rather than `last`.

