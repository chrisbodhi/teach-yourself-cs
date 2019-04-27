1. Load `scheme-1` from the file `~cs61a/lib/scheme1.scm`.

    a. Trace in detail how a simple procedure call such as
      `((lambda (x) (+ x 3)) 5)` is handled in `scheme-1`.

    ```txt
    `(print (eval-1 (read)))` kicks off the process, evaluating the lambda expression in `eval-1`, passing it in through `read`. Next, recognizing that what's been passed is a pair, we ready the expression to be called as two arguments to `apply-1` -- the first, eventually being the lambda expression, and the second being a list of the constant arguments, that is to say, `5` (the `eval-1`'d output of both the lambda and the constant are themselves).

    `apply-1` subsitutes the argument `(5)` for the formal parameter, `(x)` and then passes the expression `(+ 5 3)` to `eval-1` to work.

    And work does `eval-1` do, but not very much of it: the function recognizes `(+ 5 3)` as a pair, and passes it back to `apply-1`, as the procedure `+` and a list of arguments, `(5 3)`, which are returned from their recursive trip back through `eval-1` as constants.

    Since `+` is a procedure, `apply-1` use's Scheme's `apply` to call the procedure with the list of arguments as `(5 3)`. Thus, we get back the answer `8`.
    ```

    b. Try inventing higher-order procedures; since you don’t have `define` you’ll have to use the Y-combinator trick.

    ```scheme
    ((lambda (f n)
      ((lambda (filter) (filter filter f n))
        (lambda (filter f n)
          (if (null? n)
              '()
              (if (f (car n))
                  (cons (car n) (filter filter f (cdr n)))
                  (filter filter f (cdr n)))))))
    even?
    (list 1 2 3 4 5 6))
    ;; => (2 4 6)
    ```

    c. Since all the Scheme primitives are automatically available in `scheme-1`, you might think you could
use STk’s primitive `map` function. Try these examples:

        - Scheme-1: (map first '(the rain in spain))
        - Scheme-1: (map (lambda (x) (first x)) '(the rain in spain))

      Explain the results.

      ```txt
      The first example returns the list `(t r i s)`, which is the result of taking the first letter from each word in the input argument. The second example, although by all appearances is functionally equivalent to the first, fails with an error: `apply: bad procedure: (lambda (x) (first x))`. This happens because `map` passes arguments as unbound variables, rather than a single quoted expression
      ```

    d. Modify the interpreter to add the `and` special form. Test your work. Be sure that as soon as a false
value is computed, your `and` returns `#f` without evaluating any further arguments.

    ```scheme
    Scheme-1: (and 5 4)
    ;; => 4
    ;; To test, ensure that no error is thrown:
    Scheme-1: (and (> 2 4) (error "s"))
    ;; => #f
    ```

**For the rest of the lab, start by reading SICP section 2.3.3 (pages 151–161).**

2. SICP ex. 2.62: Give a θ(n) implementation of `union-set` for sets represented as ordered lists.

    ```scheme
    ;; union-set are elements that in s1 or s2
    ;; `element-of-set?` from SICP text
    (define (element-of-set? x set)
      (cond ((null? set) false)
            ((= x (car set)) true)
            ((< x (car set)) false)
            (else (element-of-set? x (cdr set)))))

    (define (union-set s1 s2)
      (if (or (null? s1) (null? s2))
          s2
          (let ((x1 (car s1)) (x2 (car s2)))
            (cond ((or (= x1 x2) (element-of-set? x1 s2))
                  (union-set (cdr s1) s2))
                  ((> x1 x2)
                  (union-set (cdr s1) (cons x2 (cons x1 (cdr s2)))))
                  ((< x1 x2)
                  (union-set (cdr s1) (cons x1 s2)))))))

    (element-of-set? 2 '(2 3 4))
    (union-set '(1 3 4 5 6) '(3 4 6 7 8))
    (equal? '(1 5 3 4 6 7 8) (union-set '(1 3 4 5 6) '(3 4 6 7 8)))
    ;; => #t because it does not sort
    ```

3. The file `~cs61a/lib/bst.scm` contains the binary search tree procedures from pages 156–157 of SICP. Using `adjoin-set`, construct the [trees shown on page 156](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-16.html#%_sec_2.3.3).

    ```scheme
    (adjoin-set 5
      (adjoin-set 1
        (adjoin-set 11
          (adjoin-set 9
            (adjoin-set 3
              (make-tree 7 () ()))))))
    ;; => (7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))

    (adjoin-set 11
      (adjoin-set 9
        (adjoin-set 5
          (adjoin-set 7
            (adjoin-set 1
              (make-tree 3 () ()))))))
    ;; => (3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))

    (adjoin-set 11
      (adjoin-set 7
        (adjoin-set 9
          (adjoin-set 1
            (adjoin-set 3
              (make-tree 5 () ()))))))
    ;; => (5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))
    ```
