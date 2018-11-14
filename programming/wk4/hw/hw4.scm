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

(define (spans-zero? interval)
  (cond ((zero? (lower-bound interval)) #t)
        ((zero? (upper-bound interval)) #t)
        ((and (negative? (lower-bound interval)) (positive? (upper-bound interval))) #t)
        (else #f)))

(define (safe-div-interval x y)
  (if (spans-zero? y)
      (error "Interval spans zero. Cannot divide by " 0)
      (div-interval x y)))

;; Exercise 2.12:  Define a constructor `make-center-percent` that takes a center and a percentage tolerance
;;                 and produces the desired interval. You must also define a selector `percent` that produces
;;                 the percentage tolerance for a given interval. The `center` selector is the same as the one
;;                 shown above.

;; From SICP
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent starting-point tolerance)
  (* starting-point tolerance))

(define (make-center-percent starting-point tolerance)
  (let ((diff (percent starting-point tolerance)))
    (make-interval (- starting-point diff)
                   (+ starting-point diff))))

;; Exercise 2.17: Define a procedure `last-pair` that returns the list that contains only the last element of a given (nonempty) list:

(define (last-pair l)
  (if (equal? 1 (length l))
      l
      (last-pair (cdr l))))

(last-pair (list 23 72 149 34))
;; (34)

;; Exercise 2.20: Use this [dotted-tail] notation to write a procedure `same-parity` that takes one or more integers and returns a list of
;;                all the arguments that have the same even-odd parity as the first argument. For example,

(define (same-parity n . l)
  (if (even? n)
      (cons n (filter even? l))
      (cons n (filter odd? l))))
;; Can't tell if using higher-order functions ☝️ is just me getting lazy.

(same-parity 1 2 3 4 5 6 7)
;; (1 3 5 7)

(same-parity 2 3 4 5 6 7)
;; (2 4 6)

;; Exercise 2.22:
;; see hw4.md

;; Exercise 2.23: Give an implementation of `for-each`. The value returned by the call to `for-each` can be something arbitrary, such as true.
(define (for-each fn input)
  (if (null? input)
      #t
      (begin (fn (car input)) (for-each fn (cdr input)))))

;; 2. Write a procedure `substitute` that takes three arguments:
;;    - a list
;;    - an old word
;;    - a new word
;;    It should return a copy of the list, but with every occurrence of the old word replaced by the new word, even in sublists.
(define (substitute input to-swap new-word)
  (define (swap in-word)
    (if (word? in-word)
        (if (equal? in-word to-swap)
            new-word
            in-word)
        (substitute in-word to-swap new-word)
        ))
  (map swap input))


(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)
;; > ((lead axe) (bass axe) (rhythm axe) drums)

;; 3. Now write `substitute2` that takes
;;    - a list
;;    - a list of old words
;;    - a list of new words
;;    the last two lists should be the same length. It should return a copy of the first argument, but with each
;;    word that occurs in the second argument replaced by the corresponding word of the third argument:
(define (substitute2 input swap-list new-list))

(substitute2 '((4 calling birds) (3 french hens) (2 turtle doves)) '(1 2 3 4) '(one two three four)
             )
;; > ((four calling birds) (three french hens) (two turtle doves))


