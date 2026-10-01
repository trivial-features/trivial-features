;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; tf-egcl.lisp --- EGCL trivial-features implementation.
;;;
;;; Intentionally empty: the EGCL runtime computes all relevant features
;;; itself and has them in *features* before any Lisp code loads: OS
;;; (:UNIX + :LINUX), CPU (:X86-64), endianness (:BIG-ENDIAN or
;;; :LITTLE-ENDIAN), and word size (:32-BIT or :64-BIT).  There is
;;; nothing to normalize here.
