3. **Explain the effect of interchanging the order in which the base cases in the `cc` procedure**
    **on [page 41 of Abelson and Sussman](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.2) are checked. That is, describe completely the set of**
    **arguments for which the original `cc` procedure would return a different value or behave**
    **differently from a `cc` procedure coded as given below, and explain how the returned values**
    **would differ.**

    ```scheme
    (define (cc amount kinds-of-coins)
      (cond ((or (< amount 0) (= kinds-of-coins 0)) 0)
            ((= amount 0) 1)
            (else ... ) ) )             ;; as in the original version
    ```

    In the original `cc` procedure, the `cond` special form first determines if the value of `amount`
    is equal to `0` before proceeding to the `or` check &mdash; determining if `amount` is greater
    than `0` or if the `kinds-of-coins` variable is equal to `0`. In the original version of the `cc`
    procedure, the first base case returns `1`. Flipping the order, as shown above, may result in
    off-by-one errors when the entire tree is evaluated because the check that returns `0` would be
    evaluated before the check that returns `1`.

4. **Give an algebraic formula relating the values of the parameters `b`, `n`, `counter`, and**
    **`product` of the `expt` and `exp-iter` procedures given near the top of**
    **[page 45 of Abelson and Sussman](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.4).**

    The product of `product` and `b` to the `counter` power is always equal to `b` to the `n`th power.
