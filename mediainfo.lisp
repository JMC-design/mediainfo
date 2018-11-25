(defpackage :media
  (:use :cl :sb-ext :cl-csv)
  (:export #:info
	   #:resolution
	   #:get-rez))
(in-package :media)

(defparameter *output-format* "json")

;; this should return an a-list or keyword list
(defun info (video &optional (options "--Full"))
  "Returns the whole shebang from mediainfo"
  (let ((stream (make-string-output-stream)))
    (sb-ext:run-program "/usr/bin/mediainfo" (list options video) :output stream)
    (get-output-stream-string stream)))

;;this should sift through the data for whatever keyword and return the value
(defun get-value-of (keyword))

;;temp function

(defun get-height (video)
  (info video "--Inform=\"Video;\%Height\%\""))
(defun get-width (video)
  (info video "--inform=\"Video;\%Width\%\""))

(defun heightp(s) (if (string-equal "Height" (car s))t nil))
(defun widthp(s) (if (string-equal "Width" (car s))t nil))

(defun get-rez (video)
  "Returns a cons of (Width . Height)"
  (let* ((info (cl-csv:read-csv (info video) :separator #\:))
	 (height (read-from-string (car (cdr (car (remove-if-not #'heightp info) )))))
	   (width (read-from-string (cadar (remove-if-not #'widthp info) ))))
	(cons width height)))
