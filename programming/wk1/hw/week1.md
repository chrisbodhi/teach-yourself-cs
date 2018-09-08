1. Do exercise 1.6, page 25. If you had trouble understanding the square root program in the book, explain instead what will happen if you use `new-if` instead of `if` in the `pigl` Pig Latin procedure.

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



    Why might it be advantageous for an interpreter to treat or as a special form and evaluate
    its arguments one at a time? Can you think of reasons why it might be advantageous to
    treat or as an ordinary function?