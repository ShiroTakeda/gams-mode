;;  This is a setting sample file for gams.el
;;
;;  First-written:	<2001/08/13>
;;  Time-stamp:         <2016-02-06 18:02:27 st>
;;
;;  This file is created for gams.el version 4.0.
;;
;;  Copy and paste the content of this file into
;;  "~/.emacs.d/init.el" file.
;;
;;  You can see the detailed explanation of each variable with
;;  M-x describe-variable.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 Necessary settings.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The following settings are necessary to use GAMS mode.

;; Load path setting.  Suppose that c:/home/gams is a directory in which gams.el
;; is installed.  Then you should add the following.
(add-to-list 'load-path "c:/home/gams")
;; Please change the directory name according to your environment.

;; By default, GAMS mode will automatically start only when you open a file with
;; an extension `gms'. If you want to add files with another extensions (for
;; example, `dat'), you need to set the following.  NB: This setting must be
;; placed before (require 'gams) below.
(setq gams-file-extension '("gms" "dat"))

;; Load the program file `gams.el'.
(require 'gams)
;; NB: If you use this (require 'gams), you had better put this at the end of
;; all configurations about gams.el.  Because of the bug, the configurations
;; after (require 'gams) may not come into effect.

;; If you are an experienced user of Emacs, you may prefer the following
;; `auto-mode-alist' and `autoload' instead of (require 'gams).
;;
;; Add gms and lst files to auto-mode-alist.
; (setq auto-mode-alist
; 	(cons (cons "\\.\\(GMS\\|gms\\|DAT\\|dat\\)$" 'gams-mode) auto-mode-alist))
; (setq auto-mode-alist
; 	(cons (cons "\\.\\(LST\\|lst\\)$" 'gams-lst-mode) auto-mode-alist))
;; autoload setting.
; (autoload 'gams-mode "gams" "Enter GAMS mode" t)
; (autoload 'gams-lst-mode "gams" "Enter GAMS-LST mode" t)

;; The place of GAMS program.
;;
;; If you do not include GAMS system directory in your PATH environmental
;; variable, specify the place of gams program like

; (setq gams:process-command-name "c:/GAMS/GAMS23.5/gams.exe")


;; Setting for font-lock.
;;
;; The following code will make coloring function in GAMS
;; mode work better.
(setq font-lock-support-mode
      '((gams-mode . nil) (t . jit-lock-mode)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 Important settings.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The following settings are not necessarily required, but they decide the
;; important behavior of GAMS mode.

;; Log file. If non-nil, GAMS log (the content of process buffer) is written
;; down to log file even without lo=2 option.
; (setq gams-process-log-to-file t)
; The extension of GAMS log file
; (setq gams-log-file-extension "glg")

;; Template file name for GAMS-TEMPLATE.
;
; A sample template file "gams-template.txt" is distributed with this file.  If
; you want to try a sample file, you must save it in your HOME directory.  Or
; you should specify the explicit name of your template file name like
;
; (setq gams-template-file "~/gams-template.txt")

;; Command line options passed to gams.  The default value is
; (setq gams:process-command-option "ll=0 lo=3 pw=100 ps=9999")
;
; Notice: If you are a NTEmacs user, you should include lo=3 option!!!

;; GAMS system directory.  The directory where gams.exe exists.  This is
;; necessary for `gams-model-library' and `gams-view-doccument' command.
; (setq gams-system-directory "c:/GAMS/GAMS23.5/")

;; Use upper case or lower case for GAMS statements and dollar control options?
; (setq gams-statement-upcase t) ; Use upper case for GAMS statements
; (setq gams-dollar-control-upcase t) ; Use upper case for dollar operations.

;; Use MPSGE?
; (setq gams-use-mpsge t) ; Yes (default)
; (setq gams-use-mpsge nil) ; No

;; Allow multiple GAMS processes?
; (setq gams-multi-process nil) ; No
; (setq gams-multi-process t) ; Yes (default)

;; Initial values of statement and dollar control.
(setq gams-statement-name "parameter")
(setq gams-dollar-control-name "exit")

;; Re-coloring with recentering (C-l)?
; (setq gams-recenter-font-lock t) ; Yes (default)
; (setq gams-recenter-font-lock nil) ; No

;; The window height in the GAMS-OUTLINE mode.
;
; This is the window height when two windows exist.
(setq gams-ol-height 16)
;
; This is the window height when three windows exist.
(setq gams-ol-height-two 10)

; This is the window width of the GAMS-OUTLINE buffer.
(setq gams-ol-width 40)

; The default display style in the GAMS-OUTLINE mode.
; (setq gams-ol-display-style '(t t))

;; The default viewable items in the GAMS-OUTLINE mode.
(setq gams-ol-view-item
      '(
	("SUM" . t)			; SUMMARY
	("VAR" . t)			; VAR
	("EQU" . t)			; EQU
	("PAR" . t)			; PARAMETER
	("SET" . t)			; SET
        ("VRI" . t)			; VARIABLE.  Not viewable by default.
	("LOO" . t)			; LOOP
	("OTH" . t)			; Other strings
	("COM" . t)			; COMMENT
	("INF" . t)			; E x e c u t i o n, C o m p i l a t i o n etc.
	))

;; The default alist of viewable items.
;
; Each list consists of a pair of the item name and its flag
;
; ("ITEM_NAME" . flag)
;
; Non-nil (t) of the flag means the item is viewable by default.  The order of
; items in this alist has the meaning.  Items are listed in the SELECT-ITEM
; buffer according to this order.  So, if you want to show COM on the top in the
; SELECT-ITEM mode, you must write COM at the fisrt in this alist.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 Other customizations.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; If you want to try the default values, please uncomment all the settings
;; below.

;; My comment template.
(setq gams-user-comment
      "*	----------------------------------------------------------------------
*	%
")

;; Close parenthesis and quotation?
;
; For example, if you want ) to be inserted automatically when you insert (,
; then set t to `gams-close-paren-always'.
;
; (setq gams-close-paren-always nil)	; Not insert ) automatically.
; (setq gams-close-paren-always t)	; Insert ) automatically (default)
; (setq gams-close-double-quotation-always nil)	; No
; (setq gams-close-single-quotation-always t)	; Yes

;; The default height of GAMS process buffer
; (setq gams-default-pop-window-height 15) ; Default value is 10

;; Column number in GAMS mode.
; (setq gams-fill-column 80)

;; Setting for viewing GAMS pdf documents.
;
; The GAMS document directory. 
; (setq gams-docs-directory "?")
; By default, it is set to `gams-system-directory' + docs."
;
; The PDF file viewer.
; (setq gams-docs-view-program "c:/Program Files/Adobe/Acrobat 5.0/Reader/AcroRd32.exe")

;;; Setting for GAMS-TEMPLATE mode.
;
; Without a special reason, you had better set nil to the following variable.
; (setq gams-save-template-change t) ; default is nil

; Colorize the *Template Content* buffer in GAMS-TEMPLATE.  nil makes
; GAMS-TEMPLATE mode faster.
;
; (setq gams-template-cont-color t) ; Color (default)
; (setq gams-template-cont-color nil) ; No color

;;; Setting for Automatic indentation.
;
; Use automatic indent or not?
; (setq gams-indent-on nil) ; No automatic indent.
; (setq gams-indent-on t) ; Use automatic indent (default)

;; Column number for automatic indentation.  All default values are 4.
;
; Column number for normal lines.
; (setq gams-indent-number 4)
;
; Column number for lines in loop type enviroment (i.e, loop, if, while,
; for etc.).
; (setq gams-indent-number-loop 4)
;
; Column number for MPSGE block
; (setq gams-indent-number-mpsge 4)
;
; Column number for equation definition.
; (setq gams-indent-number-equation 4)

;; Indent equation blocks or not?
;
; For equation definition block
; (setq gams-indent-equation-on t) ; Automatic indent (default)
; (setq gams-indent-equation-on nil) ; No automatic indent

;; Use tabs for indent.
;
; Use only spaces for indent or allow tabs?
; (setq indent-tabs-mode nil) ; Not use tabs for indent 
; (setq indent-tabs-mode t) ; Use tabs (default) fot indent
;
; To convert all tabs in region to multiple spaces, use M-x untabify.

;; Change the indentation style.
;
; If the `gams-indent-more-indent' is assigned non-nil value, the indentation
; style is changed slightly.
; (setq gams-indent-more-indent t) ; nil is default.

;; Insert dollar control options.
;
; Use $ key for inserting dollar control options?
;
; t   => $ key is binded to `gams-insert-dollar-control'.
; nil => $ key is binded to inserting $ itself
;
; (setq gams-insert-dollar-control-on nil) ; No (default)
; (setq gams-insert-dollar-control-on t) ; Yes

;; The default font-lock (coloring) level.
;
; 0 = No coloring
; 1 = Minumun coloring
; 2 = Maximum coloring
;
; All default values are 2.
;
; (setq gams-font-lock-level 1)		; GAMS mode
; (setq gams-lst-font-lock-level 1)	; GAMS-LST mode
; (setq gams-ol-font-lock-level 1)	; GAMS-OUTLINE mode.

;; Default inline and end-of-line comment symbols.
;
; (setq gams-inlinecom-symbol-start-default "/*") ; default
; (setq gams-inlinecom-symbol-end-default "*/") ; default
; (setq gams-eolcom-symbol-default "#") ; default

;; Popup the GAMS process buffer?
;
; When you run GAMS, the process buffer popups by default.
;
; (setq gams-always-popup-process-buffer t) ; Popup (default)
; (setq gams-always-popup-process-buffer nil) ; Not popup.

;; Search identifier definition in included files?
;
;;; Setting for GAMS-LXI mode.
;
; (setq gams-lxi-command-name "c:/home/lisp/gamslxi.exe")
; (setq gams-lxi-import-command-name "c:/home/lisp/gamslxi-import.exe")


;; Hook settings.  For example,
;
; (add-hook 'gams-mode-hook
; 	  '(lambda ()
; 	     (let ((map gams-mode-map))
; 	       ;; Bind indent-line to F2.
; 	       (define-key map [f2] 'gams-indent-line)
; 	       ;; Bind inserting TAB to TAB key.
; 	       (define-key map "\t" 'gams-insert-tab)
; 	       ;; Bind inserting GAMS statement to C-ca.
; 	       (define-key gams-mode-map "\C-ca" 'gams-insert-statement))
; 	       ))
; (add-hook 'gams-lst-mode-hook
; 	  '(lambda ()
;	     ;; a = widen the window.
; 	     (define-key gams-lst-mode-map "a" 'gams-lst-kill-buffer)
; 	     ))
; (add-hook 'gams-ol-mode-hook
; 	  '(lambda ()
; 	     (font-lock-mode t)
; 	     (define-key gams-ol-mode-map "a" 'delete-other-windows)
; 	     (define-key gams-ol-mode-map [down] 'gams-ol-view-next)
; 	     (define-key gams-ol-mode-map [up] 'gams-ol-view-prev)
; 	     ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 Other configuration for Emacs.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	The configurations below change the behavior of Emacs in general.
;;

;;; Shell setting.

;; If you use cygwin bash.exe as the shell (and install it in "c:/cygwin/bin/")
;
; File name to load inferior shells from.
; (setq shell-file-name "c:/cygwin/bin/bash.exe")
; explicit-shell-file-name.
; (setq explicit-shell-file-name "c:/cygwin/bin/bash.exe")
; (modify-coding-system-alist 'process ".*sh//exe" 'undecided-unix)
; (setq shell-command-option "-c")
; Completion with shell-mode
; Get rid of ^M in shell mode.
; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.,:()-")

;; If you use cmdproxy.exe as the shell.  cmdproxy.exe is placed at the
;; same directory as runemacs.exe.
;
; (setq shell-file-name "c:/Emacs/bin/cmdproxy.exe")
; (setq explicit-shell-file-name "c:/Emacs/bin/cmdproxy.exe")
; (setq shell-command-option "/c")
; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.,:()-")
; (setq w32-quote-process-args t)
; (setq w32-start-process-show-window nil)


; --------------------
; Local Variables:
; mode: emacs-lisp
; fill-column: 80
; End:
