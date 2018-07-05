# scheme-interpreter
Fully functioning interpreter created for Scheme language (Lisp dialect). Done 
for Berkeley CS Program Dev Course in 2017 (sixty one a). It's a pretty beautiful language, with support for things from lambdas to streams. You can do some pretty cool data structure stuff as well, primarily via linked lists. 


This is pretty easy to run. Clone the repo to a folder on your computer. Navigate to this folder in your terminal and run the following:
python3 scheme.py

Here's useful links for documentation:
https://cs61a.org/articles/scheme-spec.html
https://cs61a.org/articles/scheme-primitives.html

Of course, this is a new language so here's some cool things to run. Also check out the 'test.scm' file for more ideas of what to run (and some interesting corner cases). Run:

Math Stuff:
  scm>(define pi 3.14159)
  scm>(define radius 10)
  scm>(* pi (* radius radius))
  ; expect 314.159

  scm> (define circumference (* 2 pi radius))
  scm> circumference
  ; expect 62.8318

Fun with bears:
  scm> (define bears (begin (display 'go )))
  ;expect gobears

Functions and lambdas:
  scm> (define uc (mu (m) (+ m n)))
  ;expect uc

  scm> (define berkeley (lambda (m n) (uc (/ m n))))
  ;expect berkeley

  scm> (berkeley 9000 3)
  ;expect 3003

