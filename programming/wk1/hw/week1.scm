(define (new-if p t e)
  (cond (p t)
        (else e)))

(new-if (> 5 4) 'word 'noword)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x)
  (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
   (sqrt-iter 1.0 x))

;; (sqrt 9)

;; 2. squares

(define (square n)
  (* n n))

(define (squares ns)
  (square-iter ns '()))

(define (square-iter ns acc)
  (if (empty? ns)
      acc
      (square-iter (bf ns) (se acc (square (first ns))))))

;; 3. switch to swap "me/i" with "you", and "you" with "me," except at the beginning of the sentence

(define (switch input)
  ;; somehow handle just the first word...
  (switch-iter (swap (first input)) (bf input)))

(define (switch-iter acc input)
  (if (empty? input)
      acc
      (se (swap (first input)) (switch (bf input)))))

(define (swap word)
  (cond ((or (equal? word 'i) (equal? word 'me)) 'you)
        ((equal? word 'you) 'me)
        (else word)))

;; 4. Write a predicate `ordered?` -- takes a sentence of numbers [domain] & returns t/f [range] if numbers are in ascending order, false otherwise
(define (ordered? numbers)
  (if (or (empty? numbers) (equal? (length numbers) 1))
      #t
      (if (< (first numbers) (second numbers))
          (ordered? (bf numbers))
          #f)))

(define (second input)
  (first (bf input)))

;; 5. Write a procedure `ends-e` that takes a sentence as its arguments and returns a sentence containing only those words that end in the letter E.
(define (ends-e input)
  (ends-e-itr '() input))

(define (ends-e-itr acc input)
  (if (empty? input)
      acc
      (if (ends-with-e? (first input))
          (ends-e-itr (se acc (first input)) (bf input))
          (ends-e-itr acc (bf input)))))

(define (ends-with-e? word)
  (equal? (last word) 'e))

