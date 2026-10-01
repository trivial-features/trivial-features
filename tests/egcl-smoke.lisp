;;;; Run from any directory with egcl --no-init --load or sbcl --script.
(require :asdf)
(asdf:load-asd (merge-pathnames "../trivial-features.asd" *load-truename*))
(asdf:load-system :trivial-features)
(dolist (alternatives '((:little-endian :big-endian) (:32-bit :64-bit)))
  (assert (= 1 (count-if (lambda (feature) (member feature *features*))
                         alternatives))))
#+linux (assert (member :unix *features*))
(format t "FEATURES-PORT-OK~%")
