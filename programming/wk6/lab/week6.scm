;; 2.62: `union-set` in O(n) time
;;       union-set are elements that in s1 or s2
;; `element-of-set?` from SICP text
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (union-set s1 s2)
  (if (or (null? s1) (null? s2))
      s2
      (let ((x1 (car s1)) (x2 (car s2)))
        (cond ((or (= x1 x2) (element-of-set? x1 s2))
               (union-set (cdr s1) s2))
              ((> x1 x2)
               (union-set (cdr s1) (cons x2 (cons x1 (cdr s2)))))
              ((< x1 x2)
               (union-set (cdr s1) (cons x1 s2)))))))

(element-of-set? 2 '(2 3 4))
(union-set '(1 3 4 5 6) '(3 4 6 7 8))
(equal? '(1 5 3 4 6 7 8) (union-set '(1 3 4 5 6) '(3 4 6 7 8)))
;; => #t because it does not sort

;; 3. Construct the trees shown on pg 156 -- https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-16.html#%_sec_2.3.3 "Sets as Binary Trees"

(adjoin-set 5 (adjoin-set 1 (adjoin-set 11 (adjoin-set 9 (adjoin-set 3 (make-tree 7 () ()))))))
;; => (7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))

(adjoin-set 11 (adjoin-set 9 (adjoin-set 5 (adjoin-set 7 (adjoin-set 1 (make-tree 3 () ()))))))
;; => (3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))

(adjoin-set 11 (adjoin-set 7 (adjoin-set 9 (adjoin-set 1 (adjoin-set 3 (make-tree 5 () ()))))))
;; => (5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))
