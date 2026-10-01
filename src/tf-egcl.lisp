;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; tf-egcl.lisp --- EGCL trivial-features implementation.
;;;
;;; Copyright (C) 2026, Anthony Green  <green@moxielogic.com>
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without
;;; restriction, including without limitation the rights to use, copy,
;;; modify, merge, publish, distribute, sublicense, and/or sell copies
;;; of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.

(in-package :cl-user)

;;;; This file is deliberately empty of feature pushes.
;;;;
;;;; Unlike every other backend here, EGCL computes the canonical features in
;;;; its runtime at build time and has them in *features* before any Lisp code
;;;; loads -- operating system, architecture, byte order and word size. On
;;;; x86-64 Linux that is:
;;;;
;;;;   :UNIX :LINUX :X86-64 :LITTLE-ENDIAN :64-BIT
;;;;
;;;; so there is nothing for this file to add, and re-pushing them here would
;;;; duplicate per-target knowledge that belongs to the implementation.
;;;;
;;;; The component is kept in the ASDF load plan on purpose rather than being
;;;; omitted: it records that EGCL was considered, and it is where any feature
;;;; a future EGCL target fails to supply would be filled in. If EGCL is ported
;;;; to a platform whose canonical features it does not yet push (:BSD, say),
;;;; this is the file to fix.
