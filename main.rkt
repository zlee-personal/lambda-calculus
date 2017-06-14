#lang racket/base

(require "base.rkt"
         "misc-functions.rkt"
         "church-encodings.rkt")
(provide (all-from-out "base.rkt"
                       "misc-functions.rkt"
                       "church-encodings.rkt"))

(module reader syntax/module-reader
  lambda-calculus/main)

(module+ test
  (require rackunit))

(module+ test
  ;; Tests to be run with raco test
  )
