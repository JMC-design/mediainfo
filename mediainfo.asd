(in-package :asdf-user)
(defsystem "media"
  :depends-on ("cl-csv")
  :components ((:file "mediainfo")))
