;; 1. Add 'repeater' method to 'person' class
(define-class (person name)
  (instance-vars (previous-message '())) ;; added
  (method (say stuff)
          (set! previous-message stuff) ;; added
          stuff)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
  (method (greet) (ask self 'say (se '(hello my name is) name)))
  (method (repeat) (ask self 'say previous-message))) ;; added

