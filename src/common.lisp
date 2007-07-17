;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; common.lisp --- trival-features, shared bits.
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

(defpackage #:trivial-features
  (:use #:common-lisp)
  (:export #:featurep))

(in-package #:trivial-features)

(defun featurep (feature-expression)
  "Returns T if the argument matches the state of the *FEATURES*
list and NIL if it does not. FEATURE-EXPRESSION can be any atom
or list acceptable to the reader macros #+ and #-."
  (etypecase feature-expression
    (symbol (not (null (member feature-expression *features*))))
    (cons
     (ecase (first feature-expression)
       (:and (every #'featurep (rest feature-expression)))
       (:or  (some #'featurep (rest feature-expression)))
       (:not (not (featurep (cadr feature-expression))))))))

#-sbcl
(let ((upcasep (string= (symbol-name '#:foo) "FOO")))
  (defun canonicalize-symbol-name-case (name)
    (if upcasep
        (string-upcase name)
        (string-downcase name))))

;;; avoiding annoying compiler notes
#+sbcl
(defun canonicalize-symbol-name-case (name)
  (string-upcase name))

;;; Lets keywordify "on demand" to avoid interning lots of symbols
;;; into the keyword package.
(defun keywordify (thing)
  (intern (etypecase thing
            (string (canonicalize-symbol-name-case thing))
            (symbol (symbol-name thing)))
          '#:keyword))

(defun push-feature (thing)
  (pushnew (keywordify thing) *features*))

;;; Like FEATUREP but doesn't require interning symbols.
(defun clean-featurep (feature-expression)
  (etypecase feature-expression
    (symbol
     (not (null
           (member (symbol-name feature-expression) *features*
                   :test (lambda (string symbol)
                           (and (keywordp symbol)
                                (string= string (symbol-name symbol))))))))
    (cons
     (ecase (first feature-expression)
       (:and (every #'clean-featurep (rest feature-expression)))
       (:or  (some #'clean-featurep (rest feature-expression)))
       (:not (not (clean-featurep (cadr feature-expression))))))))

(defun push-feature-if (expression thing)
  (when (clean-featurep expression)
    (push-feature thing)))
