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

2. SICP ex. 2.62: Give a θ(n) implementation of union-set for sets represented as ordered lists.

3. The file `~cs61a/lib/bst.scm` contains the binary search tree procedures from pages 156–157 of SICP. Using `adjoin-set`, construct the trees shown on page 156.
