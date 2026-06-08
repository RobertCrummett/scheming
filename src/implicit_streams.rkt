#lang sicp

;; A stream of all ones!

(define ones (cons-stream 1 ones))
