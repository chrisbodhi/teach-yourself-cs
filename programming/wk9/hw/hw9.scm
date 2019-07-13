;; 3.17: Devise a correct version of the `count-pairs` procedure of exercise
;;       3.16 that returns the number of distinct pairs in any structure.

;; does not work
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;; https://wizardbook.wordpress.com/2010/12/15/exercise-3-16/
(define l31 (list 'a 'b 'c))
 
(define l41 (list 'b 'c))
(define l42 (list 'a))
(set-car! l41 l42)
(set-car! (cdr l41) l42)
 
(define l71 (list 'c))
(define l72 (list 'b))
(define l73 (list 'a))
(set-car! l72 l73)
(set-cdr! l72 l73)
(set-car! l71 l72)
(set-cdr! l71 l72)
 
(define linf (list 'a 'b 'c))
(set-cdr! (cdr (cdr linf)) linf)
;; infinite pairs
 
(count-pairs l31)
;; 3
(count-pairs l41)
;; 4
(count-pairs l71)
;; 7

(define count-pairs
  (let ((seen '()))
    (lambda (x)
      (cond ((not (pair? x)) 0)
            ((memq x seen) 0)
            (else (begin
                   (set! seen (cons x seen))
                   (+ (count-pairs (car x))
                      (count-pairs (cdr x))
                      1)))))))

(count-pairs (list 1 2 3))
;; 3
(count-pairs l41)
;; 3
(count-pairs linf)
;; 3

;; 3.21: Define a procedure `print-queue` that takes a queue as input and
;;       prints the sequence of items in the queue.

(define (front-ptr queue)
  (car queue))

(define (rear-ptr queue)
  (cdr queue))

(define (set-front-ptr! queue item)
  (set-car! queue item))

(define (set-rear-ptr! queue item)
  (set-cdr! queue item))

(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define (make-queue)
  (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "EMPTY ALREADY" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))

(define q1 (make-queue))
(insert-queue! q1 'a)
;; ((a) a)
(insert-queue! q1 'b)
;; ((a b) b)
(delete-queue! q1)
;; ((b) b)
(delete-queue! q1)
;; (() b)

(define (print-queue queue)
  (cond ((empty-queue? queue)
         (error "Queue is empty" queue))
        (else (car queue))))

(define q1 (make-queue))
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(print-queue q1)
;; (a b)


