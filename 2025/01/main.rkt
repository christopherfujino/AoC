#!/usr/bin/env racket

#lang racket

(let ([lines
       ((compose string-split port->string open-input-file) "input.txt")])
  (let ([pos_zeroes
         (foldl
          (lambda (line pos_zeroes_pair)
            (let ([pos (car pos_zeroes_pair)]
                  [zeroes (cdr pos_zeroes_pair)]
                  [cmd (substring line 0 1) ])
              (let ([distance (string->number (substring line 1))])
                (let ([pos (match cmd
                             ["L" (- pos distance)]
                             ["R" (+ pos distance)]
                             [_ (error "Crash!")])])
                  (let ([pos (modulo pos 100)])
                    (let ([zeroes (if (= pos 0)
                                      (+ zeroes 1)
                                      zeroes)])
                      (cons pos zeroes)))))))
            ; initializer
            (cons 50 0)
            lines)])
        (printf "Number of zeroes: ~a\n" (cdr pos_zeroes))))
  