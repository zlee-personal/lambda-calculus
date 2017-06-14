# lambda-calculus

vityou

```racket
 #lang lambda-calculus package: lambda-calculus
```

## 1. Introduction

lambda-calculus is a language for writing lambda calculus programs that
uses the same syntax as racket. Is is not pure lambda calculus but you
can choose to use only the pure features. It can also be used in the
racket repl with `racket -I lambda-calculus`.

## 2. Reference

The language offers a limited set of forms.

```racket
(lambda (arg-id) body)
(λ (arg-id) body)     
```

Returns a procedure where `arg-id` is a formal argument and `body` is an
expression that can reference `arg-id`.  `body` is evaluated right away
and all references to arguments are treated as free variables until they
have an actual value.

Examples:

```racket
> (lambda (x) (lambda (y) (x y)))                 
(λ (x) (λ (y) (x y)))                             
> ((lambda (z) (z (lambda (d) d))) (lambda (f) f))
(λ (d) d)                                         
```

Keep in mind that this lambda expression is different from racket’s
normal lambda expression in a few ways. It can only have one argument
and the body is evaluated even though the arguments don’t have values.

```racket
(define id expr)
```

Binds `id` to `expr` just like racket’s normal define form.

Examples:

```racket
> (define a b)             
> (define c (lambda (x) x))
> (c a)                    
b                          
```

The language also provides racket’s `provide` and `require`.

Unbound variables are treated as a special structure called a
free-variable. It is basically a symbol that can be applied.  There are
no literals allowed and only one argument applications are allowed

Examples:

```racket
> a                                         
b                                           
> b                                         
b                                           
> ((c d) f)                                 
(d f)                                       
> random-free-variable                      
random-free-variable                        
> 2                                         
eval:10:0: literals: no literals are allowed
  in: 2                                     
> "hello"                                   
literals: no literals are allowed           
  in: "hello"                               
> ((lambda (x) s) v)                        
s                                           
```
