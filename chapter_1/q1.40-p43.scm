(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (let ((close-enough? (lambda (v1 v2)
			 (< (abs (- v1 v2)) tolerance))))
    (letrec ((try (lambda (guess)
		    (let ((next (f guess)))
		      (if (close-enough? guess next)
			  next
			  (try next))))))
      (try first-guess))))

(define dx 0.00001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))

(define (square x)
  (* x x))
(define (cube x)
  (* x x x))

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))


;;test
(let ((a (newton-method (cubic 2 3 4) 1.0)))
  (inexact->exact (+ (cube a) (* 2 (square a)) (* 3 a) 4)))

