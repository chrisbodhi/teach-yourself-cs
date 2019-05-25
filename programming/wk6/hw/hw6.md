- 1.2.74a: _Explain how the individual divisions' files should be structured. In particular, what type information must be supplied?_

    Chiefly, we're concerned with a list of records and a procedure for retrieving a record based on the employee's ID. Ideally, the structure of each division's file would be that of a set, structured as an ordered tree, to provide O(log n) time for access.

- 1.2.74b: _How should the record be structured in order to make this operation work?_

    It can be structured however it wants, as long as we have an accessor procedure for it. Ideally,
    though, it would be structured in such a way that we could run `(get 'salary employee-id)` -- it
    would look like a row in a table with a "salary" column.

- 1.2.74d: _When Insatiable takes over a new company, what changes must be made in order to incorporate the new personnel information into the central system?_

    Accessor procedures will need to be written that can extract the requested information. Then, those accessor prodedures will need to be added to the tables that `get-record`, et al, reference.

- 1.2.76: _As a large system with generic operations evolves, new types of data objects or new operations may be needed. For each of the three strategies -- generic operations with explicit dispatch, data-directed style, and message-passing-style -- describe the changes that must be made to a system in order to add new types or new operations. Which organization would be most appropriate for a system in which new types must often be added? Which would be most appropriate for a system in which new operations must often be added?_

    For systems in which _new types_ are needed frequently, _data-directed_ would be the most beneficial because as new representations are added to the system, existing generic selectors do not need to be updated.

    On the other hand, for systems in which _new operations_ are often added, a _message-passing_ strategy may be the easiest to maintain, due to the need to add the operation in only one place, the applicable object.

- 1.2.77: _Louis Reasoner tries to evaluate the expression `(magnitude z)` where `z` is the object shown in [figure 2.24](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_fig_2.24). To his surprise, instead of the answer 5 he gets an error message from `apply-generic`, saying there is no method for the operation `magnitude` on the types `(complex)`. He shows this interaction to Alyssa P. Hacker, who says "The problem is that the complex-number selectors were never defined for `complex` numbers, just for `polar` and `rectangular` numbers. All you have to do to make this work is add the following to the `complex` package"_

    ```scheme
    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)
    ```

    _Describe in detail why this works. As an example, trace through all the procedures called in evaluating the expression `(magnitude z)` where `z` is the object shown in figure 2.24. In particular, how many times is `apply-generic` invoked? What procedure is dispatched to in each case?_

    Once the `put` procedures are carried out, the `complex` package can then do the required look-ups for the invoked functions, and then pass the data to `apply-generic`.

    ```scheme
    STk> (magnitude (make-complex-from-real-imag 3 4))
    .. -> apply-generic with op = magnitude,  args = ((complex rectangular 3 . 4))
    .... -> apply-generic with op = magnitude,  args = ((rectangular 3 . 4))
    .... <- apply-generic returns 5
    .. <- apply-generic returns 5
    5
    ```

- 1.2.81a: _With Louis's coercion procedures installed, what happens if `apply-generic` is called with two arguments of type `scheme-number` or two arguments of type `complex` for an operation that is not found in the table for those types? For example, assume that we've defined a generic exponentiation operation:_

    ```scheme
    (define (exp x y) (apply-generic 'exp x y))
    ```

    _and have put a procedure for exponentiation in the Scheme-number package but not in any other package:_

    ```scheme
    ;; following added to Scheme-number package
    (put 'exp '(scheme-number scheme-number)
        (lambda (x y) (tag (expt x y)))) ; using primitive expt
    ```

    _What happens if we call `exp` with two complex numbers as arguments?_

    Loop 5eva:

    ```scheme
    ...
    .. -> get with key1 = complex,  key2 = complex
    .. <- get returns #[closure arglist=(z) 55cb34]
    .. -> get with key1 = complex,  key2 = complex
    .. <- get returns #[closure arglist=(z) 55cb34]
    .. -> get with key1 = exp,  key2 = (complex complex)
    .. <- get returns #f
    ...
    ```

- 1.2.81b: _Is Louis correct that something had to be done about coercion with arguments of the same type, or does `apply-generic` work correctly as is?_

It seems to work as is, but I imagine it could be more efficient...

- 1.2.81c: _Modify `apply-generic` so that it doesn't try coercion if the two arguments have the same type._

    ```scheme
    (define (apply-generic op . args)
      (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
          (if proc
              (apply proc (map contents args))
              (if (= (length args) 2)
                  (let ((type1 (car type-tags))
                        (type2 (cadr type-tags))
                        (a1 (car args))
                        (a2 (cadr args)))
                    (if (eq? type1 type2)
                      (apply-generic op a1 a2))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                            (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                            (apply-generic op a1 (t2->t1 a2)))
                            (else
                            (error "No method for these types"
                                    (list op type-tags))))))
                  (error "No method for these types"
                        (list op type-tags)))))))
    ```