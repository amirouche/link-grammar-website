#! /bin/sh
# -*- scheme -*-
exec guile -L $(dirname $(dirname $0)) -e '(markdown)' -s $0 "$@"
!#
(define-module (markdown))

(use-modules (commonmark))

;;;
;;; sxml->html taken from Haunt
;;;
;;; Haunt --- Static site generator for GNU Guile
;;; Copyright Â© 2015 David Thompson <davet@gnu.org>
;;;
;;; This file is part of Haunt.
;;;
;;; Haunt is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; Haunt is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Haunt.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; SXML to HTML conversion.
;;
;;; Code:

(use-modules (ice-9 rdelim))
(use-modules (sxml simple))
(use-modules (srfi srfi-26))
(use-modules (ice-9 match))
(use-modules (ice-9 format))
(use-modules (ice-9 hash-table))


(define %void-elements
  '(area
    base
    br
    col
    command
    embed
    hr
    img
    input
    keygen
    link
    meta
    param
    source
    track
    wbr))

(define (void-element? tag)
  "Return #t if TAG is a void element."
  (pair? (memq tag %void-elements)))

(define %escape-chars
  (alist->hash-table
   '((#\" . "quot")
     (#\& . "amp")
     (#\' . "apos")
     (#\< . "lt")
     (#\> . "gt"))))

(define (string->escaped-html s port)
  "Write the HTML escaped form of S to PORT."
  (define (escape c)
    (let ((escaped (hash-ref %escape-chars c)))
      (if escaped
          (format port "&~a;" escaped)
          (display c port))))
  (string-for-each escape s))

(define (object->escaped-html obj port)
  "Write the HTML escaped form of OBJ to PORT."
  (string->escaped-html
   (call-with-output-string (cut display obj <>))
   port))

(define (attribute-value->html value port)
  "Write the HTML escaped form of VALUE to PORT."
  (if (string? value)
      (string->escaped-html value port)
      (object->escaped-html value port)))

(define (attribute->html attr value port)
  "Write ATTR and VALUE to PORT."
  (format port "~a=\"" attr)
  (attribute-value->html value port)
  (display #\" port))

(define (element->html tag attrs body port)
  "Write the HTML TAG to PORT, where TAG has the attributes in the
list ATTRS and the child nodes in BODY."
  (format port "<~a" tag)
  (for-each (match-lambda
             ((attr value)
              (display #\space port)
              (attribute->html attr value port)))
            attrs)
  (if (and (null? body) (void-element? tag))
      (display " />" port)
      (begin
        (display #\> port)
        (for-each (cut sxml->html <> port) body)
        (format port "</~a>" tag))))

(define (doctype->html doctype port)
  (format port "<!DOCTYPE ~a>" doctype))

(define* (sxml->html tree #:optional (port (current-output-port)))
  "Write the serialized HTML form of TREE to PORT."
  (match tree
    (() *unspecified*)
    (('doctype type)
     (doctype->html type port))
    (((? symbol? tag) ('@ attrs ...) body ...)
     (element->html tag attrs body port))
    (((? symbol? tag) body ...)
     (element->html tag '() body port))
    ((nodes ...)
     (for-each (cut sxml->html <> port) nodes))
    ((? string? text)
     (string->escaped-html text port))
    ;; Render arbitrary Scheme objects, too.
    (obj (object->escaped-html obj port))))


;;;
;;; main: markdown to html
;;;

(define-public (main args)
  (sxml->html `(html
                (head
                 (meta (@ (charset "utf-8")))
                 (title "Link Grammar")
                 (link (@ (rel "stylesheet")
                          (href "static/normalize.css")))
                 (link (@ (rel "stylesheet")
                          (href "https://fonts.googleapis.com/css?family=Muli|Ovo")))
                 (link (@ (rel "stylesheet")
                          (href "static/main.css"))))
                (body
                 (div (@ (id "overlay")))
                 (div (@ (id "container"))
                      (div (@ (id "main"))
                           (div (@ (id "header"))
                                (h1 (a (@ (href "/")) "Grammar Link")))
                           (ul (@ (id "navigation"))
                               (li (a (@ (href "documentation.html")) "Documentation"))
                               (li (a (@ (href "changelog.html")) "ChangeLog"))
                               (li (a (@ (href "http://www.abisource.com/downloads/link-grammar/")) "Download"))
                               (li (a (@ (href "https://github.com/opencog/link-grammar")) "Forge"))
                               (li (a (@ (href "http://groups.google.com/group/link-grammar?hl=en")) "Help")))
                                                              
                           (div (@ (id "content"))
                                ,(commonmark->sxml (read-string)))))))))
