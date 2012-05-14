;;Practice - Armadillo Game - Carlos Belmonte
(define (move-obstacle speed frequency obstacle-high) 
  (draw:fill-color! (make-color/rgba 0.337 0.925 0.976 1))
  (draw:rectangle/corner-sides (modulo speed frequency) (- 540 obstacle-high) 20 obstacle-high))

(pg:app
 setup: (lambda (resources)
          (make-environment 1280 720 resources #f))
 main-loop: (lambda (env)
              (let* ((graphics (environment-graphics env))
                     (surface (graphics-surface graphics))
                     (canvas (graphics-canvas graphics))
                     (maxx (environment-size-x env))
                     (maxy (environment-size-y env)))
                (let loop (( mov 0))
                 
                  ;;COLOR DEL MARCO DEL CUADRADO DE LA PANTALLA (BLANCO DE 1 PX)
                  (draw:stroke! (make-color/rgba 1 1 1 1) 1.0 #f)
                  ;;COLOR DEL RELLENO DEL CUADRADO DE LA PANTALLA (NEGRO)
                  (draw:fill-color! (make-color/rgba 0 0 0 1))
                  ;;DIBUJAMOS EL CUADRADO DE LA PANTALLA (Background)
                  (draw:rectangle/corner-corner 0 0 maxx maxy)
     
                  ;; SE PINTA EL SUELO CON SU COLOR
                  (draw:fill-color! (make-color/rgba 0 0 1 1))
                  (draw:rectangle/corner-sides 0 540 1280 180)

                  ;; SE LLAMA A LA FUNCION PARA DIBUJAR EL OBSTACULO
                  ;;(if (input:key-pressed? 32))
                  (move-obstacle mov 2500 300)

                  (if (input:key-pressed? 27)
                      (exit 0))       

                  (draw:on surface)
                  (loop (- mov 2))))))
