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

;; 1.2.30: Define `square-tree`, first without HOC, then with.
(define (square n)
  (* n n))

;; from lecture
(define (deep-fn fn lol)
  (cond ((null? lol) '())
        ((pair? lol)
         (cons
          (deep-fn fn (car lol))
          (deep-fn fn (cdr lol))))
        (else (fn lol))))

(define (square-tree-deep lol)
  (deep-fn square lol))

(square-tree-deep
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

;; from lecture
(define (deep-map fn lol)
  (if (list? lol)
      (map (lambda (element) (deep-map fn element))
           lol)
      (fn lol)))

(define (square-tree lol)
  (deep-map square lol))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

;; 1.2.31:  Abstract your answer to exercise [1.]2.30 to produce a
;;          procedure `tree-map` with the property that `square-tree`
;;          could be defined as
;;              (define (square-tree tree) (tree-map square tree))

;; I already did this... Rather, Prof. Harvey already did this. 😅

;; 1.2.32: Complete the following definition of a procedure that
;;         generates the set of subsets of a set...

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map todo rest)))))

(define (todo el)
  el)

(subsets (list 1 2 3))

;; ...and give a clear explanation why it works.
;; 1.2.36: Define `accumulate-n` to operate on a sequence of sequences.

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(equal? (accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12))) (list 22 26 30))
;; => #t

;; 1.2.37: Matrix math: fill in the blanks

;; dot-product given
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (a b)
         (map (lambda (n) (* a n)) b) a)
       v m))

(matrix-*-vector (list (list 2 2 3) (list 4 5 6) (list 7 8 9)) (list 4 6 9))

(define (transpose mat)
  (accumulate-n <??> <??> mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map <??> m)))

;; 1.2.54: Define `equal?` to compare two lists.

(define (equal? a b)
     (cond ((and (empty? a) (empty? b)) #t)
           ((eq? (car a) (car b)) (equal? (cdr a) (cdr b)))
           (else #f)))

(equal? '(this is a list) '(this is a list))
;; => #t

(equal? '(this is a list) '(this (is a) list))
;; => #f

