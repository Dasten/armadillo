;;Sistema de Referencia: (maxx/2, maxy/2)

;;Acceleration

;;Plain_Speed: 11.5 pixels/ms
;;Max_Pendant: 1.22rads
;;

(define maxx 1280)

(define (acceleration angle)
  (* 3 (sin angle)))

;;Speed

(define (speed current_speed max_speed min_speed plain_speed pendant angle) 
  (cond ((equal? pendant 'null)
         (cond ((= current_speed plain_speed)
                current_speed)                  
               ((< current_speed plain_speed)
                (+ current_speed (* (acceleration angle) 10)))
               ((> current_speed plain_speed)
                (- current_speed (* (acceleration angle) 10)))))
        ((equal? pendant 'up)         
         (if (= current_speed min_speed)
             current_speed
             (- current_speed (* (acceleration angle) 10))))
        ((equal? pendant 'down)
         (if (= current_speed max_speed)
             current_speed                       
             (+ current_speed (* (acceleration angle) 10))))))


;;Movement

(define (horizontal_move current_speed initial_speed current_pos min_x max_x)
  (cond ((= current_speed initial_speed)
         (cond ((= current_pos 0)
                current_pos)
               ((< 0 armadillo-pos-x)
                (- current_pos (* current_speed 10)))
               ((> 0 armadillo-pos-x)
                (+ current_pos (* current_speed 10)))))
        ((< current_speed initial_speed)
         (if (= current_pos min_x)
             armadillo-pos-x
             (- current_pos (* current_speed 10))))
        ((> current_speed initial_speed)
         (if (= current_pos max_x)
             (armadillo_pos_x)
             (+ current_pos (* current_speed 10)))))) 

(display (horizontal_move (speed 13.8 16.0 7.0 11.5 'up 0.8) 11.5 0 (* 0.2 maxx) (* 0.8 maxx)))
(newline)