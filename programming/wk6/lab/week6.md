1. Load `scheme-1` from the file `~cs61a/lib/scheme1.scm`.

    a. Trace in detail how a simple procedure call such as
      `((lambda (x) (+ x 3)) 5)` is handled in `scheme-1`.

    b. Try inventing higher-order procedures; since you don’t have define you’ll have to use the Y-combinator trick.

    c. Since all the Scheme primitives are automatically available in `scheme-1`, you might think you could
use STk’s primitive `map` function. Try these examples:

        - Scheme-1: (map first ’(the rain in spain))
        - Scheme-1: (map (lambda (x) (first x)) ’(the rain in spain))

      Explain the results.

    d. Modify the interpreter to add the `and` special form. Test your work. Be sure that as soon as a false
value is computed, your `and` returns `#f` without evaluating any further arguments.

**For the rest of the lab, start by reading SICP section 2.3.3 (pages 151–161).**

2. SICP ex. 2.62: Give a θ(n) implementation of union-set for sets represented as ordered lists.

3. The file `~cs61a/lib/bst.scm` contains the binary search tree procedures from pages 156–157 of SICP. Using `adjoin-set`, construct the trees shown on page 156.
