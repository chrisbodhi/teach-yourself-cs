2. _Suppose that we want to define a class called `double-talker` to represent people that always say_
    _things twice..._

    _Determine which of these definitions work as intended._

    ```scheme
    (define-class (double-talker name)
      (parent (person name))
      (method (say stuff) (se (usual 'say stuff) (ask self 'repeat))))

    (define-class (double-talker name)
      (parent (person name))
      (method (say stuff) (se stuff stuff)))


    (define-class (double-talker name)
      (parent (person name))
      (method (say stuff) (usual 'say (se stuff stuff))))
    ```

    Hypothesis is that the second and third definitions work as intended, whereas the first definition will output whatever `repeat` has ready **before** `(usual 'say stuff)` is called.

    After testing, the first definition definitely fails, specifically with the error, `Process scheme segmentation fault: 11`. And, also as expected, the second and third versions work as expected with a simple, one-word input.

    _Determine also for which messages the three versions would respond differently._

    Nothing is standing out, apart from how the first version winds itself into an infinite loop of unending self-reflection and terror.
