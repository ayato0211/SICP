(define-module sicp.util
  (export prime? square fib filter accumulate enumerate-interval enumerate-tree flatmap))

(select-module sicp.util)

(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond
     ((> (square test-divisor) n) n)
     ((divides? test-divisor n) test-divisor)
     (else
      (find-divisor n (+ test-divisor 1)))))
  (define (divides? a b)
    (zero? (modulo b a)))
  (= n (smallest-divisor n)))

(define (square x)
  (* x x))

(define (fib n)
  (cond ((zero? n) 0)
	((= n 1) 1)
	(else (+ (fib (- n 1))
		 (fib (- n 2))))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
	((predicate (car sequence))
	 (cons (car sequence)
	       (filter predicate (cdr sequence))))
	(else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) '())
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree))
		      (enumerate-tree (cdr tree))))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(provide "sicp/util")

