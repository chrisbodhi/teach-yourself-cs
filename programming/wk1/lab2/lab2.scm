;; 1. Predict what Scheme will print in response...

(define a 3)
;; a

(define b (+ a 1))
;; b

(+ a b (* a b))
;; 19

(= a b)
;; #f

(if (and (> b a) (< b (* a b)))
    b
    a)
;; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
;; 16

(+ 2 (if (> b a) b a))
;; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
;; 16

((if (< a b) + -) a b)
;; 7

;; 2. Modify the plural library to correctly handle cases like (plural 'boy).

;;;;;                        In file cs61a/lectures/1.1/plural.scm
(define (initialplural wd)
  (if (equal? (last wd) 'y)
      (word (bl wd) 'ies)
      (word wd 's)))

(define (pluralize wd)
  (cond ((equal? (last wd) 's) wd)
        ((equal? (last wd) 'y)
         (if (not (vowel? (last (bl wd))))
             (word (bl wd) 'ies)
             (word wd 's)))
        (else (word wd 's))))

;; 3. Define a procedure that takes 3 arguments & returns the sum of the squares of the two larger numbers
(define (square n) (* n n))

(define (squareSums a b) (+ (square a) (square b)))

(define (sumSquareLargest a b c)
  (cond ((and (< a c) (< a b)) (squareSums b c))
        ((and (< b c) (< b a)) (squareSums a c))
        (else (squareSums a b))))

;; 4. Remove dupes from a sentence

(define (dupls-removed sentence)
  (d-r-i '() sentence))


(define (d-r-i acc sentence)
  (if (empty? sentence)
      acc
      (if (member? (first sentence) acc)
          (d-r-i acc (bf sentence))
          (d-r-i (se (first sentence) acc) (bf sentence)))))

