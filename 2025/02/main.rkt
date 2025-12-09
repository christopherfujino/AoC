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

(let ([ids
       ((compose1 (lambda (raw) (string-split raw ",")) port->string open-input-file)
    "input.txt")]
      [invalid_ids (foldl
    (lambda (invalid_ids id_range)
      (let ([id_range (string-split id_range "-")])
        (if ((not (= (length id_range) 2)))
            (error "Unreachable")
            (let (
                   [start (string->number (car id_range))]
                   [ender ((compose string->number string-trim cdr) id_range)])
                   (letrec ([iter
                              (lambda (invalid_ids cur)
                                (if (> cur ender)
                                    invalid_ids
                                    (let ([invalid_ids
                                            (if (not (validate cur))
                                                (cons cur invalid_ids)
                                              )])

                                      )
                                    ))])
                     (printf "TODO: implement iter body\n")
                     )
                   )
            )))
    null ; i.e. an empty list
    ids
    )]
      )

  )
