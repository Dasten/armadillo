(define (acceleration angle)
(* 9.8 (sin angle)))  ;;;; Remodelar

(define (speed speed base_speed max_speed min_speed acceleration side) 
  (if (equal? side up)
      (if (= speed min_speed)
          speed
          (- speed (* acceleration 10000)))
      (if (= speed max_speed)
          speed
          (+ speed (* acceleration 10000)))))

(define (horizontal_move speed min_x max_x)





)

(horizontal_move (speed 0.5 0.5 0.8 (aceleration (/ pi 4)) up) (* 0.2 maxx) (* 0.8 maxx))