;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; tf-clisp.lisp --- CLISP trivial-features implementation.
;;;
;;; Copyright (C) 2007, Luis Oliveira  <loliveira@common-lisp.net>
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

(in-package #:trivial-features)

;;; FIXME, TODO: look into FASL portability issues.

;;;; Endianness

(push-feature
 (ffi:with-foreign-object (ptr '(ffi:c-array ffi:uint8 2))
   (setf (ffi:memory-as ptr 'ffi:uint16 0) #xfeff)
   (ecase (ffi:memory-as ptr 'ffi:uint8 0)
     (#xfe '#:big-endian)
     (#xff '#:little-endian))))

;;;; OS

;;; CLISP already exports:
;;;
;;;   :UNIX

(push-feature
 (if (clean-featurep '#:win32)
     '#:windows
     ;; Push :DARWIN, :LINUX, :FREEBSD, etc.  Ridiculous contortionism
     ;; just to avoid interning a keyword!
     (funcall (find-symbol (string '#:uname-sysname) '#:posix)
              (funcall (find-symbol (string '#:uname) '#:posix)))))

;;; Pushing :BSD.  (Make sure this list is complete.)
(push-feature-if '(:or #:darwin #:freebsd #:netbsd #:openbsd) '#:bsd)

;;;; CPU

;;; FIXME: not complete
(push-feature
 (cond
   ((string= (machine-type) "X86_64") '#:x86-64)
   ((clean-featurep '#:pc386) '#:x86)
   ((string= (machine-type) "POWER MACINTOSH") '#:ppc)))
