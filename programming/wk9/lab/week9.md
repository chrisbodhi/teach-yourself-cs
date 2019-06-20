1. 3.12: _The following procedure for appending lists was introduced in section 2.2.1:_

    ```scheme
    (define (append x y)
      (if (null? x)
          y
          (cons (car x) (append (cdr x) y))))
    ```

    _`Append` forms a new list by successively consing the elements of `x` onto `y`. The procedure `append!` is similar to `append`, but it is a mutator rather than a constructor. It appends the lists by splicing them together, modifying the final pair of `x` so that its `cdr` is now `y`. (It is an error to call `append!` with an empty x.)_

    ```scheme
    (define (append! x y)
      (set-cdr! (last-pair x) y)
      x)
    ```

    _Here `last-pair` is a procedure that returns the last pair in its argument:_

    ```scheme
    (define (last-pair x)
      (if (null? (cdr x))
          x
          (last-pair (cdr x))))
    ```

    _Consider the interaction_

    ```scheme
    (define x (list 'a 'b))
    (define y (list 'c 'd))
    (define z (append x y))
    z
    => (a b c d)
    (cdr x)
    => <response>
    (define w (append! x y))
    w
    => (a b c d)
    (cdr x)
    => <response>
    ```

    _What are the missing `<response>`s? Draw box-and-pointer diagrams to explain your answer._

    The first `(cdr x)` points to the end of the initial definition of `x`, that is, a list of `'b` and `null`.

    The second `(cdr x)` points to the mutated `x`, with its post-`append!`-ed `(b c d)`, and that `(c d)` pointing to the value of `y`. This may be proven by changing the value of `y` and seeing how `w` changes to reflect that.

2. _Suppose that the following definitions have been provided._

    ```scheme
    (define x (cons 1 3))
    (define y 2)
    ```

    _A CS 61A student, intending to change the value of `x` to a pair with `car` equal to 1 and `cdr` equal to 2, types the expression `(set! (cdr x) y)` instead of `(set-cdr! x y)` and gets an error. Explain why._

    The procedure cannot be run because the `cdr` of `x` is the number 3, not a symbol. Therefore, since it's a primitive value, and not a symbol, the value cannot be overwritten.

3. a. _Provide the arguments for the two `set-cdr!` operations in the blanks below to produce the indicated effect on `list1` and `list2`. Do not create any new pairs; just rearrange the pointers to the existing ones._

    ```scheme
    > (define list1 (list (list 'a) 'b))
    list1
    > (define list2 (list (list 'x) 'y))
    list2
    > (set-cdr! (car list1) (append (car list2) (cdr list1))) ;; answer
    okay
    > (set-cdr!  (car list2) (cdr list1)) ;; answer
    okay
    > list1
    ((a x b) b)
    > list2
    ((x b) y)
    ```

  b. _skipping more box and pointer diagrams_

4. a. _3.13:  What happens if we try to compute `(last-pair z)`?_

    I expect we'll run out of memory because there is no last pair -- `z` is a loop that goes on forever.

4. b. _3:14: Explain what `mystery` does in general._

    ```scheme
    STk> v
    (a)
    STk> w
    (d c b a)
    ```

    It returns a reversed version of the input list, while destroying the input. 😐
