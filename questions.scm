(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.
(define (cons-all first rests)
  (map (lambda (x) (cons first x)) rests)
)

(define (zip pairs)
  (list (map car pairs) (map cadr pairs)
))

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper i s)
    (cond
      ((null? s) nil)
      (else (cons (list i (car s)) (helper (+ i 1) (cdr s))))
      )
    )
    (helper 0 s)
  )
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  ; Uses partition ex in ch 1 except where m is *list* of possible denominations (thus we use list comprehension instead of  eg m-1)
  (define (partition-n-change n m)
    (cons-all (car m) (list-change (- n (car m)) m))
  )
  (cond
    ((or (null? denoms) (< total 0)) nil)
    ((= 0 total) '(()) )
    (else (append (partition-n-change total denoms) (list-change total (cdr denoms))))
  )
)
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           ;simplify this into two functions below in order to make this more readable
          (define (lambda-fn values body) (cons 'lambda (cons (car (zip values)) (let-to-lambda body))))
          (define (lambda-operands values) (let-to-lambda (car (cdr (zip values)))))
           (cons
              (lambda-fn values body)
              (lambda-operands values))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
