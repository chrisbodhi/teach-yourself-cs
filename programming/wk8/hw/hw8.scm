;; 3.3: Modify the `make-account` procedure so that it creates password-
;;      protected accounts. The resulting account object should process a
;;      request only if it is accompanied by the password with which the
;;      account was created, and should otherwise return a complaint.

;; ((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"

(define (make-account init-pwd balance)
  (define (correct-pwd? input-pwd)
    (eq? input-pwd init-pwd))
  (define (password-error)
    "Incorrect password")
  (define (withdraw input-pwd amount)
    (if (correct-pwd? input-pwd)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds")
        (password-error)))
  (define (deposit input-pwd amount)
    (if (correct-pwd? input-pwd)
        (begin (set! balance (+ balance amount))
               balance)
        (password-error)))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)


;; 3.4: Modify the `make-account` procedure by adding another local state
;;      variable so that, if an account is accessed more than seven
;;      consecutive times with an incorrect password, it invokes the
;;      procedure `call-the-cops`.

(define (make-account init-pwd balance)
  (let ((failed-attempts 0))
   (define (call-the-cops? attempts)
     (> attempts 6))
   (define (correct-pwd? input-pwd)
     (if (eq? input-pwd init-pwd)
         (begin (set! failed-attempts 0)
                #t)
         #f))
   (define (password-error)
     (begin
       (set! failed-attempts (+ failed-attempts 1))
       (if (call-the-cops? failed-attempts)
           "Calling the cops"
           "Incorrect password")))
   (define (withdraw input-pwd amount)
     (if (correct-pwd? input-pwd)
         (if (>= balance amount)
             (begin (set! balance (- balance amount))
                    balance)
             "Insufficient funds")
         (password-error)))
   (define (deposit input-pwd amount)
     (if (correct-pwd? input-pwd)
         (begin (set! balance (+ balance amount))
                balance)
         (password-error)))
   (define (dispatch m)
     (cond ((eq? m 'withdraw) withdraw)
           ((eq? m 'deposit) deposit)
           (else (error "Unknown request -- MAKE-ACCOUNT"
                        m))))
   dispatch))

;; 3.7: Define a procedure `make-joint`. `Make-joint` should take three
;;      arguments. The first is a password-protected account. The second
;;      argument must match the password with which the account was defined
;;      in order for the `make-joint` operation to proceed. The third
;;      argument is a new password. `Make-joint` is to create an additional
;;      access to the original account using the new password.

;;      For example, if `peter-acc` is a bank account with password
;;      `open-sesame`, then

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

;;      will allow one to make transactions on `peter-acc` using the name
;;      `paul-acc` and the password `rosebud`. You may wish to modify your
;;      solution to exercise 3.3 to accommodate this new feature.

;; 1. modify make-account to allow for password changes
(define (make-account init-pwd balance)
  (define all-pwd (list init-pwd))
  (define (correct-pwd? input-pwd)
    (member? input-pwd all-pwd))
  (define (password-error)
    "Incorrect password")
  (define (withdraw input-pwd amount)
    (if (correct-pwd? input-pwd)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds")
        (password-error)))
  (define (deposit input-pwd amount)
    (if (correct-pwd? input-pwd)
        (begin (set! balance (+ balance amount))
               balance)
        (password-error)))
  (define (add-access input-pwd new-pwd)
    (if (correct-pwd? input-pwd)
        (begin (set! all-pwd (cons new-pwd all-pwd))
               "Added")
        (password-error)))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          ((eq? m 'add-access) add-access)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

;; 2. make-joint to update the password 
(define (make-joint acc init-pwd new-pwd)
  ((acc 'add-access) init-pwd new-pwd)
  acc)

(define peter-acc (make-account 'open-sesame 100))

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'withdraw) 'rosebud 5)
((peter-acc 'withdraw) 'open-sesame 5)

;; 3.8: When we defined the evaluation model in section 1.1.3, we said
;;      that the first step in evaluating an expression is to evaluate its
;;      subexpressions. But we never specified the order in which the
;;      subexpressions should be evaluated -- e.g., left to right or right 
;;      to left. When we introduce assignment, the order in which the 
;;      arguments to a procedure are evaluated can make a difference to 
;;      the result. Define a simple procedure f such that evaluating

(+ (f 0) (f 1)) 

;;      will return 0 if the arguments to + are evaluated from left to
;;      right but will return 1 if the arguments are evaluated from right
;;      to left.


(define (eval-order-tricks)
  (let ((init nil))
    (lambda (n)
       (if (null? init)
           (begin (set! init n)
                  n)
           0))))
(define f (eval-order-tricks))
(+ (f 0) (f 1))
;; => 0

(define f (eval-order-tricks))
(+ (f 1) (f 0))
;; => 1

