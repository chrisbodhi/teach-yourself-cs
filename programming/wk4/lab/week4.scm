;; 3. Enter these definitions into Scheme:
(define (make-rational num den)
  (cons num den))

(define (numerator rat)
  (car rat))

(define (denominator rat)
  (cdr rat))

(define (*rat a b)
  (make-rational (* (numerator a) (numerator b))
                 (* (denominator a) (denominator b))))

(define (print-rat rat)
  (word (numerator rat) '/ (denominator rat)))

;; 5. Define a procedure `+rat` to add two rational numbers,
;;    in the same style as `*rat` above.

(define (+rat a b)
  (make-rational (+ (* (numerator a) (denominator b)) (* (numerator b) (denominator a)))
                 (* (denominator a) (denominator b))))

;; 6a: Exercise 2.2 -- Define a constructor `make-segment` and selectors `start-segment` and `end-segment` that
;;     define the representation of segments in terms of points...specify a constructor `make-point` and
;;     selectors `x-point` and `y-point`...define a procedure `midpoint-segment` that takes a line segment
;;     as argument and returns its midpoint (the point whose coordinates are the average of the coordinates
;;     of the endpoints)

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (midpoint-segment seg)
  (make-point (/ (+ (x-point (start-segment seg)) (x-point (end-segment seg))) 2)
              (/ (+ (y-point (start-segment seg)) (y-point (end-segment seg))) 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

;; 6b: Exercise 2.3 -- Implement a representation for rectangles in a plane. In terms of your
;;     constructors and selectors, create procedures that compute the perimeter and the area
;;     of a given rectangle.

(define (make-rect seg1 seg2)
  (cons seg1 seg2))

(define (width rect)
  (length (car rect)))

(define (height rect)
  (length (cdr rect)))

(define (length seg)
  (define (square n) (* n n))
  (let ((p1 (start-segment seg))
        (p2 (end-segment seg)))
        (sqrt (+ (square (- (x-point p1) (x-point p2)))
                 (square (- (y-point p1) (y-point p2)))))))

(define (calc-perimeter rect)
  (* 2 (+ (width rect) (height rect))))

(define (calc-area rect)
  (* (width rect) (height rect)))

;; Now implement a different representation for rectangles.
(define (one-go-rect p1 p2 p3)
       (cons (make-segment p1 p2) (make-segment p2 p3)))


