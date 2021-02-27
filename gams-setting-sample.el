;;  This is a setting sample file for gams-mode.el
;;
;;  First-written:	<2001/08/13>
;;
;;  This file is created for gams-mode.el version 6.7.
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
;; If you install GAMS mode from MELPA, the following settings are not
;; necessary. But if you install GAMS mode manually, you need to do the
;; following configuration.

;;;; Load path setting.
;;
;; Suppose that c:/home/gams is a directory in which gams-mode.el is installed.
;; Then you should add the following.
;;
(add-to-list 'load-path "c:/home/gams")
;; Please change the directory name according to your environment.

;; Then, use (require 'gams-mode) to load GAMS mode. But it is better to put
;; this command at the end of the configuration file.
;;
;; (require 'gams-mode)

;;;; The place of GAMS program.
;;
;; If you do not include GAMS system directory in your PATH environmental
;; variable, specify the place of gams program like
;;
;; (setq gams-process-command-name "c:/GAMS/win64/24.6/gams.exe")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 Important settings.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The following settings are not necessarily required, but they change the
;; important behavior of GAMS mode.

;; By default, GAMS mode will automatically start only when you open a file with
;; an extension `gms'. If you want to add files with another extensions (for
;; example, `dat'), you need to set the following.
;; NB: This setting must be placed before (require 'gams) command below.
;;
;; (setq gams-file-extension '("gms" "dat"))

;;;; Log file.
;;
;; If non-nil, GAMS log (the content of process buffer) is written down to log
;; file even without lo=2 option.
;; (setq gams-process-log-to-file t)
;; The extension of GAMS log file
;; (setq gams-log-file-extension "glg")

;;;; Template file name for GAMS-TEMPLATE.
;;
;; A sample template file "gams-template.txt" is distributed with this file.  If
;; you want to try a sample file, you must save it in ".emacs.d" directory.  Or
;; you should specify the explicit name of your template file name like
;;
;; (setq gams-template-file "~/.emacs.d/gams-template.txt")

;;;; Command line options passed to gams.  The default value is
;; (setq gams-process-command-option "ll=0 lo=3 pw=100 ps=9999")
;;
;; Notice: If you are an Emacs user on MS windows, you should include lo=3 option!!!

;;;; GAMS system directory.
;;
;; The directory where gams.exe exists.  This is
;; necessary for `gams-model-library' and `gams-view-doccument' command.
;; (setq gams-system-directory "c:/GAMS/34")

;;;; Use upper case or lower case for GAMS statements and dollar control options?
;;
;; (setq gams-statement-upcase t) ; Use upper case for GAMS statements
;; (setq gams-dollar-control-upcase t) ; Use upper case for dollar operations.

;;;; Initial values of statement and dollar control.
(setq gams-statement-name "parameter")
(setq gams-dollar-control-name "exit")

;;;; The window height in the GAMS-OUTLINE mode.
;;
;; This is the window height when two windows exist.
(setq gams-ol-height 16)
;;
;; This is the window height when three windows exist.
(setq gams-ol-height-two 10)
;;
;; This is the window width of the GAMS-OUTLINE buffer.
(setq gams-ol-width 40)
;;
;; The default display style in the GAMS-OUTLINE mode.
;; (setq gams-ol-display-style '(t t))

;;;; The default viewable items in the GAMS-OUTLINE mode.
(setq gams-ol-view-item
      '(
	("SUM" . t)             ; SUMMARY
	("VAR" . t)             ; VAR
	("EQU" . t)		; EQU
	("PAR" . t)		; PARAMETER
	("SET" . t)		; SET
        ("VRI" . t)		; VARIABLE.  Not viewable by default.
	("LOO" . t)		; LOOP
	("OTH" . t)		; Other strings
	("COM" . t)		; COMMENT
	("INF" . t)		; Execution, Compilation etc.
	))

;;;; The default alist of viewable items.
;;
;; Each list consists of a pair of the item name and its flag
;;
;; ("ITEM_NAME" . flag)
;;
;; Non-nil (t) of the flag means the item is viewable by default.  The order of
;; items in this alist has the meaning.  Items are listed in the SELECT-ITEM
;; buffer according to this order.  So, if you want to show COM on the top in
;; the SELECT-ITEM mode, you must write COM at the fisrt in this alist.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 Other customizations.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; If you want to try the default values, please uncomment all the settings
;; below.

;;;; My comment template.
(setq gams-user-comment
      "*	----------------------------------------------------------------------
*	%
")

;;; Close parenthesis and quotation?
;;
;; For example, if you want ) to be inserted automatically when you insert (,
;; then set t to `gams-close-paren-always'.
;;
;; (setq gams-close-paren-always nil)			; Not insert ) automatically.
;; (setq gams-close-paren-always t)			; Insert ) automatically (default)
;; (setq gams-close-double-quotation-always nil)	; No
;; (setq gams-close-single-quotation-always t)		; Yes

;;;; The default height of GAMS process buffer
;; (setq gams-default-pop-window-height 15) ; Default value is 10

;;;; Column number in GAMS mode.
;; (setq gams-fill-column 80)

;;;; Setting for viewing GAMS pdf documents.
;;
;; The GAMS document directory.
;; (setq gams-docs-directory (concat gams-system-directory "/docs"))
;; By default, it is set to `gams-system-directory' + docs."

;;;; Setting for GAMS-TEMPLATE mode.
;;
;; Without a special reason, you had better set nil to the following variable.
;; (setq gams-save-template-change t) ; default is nil

;;;; Setting for Automatic indentation.
;;
;; Use automatic indent or not?
;; (setq gams-indent-on nil) ; No automatic indent.
;; (setq gams-indent-on t) ; Use automatic indent (default)

;;;; Column number for automatic indentation.  All default values are 4.
;;
;; Column number for normal lines.
;; (setq gams-indent-number 4)
;;
;; Column number for lines in loop type enviroment (i.e, loop, if, while,
;; for etc.).
;; (setq gams-indent-number-loop 4)
;;
;; Column number for MPSGE block
;; (setq gams-indent-number-mpsge 4)
;;
;; Column number for equation definition.
;; (setq gams-indent-number-equation 4)

;;;; Indent equation blocks or not?
;;
;; For equation definition block
;; (setq gams-indent-equation-on t) ; Automatic indent (default)
;; (setq gams-indent-equation-on nil) ; No automatic indent

;;;; Use tabs for indent.
;;
;; Use only spaces for indent or allow tabs?
;; (setq indent-tabs-mode nil) ; Not use tabs for indent 
;; (setq indent-tabs-mode t) ; Use tabs (default) fot indent
;;
;; To convert all tabs in region to multiple spaces, use M-x untabify.

;;;; Change the indentation style.
;;
;; If the `gams-indent-more-indent' is assigned non-nil value, the indentation
;; style is changed slightly.
;; (setq gams-indent-more-indent t) ; nil is default.

;;;; Insert dollar control options.
;;
;; Use $ key for inserting dollar control options?
;;
;; t   => $ key is binded to `gams-insert-dollar-control'.
;; nil => $ key is binded to inserting $ itself
;;
;; (setq gams-insert-dollar-control-on nil) ; No (default)
;; (setq gams-insert-dollar-control-on t) ; Yes

;;;; Default inline and end-of-line comment symbols.
;;
;; (setq gams-inlinecom-symbol-start-default "/*") ; default
;; (setq gams-inlinecom-symbol-end-default "*/") ; default
;; (setq gams-eolcom-symbol-default "#") ; default

;;;; Popup the GAMS process buffer?
;;
;; When you run GAMS, the process buffer popups by default.
;;
;; (setq gams-always-popup-process-buffer t) ; Popup (default)
;; (setq gams-always-popup-process-buffer nil) ; Not popup.

;;;; Search identifier definition in included files?
;;
;; Setting for GAMS-LXI mode.
;; (setq gams-lxi-command-name "~/.emacs.d/lisp/gams-mode/gamslxi.exe")
;; (setq gams-lxi-import-command-name "~/.emacs.d/lisp/gams-mode/gamslxi-import.exe")

;;;; Hook settings.  For example,
;;
;; (add-hook 'gams-mode-hook
;; 	  '(lambda ()
;; 	     (let ((map gams-mode-map))
;; 	       ;; Bind indent-line to F2.
;; 	       (define-key map [f2] 'gams-indent-line)
;; 	       ;; Bind inserting TAB to TAB key.
;; 	       (define-key map "\t" 'gams-insert-tab)
;; 	       ;; Bind inserting GAMS statement to C-ca.
;; 	       (define-key gams-mode-map "\C-ca" 'gams-insert-statement))
;; 	       ))
;; (add-hook 'gams-lst-mode-hook
;; 	  '(lambda ()
;;	     ;; a = widen the window.
;; 	     (define-key gams-lst-mode-map "a" 'gams-lst-kill-buffer)
;; 	     ))
;; (add-hook 'gams-ol-mode-hook
;; 	  '(lambda ()
;; 	     (font-lock-mode t)
;; 	     (define-key gams-ol-mode-map "a" 'delete-other-windows)
;; 	     (define-key gams-ol-mode-map [down] 'gams-ol-view-next)
;; 	     (define-key gams-ol-mode-map [up] 'gams-ol-view-prev)
;; 	     ))

;; (add-hook
;;  'gams-sil-mode-hook
;;  '(lambda () (linum-mode -1)))
;;
;; (add-hook
;;  'gams-lxi-mode-hook
;;  '(lambda () (linum-mode -1)))


;;;; auto-complete mode for GAMS mode
;;
;; If you want to use auto-complete mode for GAMS mode (gams-ac.el), add the
;; following code:
;;
;; (require 'gams-ac)
;; (gams-ac-after-init-setup)
;;
;; Add the following words to candidates of auto-complete.
;; (setq gams-ac-source-user-keywords-list
;;      '("computable" "general" "equilibrium"))


;;;; Load the program file `gams-mode.el'.
;;
(require 'gams-mode)
;;
;; You had better put this at the end of all configurations about gams-mode.el.


; --------------------
; Local Variables:
; mode: emacs-lisp
; fill-column: 80
; End:
