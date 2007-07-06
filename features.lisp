;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; features.lisp --- Trivial Features!
;;;
;;; This software is placed in the public domain by Luis Oliveira
;;; <loliveira@common-lisp.net> and is provided with absolutely no
;;; warranty.

(in-package #:trivial-features)

(defun featurep (feature-expression)
  (etypecase feature-expression
    (symbol (not (null (member feature-expression *features*))))
    (cons
     (ecase (first feature-expression)
       (:and (every #'featurep (rest feature-expression)))
       (:or  (some #'featurep (rest feature-expression)))
       (:not (not (featurep (cadr feature-expression))))))))

(defcfun ("uname" %uname) :int
  (buf :pointer))

;;; Get system identification.
(defun uname ()
  (with-foreign-object (buf 'utsname)
    (when (= (%uname buf) -1)
      (error "uname() returned -1"))
    (macrolet ((utsname-slot (name)
                 `(foreign-string-to-lisp
                   (foreign-slot-pointer buf 'utsname ',name))))
      (values (utsname-slot sysname)
              ;; (utsname-slot nodename)
              ;; (utsname-slot release)
              ;; (utsname-slot version)
              (utsname-slot machine)))))

(let ((upcasep (string= (symbol-name '#:foo) "FOO")))
  (defun canonicalize-symbol-name-case (name)
    (if upcasep
        (string-upcase name)
        (string-downcase name))))

;;; Lets keywordify "on demand" to avoid interning lots of symbols
;;; into the keyword package.
(defun kw (thing)
  (intern (etypecase thing
            (string (canonicalize-symbol-name-case thing))
            (symbol (symbol-name thing)))
          '#:keyword))

;;;; Operating System

;;; on darwin we could use the stuff described in arch(3)

(multiple-value-bind (sysname machine) (uname)
  (pushnew (kw sysname) *features*)
  ;; more stuff here
  )

;;;; Endianness

(pushnew (with-foreign-object (p :uint16)
           (setf (mem-ref p :uint16) #x00ff)
           (ecase (mem-ref p :uint8)
             (0 (kw '#:big-endian))
             (#xff (kw '#:little-endian))))
         *features*)
