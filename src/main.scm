;; Copyright (c) 2012, Alvaro Castro-Castilla. All rights reserved.
;; Game by: Daniel Sanchez, Alejandro Cabeza, Carlos Belmonte and Juan Maria Vergara

(load "physics")

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
                (timer 0))
       ;;Draw neutral canvas
       (draw:fill-color! (make-color/rgba 0 0 0 1))
       (draw:rectangle/corner-corner 0 0 maxx maxy)

       ;;Draw floor
       (draw:fill-color! (make-color/rgba 0 0 1 1))
       (draw:rectangle/corner-sides 0 540 1280 180)

       ;;Draw players
       (draw:fill-color! (make-color/rgba 1 0 1 1))
       ;;(draw:circle/center init-c-pos-x b-pos-y 10) 
       (draw:rectangle/center-sides (/ maxx 2) b-pos-y 10.0 10.0)

       ;;Obstacle Draw & Moves
       (move-obstacle timer 2500 300)
      
       ;;SURFACE
       (draw:on surface)
       ;;EXIT
       (if (input:key-pressed? 27)
           (exit 0))
       (sdl::delay 20)
       ;;Main loop
       (loop 
        
        
        ;;b-pos-y
        (Y-movement b-state b-pos-y init-c-pos-y jump-v)

        ;;b-state
        (Y-state b-state b-pos-y init-c-pos-y 32)
        (- timer 20))))))
