;; Copyright (c) 2012, Alvaro Castro-Castilla. All rights reserved.
;; Game by: Daniel Sanchez, Alejandro Cabeza, Carlos Belmonte and Juan Maria Vergara
 

(define (winner-display player maxx maxy)
  (let ((winner1
         (lambda ()
           (draw:stroke! (make-color/rgba 1 1 1 1) 1.0 #f)
           (draw:fill-color! (make-color/rgba 1 0 0 0.25))
           (draw:rectangle/corner-corner 100 100 (- maxx 100) (- maxy 100))
           (draw:fill-color! (make-color/rgba 0 0 0 1))
           (draw:segment 225 125 225 225)
           (draw:segment 200 225 250 225)
           (draw:segment 225 125 200 175)))
        (winner2
         (lambda ()
           (draw:stroke! (make-color/rgba 1 1 1 1) 1.0 #f)
           (draw:fill-color! (make-color/rgba 0 0 1 0.25))
           (draw:rectangle/corner-corner 100 100 (- maxx 100) (- maxy 100))
           (draw:fill-color! (make-color/rgba 0 0 0 1))
           (draw:segment 200 125 250 125)
           (draw:segment 250 125 250 175)
           (draw:segment 250 175 200 175)
           (draw:segment 200 175 200 225)
           (draw:segment 200 225 250 225))))
    (draw:fill-color! (make-color/rgba 0 1 0 1))
    (draw:rectangle/corner-corner 0 0 maxx maxy)
    (draw:fill-color! (make-color/rgba 1 0 1 1))
    (draw:segment 125 225 125 125)
    (draw:segment 125 125 175 125)
    (draw:segment 175 125 175 175)
    (draw:segment 175 175 125 175)
    (draw:segment 275 175 275 250)
    (draw:segment 275 250 325 250)
    (draw:segment 300 250 300 200)
    (draw:segment 325 250 325 175)
    (draw:segment 350 175 400 175)
    (draw:segment 375 175 375 250)
    (draw:segment 350 250 400 250)
    (draw:segment 425 175 425 250)
    (draw:segment 425 175 475 250)
    (draw:segment 475 250 475 175)
    (if (eq? player 'player1)
        (winner1 maxx maxy)
        (winner2 maxx maxy))))
                
 

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
          (box-size-x (* maxx 0.01))
          (box-size-y (* maxy 0.20))
          (box-1-pos-x (* maxx 0.05))
          (box-2-pos-x (- maxx (* maxx 0.05)))
          (max-pos-y (- maxy (* box-size-y 0.50)))
          (min-pos-y (* box-size-y 0.50))
          (init-c-pos-x (* maxx 0.50))
          (init-c-pos-y (* maxy 0.50))
          (c-size (* maxy 0.01))
          (scoreboard
           (lambda (score-p1 score-p2)
             (let recur ((iter1 score-p1)
                         (iter2 score-p2))
               (if (= iter1 0)
                   (if (= iter2 0)
                       '()
                       (begin
                         (draw:fill-color! (make-color/rgba 1 0 0 1))
                         (draw:rectangle/corner-sides
                          (+ (+ (* maxx 0.5)
                                (* iter2 (* maxx 0.01)))
                             (* maxx 0.1))
                          (* maxy 0.01)
                          (* maxx 0.005)
                          (* maxy 0.1))
                         (recur iter1
                                (- iter2 1))))        
                   (begin
                     (draw:fill-color! (make-color/rgba 0 0 1 1))
                     (draw:rectangle/corner-sides
                      (- (- (* maxx 0.5) (* iter1 (* maxx 0.01))) (* maxx 0.1))
                      (* maxy 0.01)
                      (* maxx 0.005)
                      (* maxy 0.1))
                     (recur (- iter1 1)
                            iter2)))))))
     (let loop ((box-1-pos-y (* maxy 0.50))
                (box-2-pos-y (* maxy 0.50))
                (c-pos-x init-c-pos-x)
                (c-pos-y init-c-pos-y)
                (c-dir-y 0.1)
                (c-dir-x 0.1)
                (score-p1 0)
                (score-p2 0))
       ;;Draw neutral canvas
       (draw:fill-color! (make-color/rgba 0 0 0 1))
       (draw:rectangle/corner-corner 0 0 maxx maxy)    
       (draw:fill-color! (make-color/rgba 1 1 1 1))
       (draw:rectangle/center-sides  (* maxx 0.5) (* maxy 0.5) (* maxx 0.005) maxy)
       (draw:circle/center (* maxx 0.5) (* maxy 0.5) (* maxx 0.08))
       (draw:fill-color! (make-color/rgba 0 0 0 1))
       (draw:circle/center (* maxx 0.5) (* maxy 0.5) (* maxx 0.075))
       ;;Draw players
       ;;P1
       (draw:fill-color! (make-color/rgba 0 0 1 1))
       (draw:rectangle/center-sides  box-1-pos-x box-1-pos-y box-size-x box-size-y)
       ;;P2
       (draw:fill-color! (make-color/rgba 1 0 0 1))
       (draw:rectangle/center-sides  box-2-pos-x box-2-pos-y box-size-x box-size-y) 
       ;;Scoreboard
       (scoreboard score-p1 score-p2)
       ;;Draw ball
       (draw:fill-color! (make-color/rgba 1 1 1 1))
       (draw:circle/center c-pos-x c-pos-y c-size)
       (draw:on surface)
                 
       (cond
        ((= score-p1 3) (let recur ((x 0))
                          (winner-display 'player1)
                          (if (input:key-pressed? 27)
                              (exit 0))
                          (recur 0)))
        ((= score-p2 3) (let recur ((x 0))
                          (winner-display 'player2)
                          (if (input:key-pressed? 27)
                              (exit 0))
                          (recur 0))))
                                        ;EXIT
       (if (input:key-pressed? 27)
           (exit 0))
                 
       ;;Main loop
       (loop  
        ;;Player One box movement
        (cond 
         ((input:key-pressed? 119) (if (< (- box-1-pos-y 10) min-pos-y) min-pos-y
                                       (- box-1-pos-y 0.5)))
         ((input:key-pressed? 115) (if (> (+ box-1-pos-y 10) max-pos-y) max-pos-y
                                       (+ box-1-pos-y 0.5)))
         (else
          box-1-pos-y))
                                        ;Player Two box movement 
        (cond 
         ((input:key-pressed? 273) (if (< (- box-2-pos-y 10) min-pos-y) min-pos-y
                                       (- box-2-pos-y 0.5)))
         ((input:key-pressed? 274) (if (> (+ box-2-pos-y 10) max-pos-y) max-pos-y
                                       (+ box-2-pos-y 0.5)))
         (else
          box-2-pos-y))
                                        ;Ball, circle, movement -X
        (cond
         ((>= (+ c-pos-x c-size) (+ box-2-pos-x box-size-x)) init-c-pos-x)
         ((<= (- c-pos-x c-size) (- box-1-pos-x box-size-x)) init-c-pos-x)
         (else
          (+ c-pos-x c-dir-x)))
                                        ;Ball, circle, movement -Y
        (+ c-pos-y c-dir-y)
                                        ;Ball "y" direction
        (cond
         ((>= (+ c-pos-y c-size) maxy) -0.1)
         ((<= (- c-pos-y c-size) 0) 0.1)
         (else
          c-dir-y))
        ;; Ball "x" direction
        (cond
         ((and (>= (+ c-pos-x c-size) (- box-2-pos-x box-size-x))
               (>= c-pos-y (- box-2-pos-y (* box-size-y 0.5)))
               (<= c-pos-y (+ box-2-pos-y (* box-size-y 0.5))))
          -0.1)
         ((and (<= (- c-pos-x c-size) (+ box-1-pos-x box-size-x))
               (>= c-pos-y (- box-1-pos-y (* box-size-y 0.5)))
               (<= c-pos-y (+ box-1-pos-y (* box-size-y 0.5))))
          0.1)
         (else
          c-dir-x))
        ;;Scores
        ;;P1
        (if (>= (+ c-pos-x c-size) (+ box-2-pos-x box-size-x)) (+ score-p1 1)
            score-p1)
        ;;P2
        (if (<= (- c-pos-x c-size) (- box-1-pos-x box-size-x)) (+ score-p2 1)
            score-p2))))))
