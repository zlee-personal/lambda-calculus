#lang scribble/manual
@require[@for-label[lambda-calculus]]
@(require scribble/eval
          (for-label (only-in racket provide require)))

@title{lambda-calculus}
@author{vityou}

@defmodulelang[lambda-calculus]

@section{Introduction}

lambda-calculus is a language for writing lambda calculus programs that uses the same syntax
as racket.
Is is not pure lambda calculus but you can choose to use only the pure features.
It can also be used in the racket repl with @exec{racket -I lambda-calculus}.


@section{Reference}

The language offers a limited set of forms.

@(define helper-eval (make-base-eval #:lang 'lambda-calculus))

@deftogether[(
              @defform[(lambda (arg-id) body)]
               @defform[(λ (arg-id) body)]
               )]{
 Returns a procedure where @racket[arg-id] is a formal argument and @racket[body]
 is an expression that can reference @racket[arg-id].  @racket[body] is evaluated right away and
 all references to arguments are treated as free variables until they have an actual value.

 @examples[
 #:eval helper-eval
     
 (lambda (x) (lambda (y) (x y)))
 ((lambda (z) (z (lambda (d) d))) (lambda (f) f))
  
 ]

 
 Keep in mind that this lambda expression is different from racket's normal lambda
 expression in a few ways.
 It can only have one argument and the body is evaluated even though the arguments don't have values.
}     


@defform[(define id expr)]{
 Binds @racket[id] to @racket[expr] just like racket's normal define form.
 @examples[
 #:eval helper-eval
 (define a b)
 (define c (lambda (x) x))
 (c a)]}

The language also provides racket's @racket[provide] and @racket[require].


Unbound variables are treated as a special structure called a free-variable.
It is basically a symbol that can be applied.  There are no literals allowed
and only one argument applications are allowed

@examples[
 #:eval helper-eval
 a
 b
 ((c d) f)
 random-free-variable
 2
 "hello"
 ((lambda (x) s) v)]