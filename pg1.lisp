(defun my-sq-printer(start end)
  (do ((i start (+ i 1)))
      ((> i end) 'DONEDONADONE) 
       (format t "~A ~A ~%" i (* i i))))


      