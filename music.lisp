(defvar *musicdb* nil)
(defun make-cd(title artist year rating)
  (list :title title :artist artist :year year :rating rating))
(defun add-record-to-musicdb (cd) (push cd *musicdb*) )
(defun dump-music-db()
  (dolist (cd *musicdb*) 
    (format t "~{~a:~10t~a~%~}~%" cd)))
(defun prompt-read (prompt)
  (format *query-io* "~a:" prompt)
  (force-output *query-io*)
  (read-line *query-io*))
(defun prompt-for-cd ()
  (make-cd 
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Year") :junk-allowed t) 1900)
   (parse-integer (prompt-read "Rating"))
   ))
(defun add-cds ()
  (loop (add-record-to-musicdb (prompt-for-cd))
        (if (not (y-or-n-p "Wanna Add another? : ")) (return) )))
(defun save-db (filename db )
  (with-open-file (out filename 
                   :direction :output
                   :if-exists :supersede)
    (with-standard-io-syntax 
      (print db out))))
                
(defun load-musicdb (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *musicdb* (read in)))))


(defun select (selector-fn)
  (remove-if-not selector-fn *musicdb*))


(defun where (&key title artist year rating)
  #'(lambda (cd)
     (and
      (if title (equal (getf cd :title) title) t)
      (if artist (equal (getf cd :artist) artist) t)
      (if year (equal (getf cd :year) year) t)
      (if rating (equal (getf cd :rating) rating) t))))
	  