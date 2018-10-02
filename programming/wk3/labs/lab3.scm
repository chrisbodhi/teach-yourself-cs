;; Counting Change: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.2

;; 2. Reverse how the change is counted using one of the proposed suggestions from Answer 1. 

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 5)
        ((= kinds-of-coins 2) 1)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

;; 3. modify cc so it takes a sentence, like (cc amount ’(50 25 10 5 1))
(define (cc amount s)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= (length s) 0)) 0)
        (else (+ (cc amount (bf s))
                 (cc (- amount (first s))
                     s)))))

;; 4. Write `type-check`. Its arguments are a function, a type-checking
;;    predicate that returns #t if and only if the datum is a legal
;;    argument to the function, and the datum.

(define (type-check fn predicate datum)
  (if (predicate datum)
      (fn datum)
      #f))

;; 5. Instead, write a procedure make-safe that you can use this way:
;;    (define safe-sqrt (make-safe sqrt number?))

(define (make-safe fn predicate)
  (lambda (datum)
    (type-check fn predicate datum)))

