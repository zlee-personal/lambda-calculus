lambda-calculus
===============
A dsl written in racket meant for evaluating lambda calculus expressions.

This is a work in progress and feedback is welcome.

To install: `raco pkg install <whatever this git repository is called>` or clone this repository and `cd` into it and run `raco pkg install`.

Examples (Use `#lang lambda-calculus` or `racket -I lambda-calculus`):

`(lambda (x) x)` -> `(λ (x) x)`
`((lambda (x) (lambda (y) (x y))) (lambda (z) f))` -> `(λ (y) f)`

See source (base.rkt) and scribble documentation (scribblings/lambda-calculus.scrbl) for more.  If you install the package as shown above you can do `raco docs lambda-calculus`.
