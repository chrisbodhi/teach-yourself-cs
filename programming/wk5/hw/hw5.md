- **1.2.24**: Suppose we evaluate the expression `(list 1 (list 2 (list 3 4)))`. Give the result printed by the interpreter, the corresponding box-and-pointer structure, and the interpretation of this as a tree.

    ```scheme
    (1 (2 (3 4)))
    ```

- **1.2.26**: Suppose we define `x` and `y` to be two lists:

    ```scheme
    (define x (list 1 2 3))
    (define y (list 4 5 6))
    ```

    What's the output of the following?

    ```scheme
    (append x y)
    ;; (1 2 3 (4 5 6))
    ;; but actually
    ;; (1 2 3 4 5 6)

    (cons x y)
    ;; ((1 2 3) (4 5 6))
    ;; but actually
    ;; ((1 2 3) 4 5 6)

    (list x y)
    ;; (1 2 3 4 5 6)
    ;; but actually
    ;; ((1 2 3) (4 5 6))
    ```
