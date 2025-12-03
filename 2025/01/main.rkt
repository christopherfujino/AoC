#lang racket

(define src
  (port->string
    (open-input-file "input.txt")))

(define commands
  (string-split src "\n"))

(for-each
  (lambda
    (cmd)
    (printf "The command is: ~s\n" cmd))
  commands)
