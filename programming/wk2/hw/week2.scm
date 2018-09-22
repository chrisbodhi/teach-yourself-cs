;; 1a. [1.31a from the text] The `sum` procedure is only the simplest of a vast number
;;     of similar abstractions that can be captured as higher-order procedures. Write
;;     an analogous procedure called `product` that returns the product of the values
;;     of a function at points over a given range. Show how to define `factorial` in 
;;     terms of `product`. Also use `product` to compute approximations to  using the
;;     formula: (pi / 4) = (2 * 4 * 4 * 6 * 6 * 8 * ...) / (3 * 3 * 5 * 5 * 7 * 7 * ...)
(define (product term-fn lower next-fn higher)
  (if (> lower higher)
      1
      (* (term-fn lower)
         (product term-fn (next-fn lower) next-fn higher))))

(define (factorial-with-product higher)
  (define (fact-term n) n)
  (define (fact-next n)
    (+ n 1))
  (product fact-term 1 fact-next higher))

(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(define (inc n) (+ n 1))
(define (twice fn) (lambda (x) (fn (fn x))))
(define (plus-two n) ((twice inc) n))

(define (quarter-pi lower higher)
  (define (term-fn n) n) ;; but not this
  (product term-fn lower plus-two higher))

;; 1b. Show that `sum` and `product` (exercise 1.31) are both special cases of a still more
;;     general notion called `accumulate` that combines a collection of terms, using some
;;     general accumulation function:
;;       (accumulate combiner null-value term a next b)
;;     Accumulate takes as arguments the same term and range specifications as `sum` and
;;     `product`, together with a combiner procedure (of two arguments) that specifies how
;;     the current term is to be combined with the accumulation of the preceding terms and
;;     a null-value that specifies what base value to use when the terms run out. Write
;;     `accumulate` and show how `sum` and `product` can both be defined as simple calls
;;     to `accumulate`.
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (inc n) (+ n 1))
(define (identity n) n)
(define (sum x y)
  (accumulate + 0 identity x inc y))
(define (product x y)
  (accumulate * 1 identity x inc y))

;; 1c. Write filtered-accumulate as a procedure...
(define (filtered-accumulate predicate combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (predicate a)
          (combiner (term a) (filtered-accumulate predicate combiner null-value term (next a) next b))
          (filtered-accumulate predicate combiner null-value term (next a) next b))))

;; a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate already written)
(define (sum-squares-of-primes x y)
  (define (square n) (* n n))
  (define (inc n) (+ n 1))
  (filtered-accumulate prime? + 0 square x inc y))

;; via https://rosettacode.org/wiki/Primality_by_trial_division#Scheme
(define (prime? n)
  (if (< n 4) (> n 1)
      (and (odd? n)
	   (let loop ((k 3))
	     (or (> (* k k) n)
		 (and (positive? (remainder n k))
		      (loop (+ k 2))))))))


;; b. the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1).
(define (product-positive-relatives n)
  (define (relatively-prime? current)
      (equal? 1 (gcd current n)))
  (define (pass-check? num)
    (and (equal? 0 (remainder num 2)) (relatively-prime? num)))
  (define (identity n) n)
  (define (inc n) (+ 1 n))
  (filtered-accumulate pass-check? * 1 identity 1 inc n))
;; (product-positive-relatives 9) => 64


;; 1d. Define a procedure `cubic` that can be used together with the newtons-method procedure in expressions of the form
;;         (newtons-method (cubic a b c) 1)
;;     to approximate zeros of the cubic x^3 + ax^2 + bx + c.

;; via https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.1
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
(define dx 0.00001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (lambda (x)
    (+ (expt x 3) (* a (expt x 2)) (* b x) c)))

(newtons-method (cubic a b c) 1)

;; 1e. Define a procedure `double` that takes a procedure of one argument as argument and
;;     returns a procedure that applies the original procedure twice.

(define (double fn)
  (lambda (x)
    (fn (fn x))))

(define (inc n) (+ n 1))

;; What does `(((double (double double)) inc) 5)` return?
;; => 21

;; 1f. Define a procedure that repeats a numerical function `f` a total of `n` times.

;; For example:
;; ((repeated square 2) 5)
;; => 625

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f num)
  (if (equal? num 1)
      f
      (compose f (repeated f (- num 1)))))

;; 1g. Write a procedure `iterative-improve` that takes two procedures as arguments:
;;     a method for telling whether a guess is good enough and a method for improving a guess.

(define (iterative-improve good-enough? improve-guess)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        (improve-guess guess))))

;; 2. Write a function `every` which applies a procedure to all elements in a sentence
(define (every fn arg)
  (if (empty? arg)
      '()
      (se (fn (first arg)) (every fn (bf arg)))))

;; Extra
(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(lambda (n)
  (if (= n 0)
      1
      (* n (??? (- n 1)))) 5)

