;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; tests.lisp --- trivial-features tests.
;;;
;;; This software is placed in the public domain by Luis Oliveira
;;; <loliveira@common-lisp.net> and is provided with absolutely no
;;; warranty.

(defpackage #:trivial-features-tests
  (:use #:common-lisp #:trivial-features #:regression-test))

(in-package #:trivial-features-tests)

(deftest endianness.1
    (featurep '(:and :little-endian :big-endian))
  nil)

(deftest endianness.2
    (featurep '(:or :little-endian :big-endian))
  t)
