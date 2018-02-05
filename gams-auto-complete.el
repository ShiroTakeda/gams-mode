;;; gams-auto-complete.el --- A GAMS extention for auto-complete-mode

;; Author: Shiro Takeda
;; Maintainer: Shiro Takeda
;; Copyright (C) 2018 Shiro Takeda
;; First Created: Tue Jan 23, 2018 
;; Time-stamp: <2018-02-02 12:36:24 st>
;; Version: 0.9
;; Keywords: GAMS, auto-complete
;; URL: http://shirotakeda.org/en/gams/gams-mode/
;; This file is not part of any Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; A copy of the GNU General Public License can be obtained from this
;; program's author or from the Free Software Foundation,
;; Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Requirements:

;; To use auto-complete mode in GAMS mode, you need auto-complete.el.
;;
;; https://github.com/auto-complete/auto-complete
;;
;; You can install auto-complete.el from MELPA.
;;

;;; Commentary:

;; Put this file into your load-path and add the following into your init.el
;; file.
;;
;;   (require 'gams-auto-complete)
;;   (gams-ac-after-init-setup)
;;

;; If you want to add more keywords, for example, "computable", "general",
;; "equilibrium", Add the following into your init.el.
;;
;;  (setq gams-ac-source-user-keywords
;;         '("computable" "general" "equilibrium"))
;;

;;; Code:

(eval-when-compile (require 'cl))

(require 'auto-complete)
(require 'gams-mode)

(defvar gams-ac-source-user-keywords-list nil
  "A list of user keywords.")

(defvar gams-ac-sources
  '(
    gams-ac-source-user-keywords
    gams-ac-source-basic-commands
    gams-ac-source-dollar-control
    ))

(defun gams-ac-setup ()
  (setq ac-sources (append gams-ac-sources ac-sources)))

(defun gams-ac-after-init-setup ()
  (add-to-list 'ac-modes 'gams-mode)
  (add-hook 'gams-mode-hook 'gams-ac-setup)
  )

;; keywords
(defmacro gams-ac-define-dictionary-source (name list)
  `(defconst ,name
     '((candidates . (lambda () (all-completions ac-prefix ,list)))
       )))

(defsubst gams-ac-attach-$ (list)
  (mapcar #'(lambda (x) (concat "$" x)) list))

;; user keywords (command, option or varoable)
(gams-ac-define-dictionary-source
 gams-ac-source-user-keywords
 gams-ac-source-user-keywords-list)

;; standard GAMS commands created from gams-statement-alist.
(gams-ac-define-dictionary-source
 gams-ac-source-basic-commands
 (gams-alist-to-list gams-statement-alist))

;; dollar control commands created from gams-dollar-control-alist.
(gams-ac-define-dictionary-source
 gams-ac-source-dollar-control
 (gams-ac-attach-$
  (gams-alist-to-list gams-dollar-control-alist)))

(provide 'gams-auto-complete)


;;; gams-auto-complete.el ends here.

;; Local Variables:
;; coding: utf-8
;; End:


