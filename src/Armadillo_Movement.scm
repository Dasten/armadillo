;;Sistema de Referencia: (maxx/2, maxy/2)

;;Acceleration

;;Plain_Speed: 11.5 pixels/ms
;;Max_Pendant: 1.22rads
;;


(define (acceleration angle)
  (* 3 (sin angle)))

;;Speed

(define (speed current_speed max_speed min_speed plain_speed pendant) 
  (cond ((equal? pendant null)
         ((= current_speed plain_soeed)
          current_speed
          ((< current_speed plain_speed)
           (+ current_speed (* (acceleration angle) 10))
           (- current_speed (* (acceleration angle) 10)))))
         ((equal? pendant up)         
         ((= current_speed min_speed)
          current_speed
          (- current_speed (* (acceleration angle) 10)))
         ((= current_speed max_speed)
          speed
          (+ current_speed (* (acceleration angle) 10))))))


;;Movement

(define (horizontal_move current_speed initial_speed current_pos min_x max_x)
  (cond ((= current_speed initial_speed)
         ((= armadillo-pos-x 0)
          armadillo-pos-x
          ((< 0 armadillo-pos-x)
           (- current_pos (* current_speed 10)) 
           (+ current_pos (* current_speed 10)))))
        ((< current_speed initial_speed)
         ((= armadillo-pos-x min_x)
          armadillo-pos-x
          (- current_pos (* current_speed 10)))
        ((> current_speed initial_speed)
         ((= armadillo-pos-x max_x)
          (armadillo_pos_x)
          (+ current_pos (* current_speed 10))))))) 
