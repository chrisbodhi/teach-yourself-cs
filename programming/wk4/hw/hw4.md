**Exercise 2.8: Using reasoning analogous to Alyssa's, describe how the difference of two intervals may be computed. Define a corresponding subtraction procedure, called `sub-interval`.**

"She reasons that the minimum value the sum could be is the sum of the two lower bounds and the maximum value it could be is the sum of the two upper bounds." Therefore, we will reason that the minimum value will be the absolute value of lesser lower bound subtracted from the greater lower bound, and likewise with the upper bounds.

```scheme
(define (sub-interval x y)
  (make-interval (abs (- (lower-bound x) (lower-bound y)))
                 (abs (- (upper-bound x) (upper-bound y)))))
```

**Exercise 2.22: Louis Reasoner tries to rewrite the first `square-list` procedure of exercise 2.21 so that it evolves an iterative process:**

```scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))
```

**Unfortunately, defining `square-list` this way produces the answer list in the reverse order of the one desired. Why?**

Because the squared version of the first number from `things` is being added to the front of the
accumulated `answer` list, rather than at the end.

**Louis then tries to fix his bug by interchanging the arguments to `cons`:**

```scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))
```

**This doesn't work either. Explain.**

Because the returned value of `square` is a number, and not a list, `cons` is adding the number as
its own second half of the pair, returning a list of lists of lists of...lists: `(((((() . 1) . 4) . 9) . 16) . 25)`
