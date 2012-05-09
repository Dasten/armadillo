;;Acceleration
(define (acceleration angle)
  (sin angle))

;;Speed
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


;;Movement
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