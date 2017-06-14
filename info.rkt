#lang info
(define collection "lambda-calculus")
(define deps '("base"
               "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/lambda-calculus.scrbl" ())))
(define pkg-desc "A lambda calculus language")
(define version "0.0")
(define pkg-authors '(vityou))
