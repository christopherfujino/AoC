#!/usr/bin/env racket

#lang racket

(define (find_second str)
  (foldl
    (lambda (cur highest)
      (let ([i (- (char->integer cur) 48)])
        (if (> i highest)
            i
            highest)))
    0
    (string->list str)))

;(define (find_first line)
;  (let* ([len (string-length line)]
;         []
;         ))
;  )

(find_second "123456")
