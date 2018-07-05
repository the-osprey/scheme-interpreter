; This shows some nice applications of what we can use the Scheme language for!

(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions
(define (cons-all first rests)
  (map (lambda (x) (cons first x)) rests)
)

(define (zip pairs)
  (list (map car pairs) (map cadr pairs)
))

;; Application 1
;; Returns a list of two-element lists
(define (enumerate s)
  (define (helper i s)
    (cond
      ((null? s) nil)
      (else (cons (list i (car s)) (helper (+ i 1) (cdr s))))
      )
    )
    (helper 0 s)
  )

;; Application 2
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
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

;; Application 3
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
         expr
         )
        ((quoted? expr)
         expr
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           (cons form (cons params (let-to-lambda body)))
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ;simplify this into two functions below in order to make this more readable
          (define (lambda-fn values body) (cons 'lambda (cons (car (zip values)) (let-to-lambda body))))
          (define (lambda-operands values) (let-to-lambda (car (cdr (zip values)))))
           (cons
              (lambda-fn values body)
              (lambda-operands values))
           ))
        (else
         (map let-to-lambda expr)
         )))
