;; 1.2.74a.  Implement for headquarters a `get-record` procedure that
;;           retrieves a specified employee's record from a specified
;;           personnel file. The procedure should be applicable to any
;;           division's file. Explain how the individual divisions' files
;;           should be structured. In particular, what type information
;;           must be supplied?


(define (s-mart-get-record id)
  (* id id))

(define (w-e-w-get-record id)
  (- id id))

(put 'get-record 's-mart s-mart-get-record)
(put 'get-record 'wall-e-world w-e-w-get-record)

;; our 'tag' is the division name

(define (get-record employee-id division)
  (let ((proc (get 'get-record division)))
    (if proc
        (apply proc (list employee-id)))))


;; Explain how the individual divisions' files should be structured. In particular, what type information must be supplied?

;; see hw6.md

;; 1.2.74b. Implement for headquarters a `get-salary` procedure that returns
;;          the salary information from a given employee's record from any
;;          division's personnel file.

(define (get-salary employee-id division)
  (let ((record (get-record employee-id division)))
    (let ((proc (get 'get-salary division)))
      (if proc
          (apply proc (list record))))))

;; see hw6.md for part two

;; 1.2.74c. Implement for headquarters a `find-employee-record` procedure.
;;          This should search all the divisions' files for the record of a
;;          given employee and return the record. Assume that this
;;          procedure takes as arguments an employee's name and a list of
;;          all the divisions' files.

(define (find-employee-record employee-id division-files)
  (if (null? division-files)
      '()
      (let ((record (get-record employee-id (car division-files))))
        (if (length? record)
            record
            (find-employee-record employee-id (cdr division-files))))))

;; 1.2.74d. see hw6.md

;; 1.2.75. Implement the constructor `make-from-mag-ang` in
;;         message-passing style.

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else (error "Unknown op " op))))
  dispatch)

;; 1.2.76. see hw6.md

;; 1.2.77. see hw6.md

;; 1.2.79. Define a generic equality predicate `equ?` that tests the
;;         equality of two numbers, and install it in the generic
;;         arithmetic package. This operation should work for ordinary
;;         numbers, rational numbers, and complex numbers.

(define (equ? n1 n2)
  (let ((type (type-tag n1)))
    (cond ((eq? type 'scheme-number) (eq? n1 n2))
          ((or
            (eq? type 'rational)
            (eq? type 'complex)) (and
                                 (eq? (cadr n1) (cadr n2))
                                 (eq? (cddr n1) (cddr n2)))) ;; naive af
          (else (error "this type is not supported: " type)))))

(put 'equ? '(scheme-number scheme-number) equ?)

;; 1.2.80. Define a generic predicate `=zero?` that tests if its argument
;;         is zero, and install it in the generic arithmetic package. This
;;         operation should work for ordinary numbers, rational numbers,
;;         and complex numbers.

(define (=zero? n)
  (let ((type (type-tag n)))
    (cond ((eq? type 'scheme-number) (zero? (cdr n)))
          ((eq? type 'rational) (zero? (cadr n)))
          ((eq? type 'complex) (and (zero? (cadr n)) (zero? (cddr n))))
          (else (error "this type is not supported: " type)))))

(put '=zero? '(scheme-number scheme-number) =zero?)

;; 1.2.83. Suppose you are designing a generic arithmetic system for
;;         dealing with the tower of types shown in figure 2.25: integer,
;;         rational, real, complex. For each type (except complex), design
;;         a procedure that raises objects of that type one level in the 
;;         tower. 

(define (raise n)
  (cond ((integer? n) (make-rational n 1))
        ((rational? n) (exact->inexact n))
        ((real? n) (make-complex-from-real-imag n 0))
        (else (error "cannot even"))))

;; Show how to install a generic `raise` operation that will work for
;; each type (except complex).

Use `put` again for each type constructor.


;; 2. Write `map-1` for this week's lab interpreter.
(define (square n)
  (* n n))

((lambda (f n)
   ((lambda (map-1) (map-1 map-1 f n))
    (lambda (map-1 f n)
      (if (null? n)
          '()
          (cons (f (car n)) (map-1 map-1 f (cdr n)))))))
 square
 (list 1 2 3 4 5 6))

;; 3. Modify the scheme-1 interpreter to add the `let` special form.

;; see ./scheme-1-hw.scm 



;; * - * - * - * - *

;; 1.2.81 notes from the text
(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a) 
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular 
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular 
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
(install-rectangular-package)

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y) 
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar 
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(install-polar-package)

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))    
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  (put 'exp '(scheme-number scheme-number)
       (lambda (x y) (tag (expt x y))))
  'done)
(install-scheme-number-package)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))


(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))

  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)
(install-rational-package)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(install-complex-package)

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

(define (get-coercion t1 t2)
  (get t1 t2))

(define (put-coercion t1 t2 t1->t2)
  (put t1 t2 t1->t2))

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))


(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

;; for 2.81
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)
;; undo the above
(put-coercion 'scheme-number 'scheme-number #f)
(put-coercion 'complex 'complex #f)

(define (exp x y) (apply-generic 'exp x y))
















