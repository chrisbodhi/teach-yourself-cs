4. _For the following definition, show the result of computing `(plus1 5)` using the substitution model._
  _That is, show the expression that results from substituting `5` for `var` in the body of `plus1`,_
  _and then compute the value of the resulting expression._

    ```scheme
    (define (plus1 var)
      (set! var (+ var 1))
      var)
    ```

    Substituting `5` yields

    ```scheme
    (set! 5 (+ 5 1)) 5
    ```

    which reads as the procedure is going to change the value of the number 5, but then still return 5. However...

    _What is the actual result from Scheme?_

    ```scheme
    STk> (plus1 5)
    6
    ```

    🙃
