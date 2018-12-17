;; 1a. SICP exercise 2.25: Give combinations of cars and cdrs that will pick 7 from each of the following lists:

(1 3 (5 7) 9)
(car (cdr (car (cdr (cdr x)))))
;; => 7

((7))
(car (car '((7)))
;; => 7

(1 (2 (3 (4 (5 (6 7))))))
(cdr (cdr (cdr (cdr (cdr (cdr y))))))
;; => 7

;; 1b. SICP Exercise 2.53: What would the interpreter print in response to evaluating each of the following expressions?

(list 'a 'b 'c)
;; => (a b c)

(list (list 'george))
;; => (('george))
;; Turns out, not the quote

(cdr '((x1 x2) (y1 y2)))
;; => (y1 y2)
;; Turns out, ((y1 y2))

(cadr '((x1 x2) (y1 y2)))
;; => y1
;; Turns out, (y1 y2)

(pair? (car '(a short list)))
;; => #f

(memq 'red '((red shoes) (blue socks)))
;; => #f

(memq 'red '(red shoes blue socks))
;; => 'red
;; Turns out, (red shoes blue socks)

;; 2. The shorthands `'` expand when evaluating, so the expression becomes
(car (quote (quote string)))

;; 3. deep reverse
;; SICP 2.27

(define (reverse l)
  (reverse-iter l '()))

(define (reverse-iter l rl)
  (if (empty? l)
      rl
      (reverse-iter (cdr l) (cons (car l) rl))))

(define (deep-reverse l)
  (deep-reverse-iter l '()))

(define (deep-reverse-iter l rl)
  (if (empty? l)
      rl
      (if (list? (car l))
       (deep-reverse-iter (cdr l) (cons (reverse (car l)) rl))
       (deep-reverse-iter (cdr l) (cons (car l) rl)))))

