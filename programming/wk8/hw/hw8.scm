;; 3.3: Modify the `make-account` procedure so that it creates password-
;;      protected accounts. The resulting account object should process a
;;      request only if it is accompanied by the password with which the
;;      account was created, and should otherwise return a complaint.

;; ((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"

(define (make-account init-pwd balance)
  (define (check-pwd input-pwd)
    (if (not (eq? input-pwd init-pwd))
        (error "Incorrect password")))
  (define (withdraw input-pwd amount)
    (check-pwd input-pwd)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit input-pwd amount)
    (check-pwd input-pwd)
    (set! balance (+ balance amount))
    balance)
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
   (define (call-the-cops?)
     (if (> failed-attempts 6)
         (error "Calling the cops")))
   (define (check-pwd input-pwd)
     (if (eq? input-pwd init-pwd)
         (set! failed-attempts 0)
         (begin (set! failed-attempts (+ failed-attempts 1))
                (call-the-cops?)
                (error "Incorrect password"))))
   (define (withdraw input-pwd amount)
     (check-pwd input-pwd)
     (if (>= balance amount)
         (begin (set! balance (- balance amount))
                balance)
         "Insufficient funds"))
   (define (deposit input-pwd amount)
     (check-pwd input-pwd)
     (set! balance (+ balance amount))
     balance)
   (define (dispatch m)
     (cond ((eq? m 'withdraw) withdraw)
           ((eq? m 'deposit) deposit)
           (else (error "Unknown request -- MAKE-ACCOUNT"
                        m))))
   dispatch))


