## CS 61A
### Week 3 Lab

This lab exercise concerns the change counting program on pages 40–41 of Abelson and Sussman.

1. **Identify two ways to change the program to _reverse_ the order in which coins are tried, that is, to change**
    **the program so that pennies are tried first, then nickels, then dimes, and so on.**

    - For the `kinds-of-coins` counter in `cc`, initialize at `0` and increment until the counter is equal to the passed-in argument.
    - Flip `first-denomination` so that it returns the the lowest coin value for the highest denomination, and vice versa.

2. **Abelson and Sussman claim that this change would not affect the _correctness_ of the computation.**
    **However, it does affect the efficiency of the computation. Implement one of the ways you devised in**
    **exercise 1 for reversing the order in which coins are tried, and determine the extent to which the number**
    **of calls to cc is affected by the revision. Verify your answer on the computer, and provide an explanation.**

    **_Hint: limit yourself to nickels and pennies, and compare the trees resulting from (cc 5 2) for each order._**

    Seven steps for `(cc 5 2)` with the implementation from the book, ___ steps for `(cc 5 2)` for the latter implementation suggested by the answer to the first question above. (double???) Reversing starts out with subtracting one a whole bunch of times.

3. **Modify the `cc` procedure so that its `kinds-of-coins` parameter, instead of being an integer, is a**
    **sentence that contains the values of the coins to be used in making change. The coins should be tried in the**
    **sequence they appear in the sentence. For the `count-change` procedure to work the same in the revised**
    **program as in the original, it should call `cc` as follows:**
    ```
    (define (count-change amount)
      (cc amount ’(50 25 10 5 1)) )

    (define (cc amount s)
      (cond ((= amount 0) 1)
            ((or (< amount 0) (= (length s) 0)) 0)
            (else (+ (cc amount (bf s))
                    (cc (- amount (first s))
                        s)))))
    ```

4. **Write `type-check`. Its arguments are a function, a type-checking**
    **predicate that returns #t if and only if the datum is a legal**
    **argument to the function, and the datum.**

    ```scheme
    (define (type-check fn predicate datum)
      (if (predicate datum)
          (fn datum)
          #f))
    ```

5. **Instead, write a procedure make-safe that you can use this way:**
    `(define safe-sqrt (make-safe sqrt number?))`

    ```scheme
    (define (make-safe fn predicate)
      (lambda (datum)
        (type-check fn predicate datum)))
    ```
