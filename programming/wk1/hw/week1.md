1. Do exercise 1.6, page 25. If you had trouble understanding the square root program in the book, explain instead what will happen if you use `new-if` instead of `if` in the `pigl` Pig Latin procedure.

    When Alyssa P. Hacker attempts to use `new-if` in a recursive function, the recursive function
    will not terminate, leaving the interpreter to run out of memory and crash. This is because of
    applicative order -- `sqrt-iter` is called again and again, until the memory runs out.

2. Write a procedure `squares`...

    ```scheme
    (define (square n)
      (* n n))

    (define (square-iter ns acc)
      (if (empty? ns)
          acc
          (square-iter (bf ns) (se acc (square (first ns))))))

    (define (squares ns)
      (square-iter ns '()))

    ;; > (squares '(2 3 4 5))
    ;; (4 9 16 25)
    ```

3. Write a procedure `switch` to swap "me/i" with "you", and "you" with "me,"
    except at the beginning of the sentence

    ```scheme
    (define (switch input)
      (se (swap-i (first input)) (switch-iter '() (bf input))))

    (define (switch-iter acc input)
      (if (empty? input)
          acc
          (se (swap (first input)) (switch-iter acc (bf input)))))

    (define (swap word)
      (cond ((or (equal? word 'i) (equal? word 'me)) 'you)
            ((equal? word 'you) 'me)
            (else word)))

    (define (swap-i word)
      (if (equal? word 'you) 'i word))
    ```

4. Write a predicate `ordered?` -- takes a sentence of numbers & returns `t/f` if numbers are in
    ascending order, false otherwise

    ```scheme
    (define (ordered? numbers)
      (if (or (empty? numbers) (equal? (length numbers) 1))
          #t
          (if (< (first numbers) (second numbers))
              (ordered? (bf numbers))
              #f)))

    (define (second input)
      (first (bf input)))
    ```

5. Write a procedure `ends-e` that takes a sentence as its argument and returns a sentence containing only those words that end in the letter E.

    ```scheme
    (define (ends-e input)
      (ends-e-itr '() input))

    (define (ends-e-itr acc input)
      (if (empty? input)
          acc
          (if (ends-with-e? (first input))
              (ends-e-itr (se acc (first input)) (bf input))
              (ends-e-itr acc (bf input)))))

    (define (ends-with-e? word)
      (equal? (last word) 'e))
    ```

6. Your mission is to devise a test that will tell you whether Scheme’s `and` and `or` are special
    forms or ordinary functions. This is a somewhat tricky problem, but it’ll get you thinking
    about the evaluation process more deeply than you otherwise might.

    ```scheme
    (or (= 4 5) (> 3 1) (= a 3))
    ;; By returning `#t`, and not throwing an error for an unbound variable `a`, this test
    ;; demonstrates that `or` is special form -- not all expressions were evaluated before the
    ;; condition was satisfied.

    (and (= 2 3) (> 6 a))
    ;; In the same way, this expression evaluate to `#f1, due to the first expression, before it can
    ;; reach the unbound variable `a`.
    ```

    Why might it be advantageous for an interpreter to treat `or` as a special form and evaluate
    its arguments one at a time? Can you think of reasons why it might be advantageous to
    treat `or` as an ordinary function?

    ```scheme
    ;; An advantage to how the Scheme interpreter treats `or` is speed -- not all expressions have
    ;; to be evaluated before the expression can come to a conclusion, so to speak.
    ```
