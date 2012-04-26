;; Copyright (c) 2012, Alvaro Castro-Castilla. All rights reserved.
;; Game by: Daniel Sanchez, Alejandro Cabeza, Carlos Belmonte and Juan Maria Vergara


;;;;;;;;;;ALEX;;;;;;;;;;;;;;;
(define (acceleration angle)
  (* 3 (sin angle)))

;;Speed

(define (speed current_speed max_speed min_speed plain_speed pendant angle) 
  (cond ((equal? pendant 'plain)
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
               ((< 0 current_pos)
                (- current_pos (* current_speed 10)))
               ((> 0 current_pos)
                (+ current_pos (* current_speed 10)))))
        ((< current_speed initial_speed)
         (if (>= current_pos min_x)
             min_x
             (- current_pos (* current_speed 10))))
        ((> current_speed initial_speed)
         (if (<= current_pos max_x)
             max_x
             (+ current_pos (* current_speed 10)))))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

           
 
(pg:app
 setup: (lambda (resources)
          (make-environment 1280 720 resources #f))
 main-loop:
 (lambda (env)
   (let* ((graphics (environment-graphics env))
          (surface (graphics-surface graphics))
          (canvas (graphics-canvas graphics))
          (maxx (environment-size-x env))
          (maxy (environment-size-y env))
          (init-c-pos-x (* maxx 0.50))
          (init-c-pos-y (* maxy 0.50))
          (c-size (* maxy 0.01))
          (jump-v 5)
          (initial-speed 11.5)
          (max-speed 15)
          (min-speed 7))
     (let loop ((b-pos-y init-c-pos-y)
                (b-state 'fall)
                (current-speed initial-speed)
                (angle 0.7)
                (pendant 'up)
                (current-pos (* maxx 0.5))) ;; 'up 'down 'plain
       ;;Draw neutral canvas
       (draw:fill-color! (make-color/rgba 0 0 0 1))
       (draw:rectangle/corner-corner 0 0 maxx maxy)
       ;;Draw players
       (draw:fill-color! (make-color/rgba 1 0 1 1))
       ;;(draw:circle/center init-c-pos-x b-pos-y 10) 
       (draw:rectangle/center-sides current-pos b-pos-y 10.0 10.0)

       ;;SURFACE
       (draw:on surface)
       ;;EXIT
       (if (input:key-pressed? 27)
           (exit 0))
       (sdl::delay 20)
       ;;Main loop
       (loop 
        
        
        ;;b-pos-y
        (cond
         ((and (= b-pos-y init-c-pos-y)
               (eq? b-state 'fall)) init-c-pos-y)
         ((eq? b-state 'fall) (+ b-pos-y jump-v))
         ((eq? b-state 'jump) (- b-pos-y jump-v)))
        ;;b-state
        (cond
         ((and (= b-pos-y init-c-pos-y)
               (input:key-pressed? 32)) 'jump)
         ((<= b-pos-y  (- init-c-pos-y 100.0)) 'fall)
         (else
          b-state))
        ;;current-speed
        (speed current-speed max-speed min-speed initial-speed pendant angle)
        ;;angle
        0
        ;;pendant
        'plain
        ;;current-pos
        (horizontal_move current-speed initial-speed current-pos (* 0.1 maxx) (* 0.2 maxx)))))))
