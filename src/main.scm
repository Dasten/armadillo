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
          (c-size (* maxy 0.01)))
     (let loop ((b-pos-y init-c-pos-y))
       ;;Draw neutral canvas
       (draw:fill-color! (make-color/rgba 0 0 0 1))
       (draw:rectangle/corner-corner 0 0 maxx maxy)
       ;;Draw players
       (draw:fill-color! (make-color/rgba 1 0 1 1))
       (draw:circle/center init-c-pos-x b-pos-y 10) 
       

       ;;SURFACE
       (draw:on surface)
       ;;EXIT
       (if (input:key-pressed? 27)
           (exit 0))
       ;;Main loop
       (loop  
        (cond
         ((= b-pos-y init-c-pos-y) 
          (if (input:key-pressed? 32) (- init-c-pos-y 100) init-c-pos-y))
         ((< b-pos-y init-c-pos-y) init-c-pos-y)
         (else
          (+ b-pos-y 0.001))))))))