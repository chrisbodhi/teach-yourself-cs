;; Code for CS61A project 2 -- picture language

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
	(beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
	    (right (right-split painter (- n 1))))
	(let ((top-left (beside up up))
	      (bottom-right (below right right))
	      (corner (corner-split painter (- n 1))))
	  (beside (below painter top-left)
		  (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
	  (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (identity x) x)

(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
				  identity flip-vert)))
    (combine4 painter)))

;; or

; (define flipped-pairs
;   (square-of-four identity flip-vert identity flip-vert))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
				  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
			   (edge1-frame frame))
	       (scale-vect (ycor-vect v)
			   (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
	((frame-coord-map frame) (start-segment segment))
	((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (draw-line v1 v2)
  (penup)
  (setxy (- (* (xcor-vect v1) 200) 100)
	 (- (* (ycor-vect v1) 200) 100))
  (pendown)
  (setxy (- (* (xcor-vect v2) 200) 100)
	 (- (* (ycor-vect v2) 200) 100)))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
	(painter
	 (make-frame new-origin
		     (sub-vect (m corner1) new-origin)
		     (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
		     (make-vect 0.0 1.0)
		     (make-vect 1.0 1.0)
		     (make-vect 0.0 0.0)))

(define (shrink-to-upper-right painter)
  (transform-painter painter
		    (make-vect 0.5 0.5)
		    (make-vect 1.0 0.5)
		    (make-vect 0.5 1.0)))

(define (rotate90 painter)
  (transform-painter painter
		     (make-vect 1.0 0.0)
		     (make-vect 1.0 1.0)
		     (make-vect 0.0 0.0)))

(define (squash-inwards painter)
  (transform-painter painter
		     (make-vect 0.0 0.0)
		     (make-vect 0.65 0.35)
		     (make-vect 0.35 0.65)))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
	   (transform-painter painter1
			      (make-vect 0.0 0.0)
			      split-point
			      (make-vect 0.0 1.0)))
	  (paint-right
	   (transform-painter painter2
			      split-point
			      (make-vect 1.0 0.0)
			      (make-vect 0.5 1.0))))
      (lambda (frame)
	(paint-left frame)
	(paint-right frame)))))

;;
;; Your code goes here
;;
;; Exercise 2.44 Define `up-split`, which is like `right-split`, but switches roles of `below` and `beside`
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
	(below painter (beside smaller smaller)))))

;; Exercise 2.45: Abstract a higher-order procedure called `split`.
(define (split proc1 proc2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller (split painter (- n 1))))
          (proc1 painter (proc2 smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

;; Exercise 2.46: vectors!

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (math-vect math v1 v2)
  (make-vect
   (math (xcor-vect v1) (xcor-vect v2))
   (math (ycor-vect v1) (ycor-vect v2))))

(define (add-vect v1 v2)
  (math-vect + v1 v2))

(define (sub-vect v1 v2)
  (math-vect - v1 v2))

(define (scale-vect s v)
  (let ((xcor (xcor-vect v)))
    (let ((ycor (ycor-vect v)))
      (make-vect (* s xcor) (* s ycor)))))

;; Exercise 2.47:  For each constructor, supply the appropriate
;;                 selectors to produce an implementation for frames.

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-list frame)
  (car frame))

(define (edge1-list frame)
  (cadr frame))

(define (edge2-list frame)
  (caddr frame))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-cons frame)
  (car frame))

(define (edge1-cons frame)
  (cadr frame))

(define (edge2-cons frame)
  (cddr frame))

;; Exercise 2.48: Use your vector representation to define a
;;                representation for segments with a constructor
;;                `make-segment` and selectors `start-segment` and
;;                `end-segment`.

(define (make-segment x1 y1 x2 y2)
  (cons (make-vector x1 y1) (make-vector x2 y2)))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

;; Exercise 2.49:  Use `segments->painter` to define the following
;;                 primitive painters:

;; a. The painter that draws the outline of the designated frame.
(define (outline)
  (let ((outlines (list
                   (make-segment 0 0 1 0)
                   (make-segment 1 0 1 1)
                   (make-segment 1 1 0 1)
                   (make-segment 0 0 0 1))))
   (segments->painter outlines)))


;; b. The painter that draws an ``X'' by connecting opposite corners
;;    of the frame. 
(define (x)
  (let ((xs (list
             (make-segment 0 0 1 1)
             (make-segment 1 0 0 1))))
    (segments->painter xs)))

;; c. The painter that draws a diamond shape by connecting the
;;    midpoints of the sides of the frame.
(define (diamond)
  (let ((sides (list
                (make-segment 0.5 0 0 0.5)
                (make-segment 0 0.5 0.5 1)
                (make-segment 0.5 1 1 0.5)
                (make-segment 1 0.5 0.5 0))))
    (segments->painter sides)))

;; d. The `wave` painter. 
(define (wave)
  ;; 182 pixels -- width and height of segment graphic downloaded from SICP site, and then measured using macos Preview, one segment at a time
  (define (divide-by-182 segment)
    (map (lambda (n) (/ n 182)) segment))
  (let ((pieces (list
                 (make-segment 0 47 63 90)
                 (make-segment 63 90 54 108)
                 (make-segment 54 108 29 73)
                 (make-segment 29 73 0 117)
                 (make-segment 0 153 27 108)
                 (make-segment 27 108 55 117)
                 (make-segment 55 117 73 117)
                 (make-segment 73 117 64 154)
                 (make-segment 64 154 72 182)
                 (make-segment 108 182 119 155)
                 (make-segment 119 155 110 117)
                 (make-segment 110 117 137 117)
                 (make-segment 137 117 64 182)
                 (make-segment 29 182 110 83)
                 (make-segment 110 83 137 0)
                 (make-segment 108 0 92 53)
                 (make-segment 92 53 74 0))))
    (segments->painter (map divide-by-182 pieces))))

;; Exercise 2.50: Define the transformation `flip-horiz`, which flips
;;                painters horizontally, and...

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

;; transformations that rotate painters counterclockwise by 180 degrees...

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 1.0)))

;; ...and 270 degrees. 

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

;; Exercise 2.51: Define the `below` operation for painters.
;;                `Below` takes two painters as arguments.

;; Define below in two different ways -- first by writing a procedure
;; that is analogous to the beside procedure given above...
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-top
           (transform-painter painter1
                              split-point
                              (make-vect 0.0 1.0)
                              (make-vect 0.5 1.0)))
          (paint-bottom
           (transform-painter painter2
                              (make-vect 0.0 0.0)
                              (make-vect 0.0 1.0)
                              split-point)))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))

;; ...and again in terms of `beside` and suitable rotation operations.
(define (below painter1 painter2)
  (rotate270 (beside (rotate90 painter1) (rotate90 painter2))))

;; Exercise 2.52a: Add some segments to the primitive `wave` painter of
;;                 Exercise 2.49 (to add a smile, for example).
(define (wave-star)
  (let ((star (list
               (make-segment 0.5 0.5 0.5 0.55)
               (make-segment 0.5 0.5 0.45 0.5)
               (make-segment 0.5 0.5 0.55 0.5)
               (make-segment 0.5 0.5 0.5 0.45))))
    (segments->painter star)
    wave))

;; Exercise 2.52b: Change the pattern constructed by `corner-split`.
(define (other-corner-split painter n)
  (if (= n 0)
      painter
      (let ((down (down-split painter (- n 1)))
	    (left (left-split painter (- n 1))))
	(let ((bottom-left (beside down down))
	      (top-right (below left left))
	      (corner (other-corner-split painter (- n 1))))
	  (beside (below painter bottom-left)
		  (below top-right corner))))))

;; Exercise 2.52c: Modify the version of `square-limit` that uses
;;                 `square-of-four` so as to assemble the corners
;;                 in a different pattern.
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
				  rotate90 flip-vert)))
    (combine4 (corner-split painter n))))


;; end of my code

(define full-frame (make-frame (make-vect -0.5 -0.5)
			       (make-vect 2 0)
			       (make-vect 0 2)))
