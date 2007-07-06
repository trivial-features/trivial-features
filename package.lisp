;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; package.lisp --- Package definition.
;;;
;;; This software is placed in the public domain by Luis Oliveira
;;; <loliveira@common-lisp.net> and is provided with absolutely no
;;; warranty.

(defpackage #:trivial-features
  (:use #:common-lisp #:cffi)
  (:nicknames #:tg)
  (:export #:featurep))
