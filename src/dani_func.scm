
;;Y MOVEMENT FUNCTION
(define (Y-movement b-state b-pos-y init-pos-y jump-v)
  (cond
   ((and (= b-pos-y init-c-pos-y)
         (eq? b-state 'fall)) init-pos-y)
   ((eq? b-state 'fall) (+ b-pos-y jump-v))
   ((eq? b-state 'jump) (- b-pos-y jump-v))))

;;Y STATE FUNCTION
(define (Y-state b-state b-pos-y init-pos-y key)
  (cond
   ((and (= b-pos-y init-pos-y)
         (input:key-pressed? 32)) 'jump)
   ((<= b-pos-y  (- init-c-pos-y 100.0)) 'fall)
   (else
    b-state)))