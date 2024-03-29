;;Acceleration
(define (acceleration angle)
  (sin angle))

;;SpeedX
(define (speed current-speed max-speed min-speed plain-speed pendant angle) 
  (cond ((equal? pendant 'plain)
         (cond ((= current-speed plain-speed)
                current-speed)                  
               ((< current-speed plain-speed)
                (+ current-speed (acceleration angle)))
               ((> current-speed plain-speed)
                (- current-speed (acceleration angle)))
               (else 
                (error "Current-speed comparation error"))))
        ((equal? pendant 'up)         
         (if (= current-speed min-speed)
             current-speed
             (- current-speed (acceleration angle))))
        ((equal? pendant 'down)
         (if (= current-speed max-speed)
             current-speed                       
             (+ current-speed (acceleration angle))))
        (else
         (error "No identificable pendant"))))


;;MovementX
(define (horizontal-move current-speed initial-speed current-pos min-x max-x)
  (cond ((= current-speed initial-speed)
         (cond ((= current-pos 0)
                current-pos)
               ((< 0 current-pos)
                (- current-pos current-speed))
               ((> 0 current-pos)
                (+ current-pos current-speed))
               (else 
                (error "Ball invalid position"))))
        ((< current-speed initial-speed)
         (if (<= current-pos min-x)
             min-x
             (- current-pos current-speed)))
        ((> current-speed initial-speed)
         (if (>= current-pos max-x)
             max-x
             (+ current-pos current-speed)))
        (else 
         (error "Invalid speed comparation"))))

;;Y MOVEMENT FUNCTION
(define (Y-movement b-state b-pos-y init-pos-y jump-v)
 (cond
  ((and (= b-pos-y init-pos-y)
        (eq? b-state 'fall)) init-pos-y)
  ((eq? b-state 'fall) (+ b-pos-y (expt jump-v 2)))
  ((eq? b-state 'jump) (- b-pos-y (* 0.5 (expt jump-v 4))))))

;;Y STATE FUNCTION
(define (Y-state b-state b-pos-y init-pos-y key)
 (cond
  ((and (= b-pos-y init-pos-y)
        (input:key-pressed? 32)) 'jump)
  ((<= b-pos-y  (- init-pos-y 100.0)) 'fall)
  (else
   b-state)))

;;Function for move obstacle
(define (move-obstacle speed frequency obstacle-high) 
  (draw:fill-color! (make-color/rgba 0.337 0.925 0.976 1))
  (draw:rectangle/corner-sides (modulo speed frequency) (- 540 obstacle-high) 20 obstacle-high))