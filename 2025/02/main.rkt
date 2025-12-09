#!/usr/bin/env racket

#lang racket

(define (validate i)
  (define str (number->string i))
  (define len (string-length str))
  (if (= (modulo len 2) 0)
      (let ([half_len (/ len 2)])
        (let ([first_half (substring str 0 half_len)])
          (let ([second_half (substring str half_len)])
            (not
             (string=? first_half second_half)))))
      #t))

(let* ([ids
        ((compose1 (lambda (raw) (string-split raw ",")) port->string open-input-file)
         "input.txt")]
       [invalid_ids
        (foldl
         (lambda
             (id_range invalid_ids)
           (let ([id_range
                  (string-split id_range "-")])
             (if (not (= (length id_range) 2))
                 (error "Unreachable")
                 (let (
                       [start (string->number (car id_range))]
                       ; (cadr l) == (car (cdr l))
                       [ender ((compose string->number string-trim cadr) id_range)])
                   (letrec ([iter
                             (lambda (invalid_ids cur)
                               (if (> cur ender)
                                   invalid_ids
                                   (let ([invalid_ids
                                          (if (not (validate cur))
                                              (cons cur invalid_ids)
                                              invalid_ids
                                              )])
                                     (iter invalid_ids (+ cur 1))
                                     )))])
                     (iter invalid_ids start)
                     )
                   )
                 )))
         null ; i.e. an empty list
         ids)
        ]
       [sum (foldl (lambda (cur sum) (+ sum cur)) 0 invalid_ids)])

  (printf "~a\n" sum)
  )
