#lang lambda-calculus/base

; The church encodings and some functions that operate on them

(provide true false if zero one succ)

; booleans
(define true (λ (x)
               (λ (y) x)))

(define false (λ (x)
                (λ (y) y)))

(define if (λ (condition)
             (λ (if-true)
               (λ (if-false)
                 ((condition if-true) if-false)))))


; numerals
(define zero (λ (f)
               (λ (x) x)))

(define one (λ (f)
              (λ (x)
                (f x))))

(define succ (λ (number)
               (λ (f)
                 (λ (x)
                   (number (f x))))))