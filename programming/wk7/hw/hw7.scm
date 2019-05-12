;; 1. Objects of the class `random-generator` will accept two messages.
;;    The message `number` means “give me a random number in your range”
;;    while `count` means “how many number requests have you had?” The class
;;    has an instantiation argument that specifies the range of random
;;    numbers for this object.

(define-class (random-generator range-end)
  (instance-vars (how-many 0))
  (method (number)
          (set! how-many (+ how-many 1))
          (random range-end))
  (method (count)
          how-many))

;; 2. Define the class `coke-machine`. The instantiation arguments for a
;;    `coke-machine` are the number of Cokes that can fit in the machine
;;    and the price (in cents) of a Coke.

(define-class (coke-machine capacity cost-in-cents)
  (instance-vars (inventory 0) (coins-toward-cost 0))
  (method (deposit pennies)
          (set! coins-toward-cost (+ coins-toward-cost pennies)))
  (method (coke)
          (if (< inventory 1)
              (error "MACHINE EMPTY"))
          (if (< coins-toward-cost cost-in-cents)
              (error "NOT ENUFF LOOT"))
          (set! inventory (- inventory 1))
          (if (> coins-toward-cost cost-in-cents)
              (- coins-toward-cost cost-in-cents)))
  (method (fill cans)
          (set! inventory (+ inventory cans))))

;; 3. Write a class definition for `deck`. When instantiated, a deck object
;;    should contain a shuffled deck of 52 cards. A deck object responds to
;;    two messages: `deal` and `empty?`. It responds to deal by returning
;;    the top card of the deck, after removing that card from the deck; if
;;    the deck is empty, it responds to deal by returning `()`. It responds 
;;    to `empty?` by returning `#t` or `#f`, according to whether all cards
;;    have been dealt.

;; Given: an ordered deck
(define ordered-deck '(AH 2H 3H 4H 5H 6H 7H 8H 9H 10H JH QH KH AS 2S 3S 4S 5S 6S 7S 8S 9S 10S JS QS KS AD 2D 3D 4D 5D 6D 7D 8D 9D 10D JD QD KD AC 2C 3C 4C 5C 6C 7C 8C 9C 10C JC QC KC))

;; Given: a shuffle function
(define (shuffle deck)
  (if (null? deck)
      '()
       (let ((card (nth (random (length deck)) deck)))
         (cons card (shuffle (remove card deck))))))

;; "Write a class definition for `deck`."
(define-class (deck)
  (instance-vars (shuffled-deck (shuffle ordered-deck)))
  (method (deal)
          (if (ask self 'empty?)
              '()
              (let ((top-card (car shuffled-deck)))
                (set! shuffled-deck (cdr shuffled-deck))
                top-card)))
  (method (empty?)
          (empty? shuffled-deck)))

;; 4. Write a class `miss-manners` that takes an object as its instantiation
;;    argument. The new `miss-manners` object should accept only one
;;    message, namely `please`.

(define-class (miss-manners obj)
  (method (please msg msg-arg)
          (ask obj msg msg-arg))
  (default-method (error "ERROR: NO METHOD " message)))

;; STk> (define m-pete (instantiate miss-manners pete))
;; m-pete
;; STk> (ask m-pete 'ask 'chortle)
;; *** Error:
;;     ERROR: NO METHOD ask
;; Current eval stack:
;; __________________
;;  0    (apply stk-error args)
;; STk> (ask m-pete 'please 'ask 'chortle)
;; (would you please chortle)

