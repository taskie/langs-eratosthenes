(define (sieve size)
  (if (<= size 1)
      (make-vector size #f)
      (let ((sieveArray (make-vector size #t))
	    (root (+ 1 (floor->exact (sqrt size)))))
	(vector-set! sieveArray 0 #f)
	(vector-set! sieveArray 1 #f)
	(let outer((i 2))
	  (when (< i root)
		(when (vector-ref sieveArray i)
		      (let inner((j (* i i)))
			(when (< j size)
			      (vector-set! sieveArray j #f)
			      (inner (+ j i)))))
		(outer (+ i 1))))
	sieveArray)))

(define (countPrime n)
  (let ((xs (sieve (+ n 1))))
    (let loop((i 0) (counter 0))
      (if (< i (vector-length xs))
	  (loop (+ i 1) (if (vector-ref xs i) (+ counter 1) counter))
	  counter))))

(define (main args)
  (print (countPrime
	  (if (null? (cdr args))
	      10000000
	      (string->number (cadr args))))))
