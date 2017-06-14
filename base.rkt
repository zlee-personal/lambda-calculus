#lang racket

; the expander for a strict lambda calculus

(provide
 #%top-interaction
 #%module-begin
 provide
 require
 (rename-out
  (new-lambda lambda)
  (new-lambda λ)
  (new-define define)
  (no-literals #%datum)
  (1-arg-app #%app)
  (unbound-as-free #%top)))


(require (for-syntax syntax/parse)) ; for better macros


; reader module (lets user not have to specify s-exp reader)
(module reader syntax/module-reader
  lambda-calculus/base)



; functions can only have one argument so this isn't really neccesary
; unless user imports some non-lambda-calculus library
(define-syntax-rule (1-arg-app f x)
  (#%app f x))


; free variables are ok
(define-syntax-rule (unbound-as-free . u)
  (free-variable 'u))


; no syntax sugar for functions
; like (define (x a) a)
; only meant to be used in the lambda-calculus language
(define-syntax (new-define stx)
  (syntax-parse stx
    [(_ id:id expr:expr) #'(define id expr)]))


; 1 arg lambda that evaluates body
; it is just a fancy way of creating a
; lambda-structure struct
(define-syntax (new-lambda stx)
  (syntax-parse stx
    [(_ (parameter:id) body:expr)
     #'(lambda-structure 'parameter
                         ; let the parameter be a free variable
                         ; so it isn't undefined when evaluating body
                         (let ([parameter (free-variable 'parameter)])
                           body)
                         (lambda (parameter) ; the actual function
                           body))]))


; struct that represents a lambda
(struct lambda-structure (parameter body function)
  #:property prop:procedure 2 ; function should hold the function
  #:methods gen:custom-write
  [(define (write-proc obj port mode)
     (display `(λ (,(lambda-structure-parameter obj)) ,(lambda-structure-body obj))
              port))])

; this makes unbound variables print nicer
(struct free-variable (symbol)
  ; in case some madman wants to apply an unbound variable
  #:property prop:procedure (lambda (self arg) (variable-application self arg))
  #:methods gen:custom-write
  [(define (write-proc obj port mode)
     (display (free-variable-symbol obj) port))])

; this make variable applications look nicer
(struct variable-application (free arg)
  ; in case some madman wants to apply an application of an unbound identifier
  #:property prop:procedure (lambda (self arg) (variable-application self arg))
  #:methods gen:custom-write
  [(define (write-proc obj port mode)
     (display `(,(variable-application-free obj) ,(variable-application-arg obj))
              port))])

; in case some buffoon tries to use literals
(define-syntax (no-literals stx)
  (syntax-case stx ()
    [(_ . literal) (raise-syntax-error 'literals
                                       "no literals are allowed"
                                       #'literal)]))
