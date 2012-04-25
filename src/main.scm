;; Copyright (c) 2012, Alvaro Castro-Castilla. All rights reserved.
;; Game by: Daniel Sanchez, Alejandro Cabeza, Carlos Belmonte and Juan Maria Vergara
 

           
 
(pg:app
 setup: (lambda (resources)
          (make-environment 600 400 resources #f))
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
          (jump-v 5))
     (let loop ((b-pos-y init-c-pos-y)
                (b-state 'fall))
       (pp b-pos-y)
       ;;Draw neutral canvas
       (draw:fill-color! (make-color/rgba 0 0 0 1))
       (draw:rectangle/corner-corner 0 0 maxx maxy)
       ;;Draw players
       (draw:fill-color! (make-color/rgba 1 0 1 1))
       ;;(draw:circle/center init-c-pos-x b-pos-y 10) 
       (draw:rectangle/center-sides init-c-pos-x b-pos-y 10.0 10.0)

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
          b-state)))))))
