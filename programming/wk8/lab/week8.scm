;; 1. Simplified version of `make-account` from SICP

(define (make-account balance)
  (define (withdraw amount)
    (set! balance (- balance amount)) balance)
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (define (dispatch msg)
    (cond
     ((eq? msg 'withdraw) withdraw)
     ((eq? msg 'deposit) deposit)))
  dispatch)

;; Fill in the `let`.

(define (make-account init-amount)
  (let ((balance init-amount)) ;; <--- this line is the lab solution
    (define (withdraw amount)
      (set! balance (- balance amount)) balance)
    (define (deposit amount)
      (set! balance (+ balance amount)) balance)
    (define (dispatch msg)
      (cond
       ((eq? msg 'withdraw) withdraw)
       ((eq? msg 'deposit) deposit)))
    dispatch))

;; 2. Modify either version of the above make-account to return the balance and/or init-balance when prompted.

(define (make-account init-amount)
  (let ((balance init-amount))
    (define (withdraw amount)
      (set! balance (- balance amount)) balance)
    (define (deposit amount)
      (set! balance (+ balance amount)) balance)
    (define (dispatch msg)
      (cond
       ((eq? msg 'withdraw) withdraw)
       ((eq? msg 'deposit) deposit)
       ((eq? msg 'balance) balance)
       ((eq? msg 'init-balance) init-amount)))
    dispatch))

;; 3. Modify `make-account` to keep track of transactions.

(define (make-account init-amount)
  (let ((balance init-amount)
        (transactions '())) ;; todo: revisit this init value
    (define (withdraw amount)
      (set! transactions (list transactions (list 'withdraw amount)))
      (set! balance (- balance amount)) balance)
    (define (deposit amount)
      (set! transactions (list transactions (list 'deposit amount)))
      (set! balance (+ balance amount)) balance)
    (define (dispatch msg)
      (cond
       ((eq? msg 'withdraw) withdraw)
       ((eq? msg 'deposit) deposit)
       ((eq? msg 'balance) balance)
       ((eq? msg 'init-balance) init-amount)
       ((eq? msg 'transactions) transactions)))
    dispatch))

