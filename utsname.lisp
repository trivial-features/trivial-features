;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; utsname.lisp --- Grovel definitions for struct utsname.
;;;
;;; This software is placed in the public domain by Luis Oliveira
;;; <loliveira@common-lisp.net> and is provided with absolutely no
;;; warranty.

(in-package #:trivial-features)

(include "sys/utsname.h")

(cstruct utsname "struct utsname"
  (sysname  "sysname"  :type :char)
  (nodename "nodename" :type :char)
  (release  "release"  :type :char)
  (version  "version"  :type :char)
  (machine  "machine"  :type :char))
