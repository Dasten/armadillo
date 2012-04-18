;;Acceleration

(define (acceleration angle)
  (error "To Be Implemented: Speed Formula [(* 9.8 (sin angle)]"))

;;Speed

(define (speed current_speed max_speed min_speed acceleration side) 
  (if (equal? side up)
      (if (= current_speed min_speed)
          current_speed
          (- current_speed (* acceleration 10000)))
      (if (= current_speed max_speed)
          speed
          (+ current_speed (* acceleration 10000)))))

;;Movement

(define (horizontal_move current_speed initial_speed min_x max_x)
  (cond ((= current_speed initial_speed)
         ((= armadillo-pos-x 0)
          armadillo-pos-x
          ((< 0 armadillo-pos-x)
           (error "To Be Implemented: x-(v*t)")
           (error "To Be Implemented: x+(v*t)"))))
        ((< current_speed initial_speed)
         ((= armadillo-pos-x min_x)
          armadillo-pos-x
          (error "To Be Implemented: x-(v*t)")))
        ((> current_speed initial_speed)
         ((= armadillo-pos-x max_x)
          (armadillo_pos_x)
          (error "To Be Implemented: x+(v*t)")))))