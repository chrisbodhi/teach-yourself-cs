;; Scheme calculator -- evaluate simple expressions

; The read-eval-print loop:

(define (calc)
  (display "calc: ")
  (flush)
  (print (calc-eval (read)))
  (calc))

; Evaluate an expression:

(define (calc-eval exp)
  (cond ((number? exp) exp)
        ;; [x] your calculator should treat words as self-evaluating expressions
        ((word? exp) exp)
	((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
	(else (error "Calc: bad expression:" exp))))

; Apply a function to arguments:

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + 0 args))
	((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
			   ((= (length args) 1) (- (car args)))
			   (else (- (car args) (accumulate + 0 (cdr args))))))
	((eq? fn '*) (accumulate * 1 args))
	((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
			   ((= (length args) 1) (/ (car args)))
			   (else (/ (car args) (accumulate * 1 (cdr args))))))
; [x] first
        ((eq? fn 'first) (if (null? args)
                             (error "Calc: no args to first")
                             (first (first args))))
; [x] butfirst
        ((or (eq? fn 'butfirst) (eq? fn 'bf)) (if (null? args)
                                                  (error (string-append "Calc: no args to " (symbol->string fn)))
                                                  (bf (first args))))
; [x] last
        ((eq? fn 'last) (if (null? args)
                            (error "Calc: no args to last")
                            (last (first args))))
; [x] butlast
        ((or (eq? fn 'butlast) (eq? fn 'bl)) (if (null? args)
                                                 (error (string-append "Calc: no args to " (symbol->string fn)))
                                                 (bl (first args))))
; [x] word
        ((eq? fn 'word) (cond ((null? args) (error "Calc: no args to word"))
                              ((equal? 1 (length args)) (car args))
                              (else (calc-apply 'word (cons (word (first args) (second args)) (cddr args))))))
	(else (error "Calc: bad operator:" fn))))
