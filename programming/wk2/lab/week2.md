1. Evalute `lambda` expressions in the Scheme REPL...

2. Write a procedure `substitute` that take three arguments: sentence, old word, new word, with old word replaced by new word

    ```scheme
    (define (substitute sent old new)
        (cond ((empty? sent) '())
              ((equal? old (first sent)) (se new (substitute (bf sent) old new)))
              (else (se (first sent) (substitute (bf sent) old new)))))
    ```

3. Consider a Scheme function `g` for which the expression

    ```scheme
    ((g) 1)
    ```

    return the value `3` when evaluated. Determine how many arguments `g` has.

    - `g` has one argument, a number, which is `1` in the case of this evaluation.

    In one word, describe as best you can the type of the value returned by `g`.

    - Function

4. For each of the following expressions, what must `f` be in order for the evaluation of the
    expression to succeed, without causing an error?  For each expression, give a definition of `f`
    such that evaluating the expression will not cause an error, and say what the expression’s value
    will be, given your definition.

    ```scheme
    f           ;; any defined variable or function, e.g. (define f 3) or (define (f x) x)

    (f)         ;; a function that accepts zero arguments, e.g. (define (f) 3)

    (f 3)       ;; a function that accepts one argument, e.g. (define (f x) x)

    ((f))       ;; a function that accepts zero arugments and returns a function that also accepts
                ;; zero arguments, e.g. (define (f) (lambda () 3))

    (((f)) 3)   ;; a function that accepts zero arugments, which returns a function that accepts
                ;; zero arguments and returns a function that accepts one argument, e.g.
                ;; (define (f) (lambda () (lambda (x) (+ x 3)))
    ```

5. Find the values of the expressions, where `1+` is a procedure that adds one to its argument, and
    `t` is `(define (t f) (lambda (x) (f (f (f x)))))`:

    ```scheme
    ((t 1+) 0)
    ;; guess: 3
    ;; answer: 3

    ((t (t 1+)) 0)
    ;; guess: 9
    ;; answer: 9

    (((t t) 1+) 0)
    ;; guess: ???
    ;; answer: 27
    ```

6. Find the values of the expressions, where `s` is `(define (s x) (+ 1 x))`, and
    `t` is defined as above:

    ```scheme
    ((t s) 0)
    ;; guess: 3
    ;; answer: 3

    ((t (t s)) 0)
    ;; guess: 9
    ;; answer: 9

    (((t t) s) 0)
    ;; guess: 27
    ;; answer: 27
    ```

7. Write and test the `make-tester` procedure. Given a word `w` as argument, `make-tester` returns a
    procedure of one argument `x` that returns `true` if `x` is equal to `w` and `false` otherwise.

    ```scheme
    (define (make-tester w)
       (lambda (x) (equal? w x)))
    ```
