;; 2. Write a procedure `substitute` that take three arguments: sentence, old word, new word, with old word replaced by new word

(define (substitute sent old new)
  (cond ((empty? sent) '())
        ((equal? old (first sent)) (se new (substitute (bf sent) old new)))
        (else (se (first sent) (substitute (bf sent) old new)))))

