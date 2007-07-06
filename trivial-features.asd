;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; trivial-features.asd --- ASDF system definition for trivial-features.
;;;
;;; This software is placed in the public domain by Luis Oliveira
;;; <loliveira@common-lisp.net> and is provided with absolutely no
;;; warranty.

(defpackage #:trivial-features-system
  (:use #:cl #:asdf))
(in-package #:trivial-features-system)

(eval-when (:load-toplevel :execute)
  (asdf:oos 'asdf:load-op '#:cffi-grovel))

(defsystem trivial-features
  :description "describe here"
  :author "Luis Oliveira <loliveira@common-lisp.net>"
  :version "0.0"
  :licence "Public Domain"
  :serial t
  :components
  ((:file "package")
   (cffi-grovel:grovel-file "utsname")
   (:file "features")))

(defmethod perform ((op test-op) (sys (eql (find-system :trivial-features))))
  (operate 'load-op :trivial-features-tests)
  (operate 'test-op :trivial-features-tests))

(defsystem trivial-features-tests
  :description "Unit tests for TRIVIAL-FEATURES."
  :depends-on (trivial-features rt)
  :components ((:file "tests")))

(defmethod perform ((op test-op)
                    (sys (eql (find-system :trivial-features-tests))))
  (funcall (find-symbol (symbol-name '#:do-tests) '#:regression-test)))

;; vim: ft=lisp et
