<!--
Author: Shiro Takeda
Maintainer: Shiro Takeda
-->

----------------------------------------------------

Change logs of GAMS mode.
====================================================

Version 7.1
----------------------------------

* Introduce `gams-install.el`, enabling GAMS installation directly from
  Emacs on Windows, macOS, and Linux, including asynchronous download of
  the latest release or a user-specified version.
* Add helper `gams-install-check-installation` and Linux-only
  customization of the installation directory.
* Provide accompanying platform scripts (`gams_install.sh`,
  `gams_install.ps1`).

Version 7.0
----------------------------------

* Enable jump to errors from process buffer using `compilation-minor-mode`
  and some regexp. This allows the use of standard Emacs keybindings to
  jump to errors from the `gms` file.

* `gams-file-extension` has been removed because it does not work well
   with deferred package loading and can prevent `poly-gams `from loading
   properly.

* All paths to executables and folders should be set automatically if GAMS
  is present in the PATH. If this is not the case, the only thing to set
  is the path to the `gams` executable.

* Adjustments in docstrings to follow more elisp conventions (still a lot to do).

* `major-mode` is now derived from prog-mode. This was supposed to be the
  case before, but all features of prog-mode were immediately killed.

* The GAMS process buffer is now turned to `view-mode` at the end of
  compilation, which prevents any modification and add special keybindings
  to move inside the buffer.

* Add a customizable variable `gams-company-backends`.

* Apply `gams-browse-url-function` everywhere where `browse-url` was used
  for consistent behavior.

* Add syntax highlighting for mathematical operators.

* Add function `gams-open-gdx` that opens in GAMS Studio the gdx file with the same name as the current gms file, if available, or ask for a gdx file name. Bound to `C-c C-x`.

* Add function `gams-clean-files-and-folders` that clean all GAMS-created files and folders.

Version 6.16
----------------------------------

* The font-locking and autocompletion features have been improved.

* `company-mode`, which is a text completion framework for Emacs, has been
  available in GAMS mode since version 6.13. If you want to use
  company-mode in GAMS mode, 1) install company-mode by yourself, and 2)
  add the following code to init.el

```emacs-lisp
(add-hook
  'gams-mode-hook
  #'(lambda () (company-mode))
  )
```

Version 6.15
----------------------------------

* In GAMS-SIL mode, $label command is now treated in the same way as
  $title command.



Version 6.14
----------------------------------

* Improved code for font locking. For this purpose, I have added the
  `gams-commands-dollar.txt` file, which contains a list of dollar control
  options. In addition, I changed the `gams-commands.txt` file to include
  only commands other than dollar control options.



Version 6.13
----------------------------------

* Added support for auto-completion through emacs standard
  completion-at-point-function, plus a selection of appropriate backends
  for company-mode. For this, I added `gams-commands.txt` file which
  includes the list of GAMS commands.



Version 6.12
----------------------------------

* Sligtly modified the behavior of `gams-fill-paragraph`.

* Added a command for opening online help for the gams model library.

* Bind `C-c C-;` to `gams-comment-or-uncomment-region`, which is an alias
  of `comment-or-uncomment-region` You can comment or uncomment a region
  with `C-c C-;`.

* Fixed the bug in systax highligting and automatic indentation.


Version 6.11
----------------------------------

* Modified `gams-view-lst` and `gams-jump-to-lst`. If you attch the
  universal-argument (C-u) to these commands, you can show the LST file
  buffer next to the GAMS buffer.

* Modified the function `gams-fill-paragraph` which is binded to "M-q" in
  GAMS mode.

* Slightly modified `gams-show-identifier`.


Version 6.10
----------------------------------

* Modified gams-mode.el so that it is compatible with smartparen-mode.

  If you want to use smartparen-mode within GAMS mode, add the following
  code in your init.el file

        (setq gams-close-paren-always nil)
        (setq gams-close-double-quotation-always nil)
        (setq gams-close-single-quotation-always nil)
        (add-hook 'gams-mode-hook #'smartparens-mode)

* Changed the default value of `gams-process-command-option` to
  "logOption=3 pageWidth=100".

* Changed the default value of `gams-system-directory` to "c:/GAMS/37/".

* Changed the default value of `gams-log-file-extension` to "log".

* Updated `gams-setting-sample.el` file.


Version 6.9
----------------------------------

* Fixed a bug in `GAMS-TEMPLATE` mode.

* Made gams-mode derived from prog-mode.



Version 6.8
----------------------------------

* To support `vertico-mode` (a new minibuffer completion feature in
  Emacs), `read-from-minibuffer` has been replaced with `completing-read`.

* Changed the default setting for faces (coloring).

* Changed `gams-mode.el` to suppress errors from byte-compiling.


Version 6.7
----------------------------------

* Updated explanation in `README.md` file.

* Updated example settings in `gams-setting-sample.el` file.

* Added a function for opening GAMS online manual for commandline options
  from "Change options" in "Process menu".

* Updated the function for using outline representation like Org mode. See
  `orglike-headline.gms` file in sample_gams_code folder for details.

* Modified `gams-view-document` function (C-cC-m). The current GAMS
  system offers manuals in html format (GAMS Documentation Center). The
  new version of GAMS mode enables you to open documents from GAMS mode.

  You can choose online documents or offline documents.  If you attach the
  universal argument C-uC-cC-m, then you can search a command under the
  cursor in the documentation center (this command search function is
  available only in the online manual).

  The directory of the local GAMS documents is determined by the variable
  `gams-docs-directory`.  By default, `gams-docs-directory` is set to
  `gams-system-directory' + docs.

  With this change, we abolished `gams-docs-view-program`,
  `gams-docs-view-old`, `gams-manuals-alist-base`.


Version 6.6
----------------------------------

* Added changes for psopt library.

* Fixed the bug in GAMS-LST mode caused by assigning 1 or 2 to GAMS
  command line option errmsg.


Version 6.5
----------------------------------

* Modified `gams-model-library` so that it works under the recent versions
  of GAMS.

* Added a new function `gams-modlib-toggle-show-content` to GAMS model
  library (GAMS-MODLIB) mode.  You can see the model library in
  GAMS-MODLIB mode.  In the previous gams-mode.el, GAMS-MODLIB mode shows
  the program code of models.  In the new gams-mode.el, you can see the
  explanatory text of models like GAMSIDE.  Added a customizable variable
  `gams-modlib-show-code-p-default` which changes the default behavior of
  `gams-modlib-show-content`.

* Modified explanatory strings.

* Modified `gams-insert-statement-extended`.

* Modified `gams-view-document` so that you can see documents in recent
  versions of GAMS system. Added new variables `gams-docs-url` and
  `gams-docs-view-old` and modified the default value of
  `gams-docs-view-program`.

* Changed GAMS mode icon for modeline.

* Removed `gams-auto-complete.el` from GAMS mode
  package. `gams-auto-complete.el` is renamed to `gams-ac.el` and released
  as a separate package in gams-ac repository.
  [https://github.com/ShiroTakeda/gams-ac/]


Version 6.4 (2018-03-22)
----------------------------------

* Added hook variables `gams-sil-mode-hook`, `gams-lxi-mode-hook`, and
  `gams-ol-mode-hook`.

* Added new list code `gams-auto-complete.el`. This enables you to use
  auto-complete mode in GAMS mode.

  If you want to use auto-complete mode in GAMS mode, you first need to
  install `auto-complete.el` which can be installed from MELPA.

  To use auto-complete in GAMS mode, add the following code to init.el.

        ;; Load gams-auto-complete.
        (require 'gams-auto-complete)
        ;; Initial setup for auto-complete in GAMS mode.
        (gams-ac-after-init-setup)

  If you want to add words for auto-complete mode by yourself, add words
  to the variable `gams-ac-source-user-keywords-list`. See
  "gams-setting-sample.el" for details.


* Changed gamslxi.exe.


Version 6.3 (2017-11-18)
----------------------------------

* Modified licence statement.

* Added executable files `gamslxi.exe` and `gamslxi-import.exe`.


Version 6.2.1 (2017-07-02)
----------------------------------

* Remove unnecessary variables and modified obolete functions.


Version 6.2 (2017-03-08)
----------------------------------

* Supported "singleton set".

* Changed the default value of gams-highlighted-keywords-in-comment to
  ("_TODO_" "_BUG_" "_FIXME_").

* Added a customizable variable `gams-sil-display-column-num`.  This
  variable determiens the column width for displaying identifer name in
  GAMS-SIL mode.

* Made changes to show names of parameters, variables and equations with
  index (set) in GAMS-SIL mode.


Version 6.1.1 (2016-09-23)
----------------------------------

* Added new variable `gams-highlighted-keywords-in-comment`.
  In this variable, you specify the list of keywords highlighted even in comment region.

  In comment region, all texts are colored by `gams-comment-face`.  But
  the words registered in this list are colored by
  `gams-highlighted-keywords-face` even in comment region.
  The default keywords are TODO, BUG, FIXME.


Version 6.1 (2016-03-17)
----------------------------------

* Modified GAMS-TEMPLATE mode.

* Modified the format of "gams-template.txt" (`gams-template-file`) which
  stores templates. The previous gams-template.txt is not compatible with
  the current GAMS-TEMPLATE mode. You need to recreate the new
  "gams-template.txt" or replace the old one with the new sample template
  file.

* Added `gams-temp-change-template-file` function.

* Fixed the bug in GAMS-MODEL library in gnupack Emacs.


Version 6.0 (2016-03-02)
----------------------------------

* Note: Important changes have been added to this version of GAMS
  mode. Read the explanation below carefully and change your
  configurations in init.el file.

* Changed the name of the main lisp code from "gams.el" to "gams-mode.el".

* The name of feature provided by gams-mode.el changed from gams to
  gams-mode. So you need to use (require 'gams-mode) instead of (require
  'gams).

* Changed the name of variables and functions whose prefix is "gams*" or
  "gams:". Now all variables and functions defined in gams-mode.el have
  prefix "gams-". As a result of this change, names of the following
  customizable variables changed.

        Old name                         New name
        `gams:process-command-name`   -> `gams-process-command-name`
        `gams:process-command-option` -> `gams-process-command-option`

  You need to modify init.el setting.

* Change the default value of variables `gams-statement-file` and
  `gams-template-file`.

        gams-statement-file -> "~/.emacs.d/gams-statement.txt"
        gams-template-file -> "~/.emacs.d/gams-template.txt"


Version 5.0 (2016-02-03)
----------------------------------

* Suppose that you have a code like

        $setglobal sub_program sub_program_default.gms

        $include %sub_program%

  With this code, GAMS reads the content of sub_program_default.gms
  file. But the items in sub_program_default.gms file is not displayed
  when you evoke `gams-show-identifier-list` (C-cC-a) because GAMS mode
  regards %sub_program% as a filename literally and cannot find it.

  In the new GAMS mode, you can list the items in sub_program_default.gms
  file by adding the following line.

        $setglobal sub_program sub_program_default.gms

        * gams-include-file: sub_program_default.gms
        $include %sub_program%

  The line `* gams-include-file: sub_program_default.gms` is a comment
  line and GAMS ignores it. But the GAMS mode interprets that

        $include sub_program_default.gms

  So the items in "sub_program_default.gms" are listed by
  `gams-show-identifier-list`.

  The specification by "gams-include-file" is used in the sample file
  "gams-sample.gms".

* Fixed the bug (wrong number of arguments) in
  `gams-insert-statement-extended`.

* Removed variable `gams-multi-process`.

* Changed the name of function `gams-view-docs` to `gams-view-document`.

* Changed the default value of `gams-sil-expand-file-more` to t.


Version 4.2 (2013-02-15)
----------------------------------

* Added the new variables `gams-outline-regexp-font-lock` and
  `gams-level-color-stars-only`.  With this chage, headlines are colored
  according to their level.


Version 4.1 (2012-10-13)
----------------------------------

* Fixed minor bugs.

* Changed the explanation in BUGS_PROBLEMS.txt and README.txt.  Until the
  previous version, I recommended to add the following setting to Emacs

        (setq jit-lock-chunk-size 50000)

  This is for making coloring in GAMS mode work well. But now I recommend
  the following setting:

        (setq font-lock-support-mode '((gams-mode . nil) (t . jit-lock-mode)))

  This means that font-lock-support-mode is not used in GAMS mode.  By
  this setting, Emacs is likely to slow down when you open GAMS files, but
  you will encounter less troubles in coloring of GAMS mode.

* Abolished the command `gams-outline-external` (and deleted files
  associated with this command).


Version 4.0 (2012-09-08)
----------------------------------

* Made several changes on GAMS-SIL mode.

  We often include the same file many times in a program. For example,
  supose that a GAMS program includes the following codes.

        $batinclude aggr vst i r vst_
        $batinclude aggr vtwr i j r s vtwr_
        $batinclude aggr vom g r vom_

  In this code, aggr.gms is included repeatedly. In the previous GAMS-SIL
  model, the content of aggr.gms is expanded repeatedly in GAMS-SIL
  buffer. But in the new gams.el, aggr.gms is expanded only once (only
  first time).

* Added a new new function `gams-sil-toggle-expand-file-more` and a lisp
  variable `gams-sil-expand-file-more` (the default value is nil).

  In GAMS-SIL mode, the contents of files included by $include commands
  are usually expanded. For example, if your program includes the
  following code:

        $include zzz.gms

  then, the content of zzz.gms above is always expanded in
  GAMS-SIL. However, if the file is included conditionally like

        $if exist xxx.gms $include xxx.gms
        $if %scenario%="bau" $include xxx.gms

  the content of xxx.gms is not expanded by default.

  If you want to expand the content of conditionally inluced files, type
  "x" in GAMS-SIL buffer. This evokes `gams-sil-toggle-expand-file-more`
  command.

  If you always want to expand the content of conditionally inluced files,
  then set non-nil to the lisp variable `gams-sil-expand-file-more`.


* Added the new lisp variable `gams-sil-expand-batinclude` (default value is t).

  In GAMS-SIL mode, the contents of files included by $include commands
  are always expanded. But files included by $batinclude are not expanded
  if `gams-sil-expand-batinclude` is nil.

* Changed the default value of `gams-special-comment-symbol` from "com:"
  to "@".  This is the string to specify the special comment like

        display "@ This is the special comment line";

  The special comment line is used for headlines in GAMS-SIL mode and
  GAMS-OUTLINE mode.

* Added outline representation like Org-mode (or outline mode). You can
  only show headlines of a GAMS program.

  By default, lines starting with `*@` are regarded as headlines.

        *@    The top level headline
        *@@   Second level
              text text
        *@@@  Third level
              text text
        *@    Another top level headline

  You can change outline representation by the following two commands:

  + `org-cycle` (binded to TAB key)
  + `org-global-cycle` (binded to Shift+TAB key).

  `org-cycle` command works only on headlines and toggles hide/show the
  body of programs. `org-global-cycle` toggles hide/show entire program.

  Open a sample file "org-minor-mode.gms" and try TAB and Shift+TAB.

  This feature uses codes in Org-mode. So if you want to use this feature,
  Org-mode must be installed (The recent Emacs has Org-mode by
  default). In addition, note that this command may depend on the version
  of Org-mode. I test in Org-mode of 7.8.11.

  [How to change symbols for headlines]

  In the default setting, "*@" is used as symbols to represent
  headlines. This is determined by the lisp variable
  `gams-outline-regexp`. This variable specifies the regular expressions
  of the symbol used to represent headlines and its default value is

        "\\*@+[ \t]"

  If you change the value of this variable, you can change symbols for
  headlines. For example, add the following expression to your init.el
  file

        (setq gams-outline-regexp "[ \t]*display \"@+[ \t]")

  And open "org-minor-mode-alt.gms".


  [Other commands for outline handling]

  + "C-cC-:n" -> Move to the next headlines (`outline-next-visible-heading`).
  + "C-cC-:p" -> Move to the previous headlines (`outline-previous-visible-heading`).
  + "C-cC-:f" -> Fold the current tree (`gams-org-fold-current-tree`).
  + "C-cC-:k" -> Show branches (`show-branches`).


* Changed the default indent number from 8 to 4.

* Changed the name of sample setting file from "dot-emacs-sample" to
  "setting-sample.el".



Version 3.6.6 (2012-06-02)
----------------------------------

* Quited supporting XEmacs because I have no environment for testing
  XEmacs.

* Increased the default value of `gams-lxi-maximum-line` (from 500000 to
  1000000).

* Fixed a bug in `gams-show-identifier`.

* Fixed many minor bugs.



Version 3.6.5 (2011-10-15)
----------------------------------

* The previous version (ver.3.6.4) includes a bug in indentation function
  for $macro block. It is fixed in this version.

* Fixed the bug related to $oneolcom and $offeolcom. In the previous
  versions, GAMS mode sometimes does not work well in files with $oneolcom
  and $offeolcom.

* Added minor changes on `gams-model-library`.


Version 3.6.4 (2011-10-05)
----------------------------------

* Added "nonnegative variables" to the GAMS statement list.

* Changed the key-binding of `gams-comment-dwim-inline` to `C-cM-;`.

* Added minor change on `gams-insert-statement-extended` (C-cC-n).

* Supported indentation for $macro definition.

* Various minor changes.


Version 3.6.3 (2011-06-19)
----------------------------------

* Fixed bugs in `gams-show-identifier` (C-cC-.).

* Fixed bugs in the indentation function.

* Minor changes.


Version 3.6.2 (2011-04-20)
----------------------------------

* Fixed bug in `gams-show-identifier` (C-cC-.).

* Many minor changes and bug fix.


Version 3.6.1 (2011-02-02)
----------------------------------

* Fixed bug in `gams-show-identifier` (C-cC-.).

* Added minor changes to GAMS-TEMPLATE mode and `gams-model-library`.

* Added items to the sample template file "gams-template.txt".


Version 3.6 (2011-01-14)
----------------------------------

* Added the completion listing for `gams-show-identifier` (C-uC-cC-.).

* Many minor changes and bug fix.


Version 3.5.2 (2010-11-06)
----------------------------------

* Bug fix for Beta version of GAMS.


Version 3.5.1 (2010-10-14)
----------------------------------

* Bug fix in `gams-align-block`.

* Bug fix for ALPHA version of GAMS.



Version 3.5 (2010-09-20)
----------------------------------

* Added the new function `gams-align-block` (C-cC-y). By this command, you
  can align table and other blocks in GAMS code. See Section "Align block"
  in gams-sample.gms for the details.

* Changed the default value of `gams-statement-file` from
  `~/.gams-statement` to `~/gams-statement.txt`.

* Changed the default value of `gams-template-file` from
  `~/.gams-template` to `~/gams-template.txt`.

* Added minor changes to GAMS-TEMPLATE mode.


Version 3.4 (2010-08-09)
----------------------------------

* Abolished the command `gams-modlib` and added the new command
  `gams-model-library` (binded to `C-cC-z`). This mode enables you to view
  (and extract) models in the GAMS library.

  To use `gams-model-library`, you need to set the proper value to the
  variable `gams-system-directory`. Note that this command command works
  only in GAMS of 22.8 or later.

  To extract files from the library, this command uses `gamslib.exe`.  You
  need to set the proper value to the variable `gams-gamslib-command`.

* Changed the default value of `gams-use-mpsge` to non-nil.


Version 3.3 (2010-07-24)
----------------------------------

* Added many changes to `gams-show-identifier-list` (C-cC-a) and
  `gams-show-identifier` (C-cC-. and F7).

  Now `gams-show-identifier-list` and `gams-show-identifier` try to parse the
  whole gms files (not only the top-level gms file but also subroutine files).

  Folowing this change, variable `gams-sid-search-in-subroutine-file` is
  abolished.


* Added the file variable `gams-master-file`.  For example, suppose that you add
  the following line in the gms file "included-file.gms",

  * gams-master-file: top-file.gms

  This means that "top-file.gms" is the top level file that includes
  "included-file.gms".  This master file information is used for
  `gams-show-identifier` and `gams-show-identifier-list` commands.

  By setting `gams-master-file`, you can evoke `gams-show-identifier-list` and
  `gams-show-identifier` from subroutine files. See "include-sample.gms" for the
  details.


Version 3.2 (2009-12-21)
----------------------------------

* Since gams.el ver. 3.1, you can specify the name and place of the LST
  file. In addition, gams.el ver 3.2 enables you to specify the LST file
  directory (the directory where lst files are stored).

  To use this feature, put the following code in your gms file.

  [Example]

        * gams-lst-file: .\listing\sample.lst
        * gams-lst-dir: .\result

  gams-lst-file specifies the name and place of the lst file and
  gams-lst-dir only specifies the directory for the lst file.

  [Usage of gams-lst-file and gams-lst-dir]

  Exampl 1:

        * gams-lst-file: .\listing\sample.lst

  By this code, the lst file -> .\listing\sample.lst

  Exampl 2:

        * gams-lst-file: c:\sample.lst

  By this code, the lst file -> c:\sample.lst

  Exampl 3:

  Suppose that your gms file is "gams-sample.gms".

        * gams-lst-dir: .\listing\

  Then the above code means that the lst file is ".\listing\gams-sample.lst".

  Example 4:

  Similarly,

        * gams-lst-dir: c:\

  This code means that the lst file is "c:\gams-sample.lst".


  Notes:

  1. You can use both full path and relative path to specify the LST file
     and directory.

  2. This function does not support file and directory name with spaces.
     It is because `o=' option of GAMS does not support such file name.

  3. If gams-lst-file and gams-lst-dir are not set, gams-mode assumes that
     the LST file has the same name as GMS file and is placed at the same
     directory as the GMS file.

  4. If both gams-lst-file and gams-lst-dir are set, the former overrides
     the latter.

  5. If you want to put the LST file in another directory, that directory
     must be created bofore you run gams.

  6. The lst file set by gams-lst-file or gams-lst-dir is overwritten with
     the one determined by o= setting in *#! notation.


* Added the new variable `gams-lst-dir-default`. If you always want to
  save all lst files in a specific directory, set the directory to this
  variable.

  For example, the following code implies that all lst files are saved in
  the subdirectory "lst" under the current directory:

        (setq gams-lst-dir-default ".\\lst\\")

  Similarly, the following code implies that all lst files are saved in
  the directory "c:\lst\".

        (setq gams-lst-dir-default "c:\\lst\\")

  If you set nil to this variable (the default setting), lst files are saved
  in the current directory.

  Note: If gams-lst-file or gams-lst-dir are set in a GMS file, the
  specification of the variable `gams-lst-dir-default` is overwritten.


Version 3.1.1 (2009-10-11)
----------------------------------

* Fixed bugs in coloring and `gams-show-identifier`.

* Added "gams-sample-ja.gms" for Japanese users.



Version 3.1 (2009-08-03)
----------------------------------

* A new feature: To move from the GMS file to the corresponding LST file,
  the previous gam-mode premises that both files have the same name
  (expect for the extension) and are placed in the same directory.  In the
  new gams-mode, you can use the different name for the LST file and put
  it in the different directory.

  For example, if you want to let "sample.lst" be the name of the LST and
  and put it in the subdirectory `listing`.  Then, add the following code
  somewhere in the gms file:

        * gams-lst-file: .\listing\sample.lst

  This code has two effects:

  1. gams is executed with option `o=.\listing\sample.lst`

  2. You can switch from the gms file to .\listing\sample.lst by C-cC-v
     (or F10).


  Notes:

  1. To specify the LST file, use the *relative* path and do not use
     *absolute* (full) path.

  2. This function does not support file and directory name with spaces.

  3. If gams-lst-file is not set, gams-mode assumes that the LST file has
     the same name and is placed at the same directory as the GMS file.

  4. If you want to put the LST file in another directory, that directory
     must be created bofore you run gams.

  5. The lst file set by gams-lst-file is overwritten with the one
     determined by o= setting in *#! notation.


* The default key-binding for `gams-show-identifier` is changed from
  `C-c..` to `C-cC-.`.


* Added the more explanation on *#! notation to gams-sample.gms.  *#!
  notation is a way for changing a command line easily (this is a function
  like #!/usr/bin/perl or #!/bin/sh for shell scripts).  For the details,
  see gams-sample.gms file.



Version 3.0 (2009-07-19)
----------------------------------

* Added the new mode called GAMS-LXI mode.  This mode provides a function
  that resembles the GAMSIDE listing function.  For the details, see
  /lxi/gams-lxi-sample.gms file.

  Note: To implement GAMS-LXI mode, the following code is added to
  gams.el.

        (add-to-list 'warning-suppress-types '(undo discard-info))

  This code might cause some problems.

* Minor change on `gams-start-menu`.

* The value of `truncate-lines` in GAMS-LST mode changes from nil to t.
  This means that continuation lines are not displayed in GAMS-LST mode.
  If you like the old behavior, use the following hook setting:

        (add-hook 'gams-lst-mode-hook
                  '(lambda ()
                     (setq truncate-lines nil)
                     ))

* Minor change on `gams-show-identifier-list` (the command evoked by
  C-cC-a).  $prod, $demand and $constraint blocks in MPS/GE are displayed
  in GAMS-SIL mode.

* Added the new command `gams-lst-file-summary` in GAMS-LST mode (the
  default key-binding is ".").



Version 2.7.1 (2009-03-13)
----------------------------------

* Fixed the bug related to GAMS process.



Version 2.7 (2009-03-10)
----------------------------------

* Changed the default value of `gams-recenter-font-lock` to t (you can
  recolor the block around the cursor by `C-l`).

* Fixed the bug in coloring.

* The new gams.el displays last modification time of LST file in the
  minibuffer when you move from GMS file to LST.

* The previous gams.el cannot handle multi-character inline and
  end-of-line comment symbols like `/*`, `*/` `//`.  In the new gams.el,
  you can use multi-character comment symbols.  In addition, the default
  inline comment symbols are changed to `/*` and `*/`.

        (setq gams-inlinecom-symbol-start-default "/*")
        (setq gams-inlinecom-symbol-end-default "*/")

* Function `gams-lst-jump-to-input-file` (key `i` in GAMS-LST mode) in the
  previous gams.el often fails when an input file name includes spaces.
  The new gams.el fixed this bug.

* Added function `gams-lst-next-elt`, `gams-lst-previous-elt`,
  `gams-lst-next-clt`, `gams-lst-previous-clt` in GAMS-LST mode (the
  default keybindins are `x` and `c`).  By these commands, you can move to
  `Equation Listing` and `Column Listing` part in the LST file.

* Bug fix for the pretest version of Emacs23 (Emacs 23.0.9x).  The
  GAMS-OUTLINE mode in the previous gams.el does not work well in pretest
  version of Emacs 23.

* In the new Emacs (ver 23.0.9), the default value of `comment-style`
  changed from `plain` to `indent`.  By this change, `gams-comment-region`
  (and `comment-region`) command fails.  To avoid this, please set plain
  to comment-style as the old Emacs:

  (setq comment-style 'plain)

* Added function `gams-report-bug`. This command outputs information for
  debugging GAMS mode. This command must be executed in a GAMS mode
  buffer.


Version 2.6.1 (2009-01-07)
----------------------------------

* Fixed the bug in coloring.

* `gams-show-identifier-list` now displays identifers defined by table.

* GAMS-OUTLINE mode in the previous versions has a serious bug.  This bug
  is fixed in the new version.

* The new gams.el can handle a file name with spaces like "foo bar 1.gms".



Version 2.6 (2008-12-20)
----------------------------------

* Added the new function `gams-ol-toggle-display-style` which is binded to
  `x` in the GAMS-OUTLINE mode.  By this command, you can toggle the
  display style (vertical or horizontal style) in the GAMS-OUTLINE mode.
  If you have a wide display, you had better select the horizontal style
  where two (or three) windows are arrayed horizontally.

  The default style is determined by the variable `gams-ol-display-style`.
  The width of the left column in the horizontal style is determined by
  the variable `gams-ol-width`.

* Added the new variable `gams-process-log-to-file` (the default value is
  nil).  If you set non-nil to this variable, GAMS log is written to the
  log file even without lo=2 option.  GAMS log in this context means the
  content of GAMS process buffer.  The extention of log file is determined
  by the variable `gams-log-file-extension` ("glg" by default).

* Added `gams-toggle-hide/show-comment-lines`, which is binded to
  `C-cC-h`.  This command enables you to hide (or show) all comment lines
  (lines started with * and lines enclosed by $ontext-$offtext pair) in
  the buffer.  Note that this command only hide lines and makes no
  modification to the buffer.

* The GAMS-OUTLINE mode displays more items (for example, Compilation,
  Include File Summary etc.).  The new GAMS-OUTLINE mode is not compatible
  with the old one.  So, please delete the following part in
  ~/.gams-statement" if it exist:

        (setq gams-user-outline-item-alist '(
        ....
        ))

  In addition, please change the setting for the variable
  `gams-ol-view-item`.

* Fixed the bug in `gams-show-identifier`.

* Fixed the error in the sample template file ".gams-template".

* Fixed the bug in font-lock (coloring) for gams mode.

* A minor change to `gams-show-identifier-list`.

* Changed GAMS-SIL mode.  Explanatory text for equations in equation
  declaration part (EQU part) is displayed also in equation definition
  part (DEF part).  Similarly, explanatory text for model in model
  declaration part (MOD part) is displayed also in solve statement part
  (SOL part).

* Added the function `gams-change-gams-command`.  You can change GAMS
  command name in the process menu as you can change gams commad line
  option.  Try `C-cC-tc`.  The registered GAMS command name is stored
  in the file determined by `gams-statement-file`.

* Changed `gams-show-identifier`.  Now, you can extract (copy) the
  explanatory text from the identifier declaration part.  Try `C-c..` and
  type `e`.


Version 2.5 (Sat Mar 29, 2008)
----------------------------------

* Added the new variable `gams-docs-directory`.  This variable determines
  the GAMS document directory.  By default, it is set to
  `gams-system-directory` + docs."

* Fixed bugs in the function `gams-view-docs`.


Version 2.4 (Wed Jul 19, 2006)
----------------------------------

* Modified the indentation function.  The new gams mode makes cleverer
  indentation.

* Supported Emacs 22.  Now, you can use gams.el in Emacs22.


Version 2.3 (Sat Nov  5, 2005)
----------------------------------

* Fixed bugs for XEmacs.

* Fixed bug in GAMS-OUTLINE mode.


Version 2.2 (Sun Sep  4, 2005)
----------------------------------

* Fixed bugs in coloring of MPSGE block.

* Fixed bug in `gams-insert-statement-extended`.  Now,
  `gams-insert-statement-extended` works well also in the case that
  `gams-statement-upcase` is non-nil.


Version 2.1 (Fri Nov  5, 2004)
----------------------------------

* Added the new function `gams-show-identifier-list` (binded to C-cC-a by
  default.  This command displays the list of all GAMS identifers existing
  in the gms buffer.

* Abolished the variable `gams-docs-dir`.  You must assign a proper value
  to `gams-system-directory` if you want to use `gams-view-docs`.
  `gams-view-docs` does not work in some versions of GAMS.

* Added the new variable `gams-special-comment-symbol` (default is
  "com:").

* Fixed bugs in `gams-lst-jump-to-error-file`.

* Fixed many bugs in coloring.


Version 2.0 (Tue Sep 9, 2003)
----------------------------------

* Abolished the command `gams-show-identifier-defintion` (C-c.) and added
  the new function `gams-show-identifie`.  Try "C-cC-." and "C-uC-cC-." in
  GAMS mode.  See also "gams-sample.gms".

* Added the new command `gams-insert-statement-extended`.  Try "C-cC-n" in
  GAMS mode.

* Exchange the role of "l" key and that of "L" key in GAMS-LST mode.

* Changed indentation pattern.  If you want to use the previous type of
  indentation, set t to the variable `gams-indent-more-indent`.

  If gams-indent-more-indent is nil, the following indentation is
  realized.

        set
            i   Sector index / agr, man1, man2, ser /,
            f   Primary factor index
            / cap, lab, lan /
            c   Commodity index /
            agr, man, ser /;

  On the other hande, if gams-indent-more-indent is t,

        set
            i   Sector index / agr, man1, man2, ser /,
            f   Primary factor index
                / cap, lab, lan /
            c   Commodity index /
                agr, man, ser /;

* Changed some keybindins.  See gams-refcard.pdf.


Version 1.10 (Sun Feb 16, 2003)
----------------------------------

* Added the new function `gams-comment-region` (C-cC-;).  This function is
  an alias for `comment-region`.  Select an region and type C-cC-;, then
  you can comment out it.  You can also uncomment the commented-out region
  by attaching the universal argument like (C-uC-cC-;).

* Added the new function `gams-replace-statement` which replaces the
  existing statements or dollar control options with the new one.  If you
  execute this command on the existing GAMS statements or dollar control
  options, you can replace them with the new onew.  To execute this
  command, attach the universal argument to C-cC-k and C-cC-d
  (i.e. C-uC-cC-k, C-uC-cC-d).

* Added the new function `gams-ol-refresh` (binded to r in GAMS-OUTLINE
  mode).  Refresh the GAMS-OL buffer if the LST file is updated.

* Modified `gams-insert-parens`.  In the previous version, typing `(`
  inserted a pair of parenthesis if `gams-close-paren-always` is non-nil.
  Now, if you attach the prefix argument to `(` [i.e. typing `C-u (`],
  just insert `(`.

* Added the new variable `gams-ol-item-name-width` (its default value is
  18).  The width of item name field in GAMS-OUTLINE.

* Modified display in GAMS-OUTLINE mode.



Version 1.9 (Tue Jan 14, 2003)
----------------------------------

* Added the new variable `gams-sd-included-file` (its default value is t).
  If this variable is assigned non-nil, `gams-show-identifier-defintion`
  searches the identifier definition also in the files included through
  $include or $batinclude.  If nil, search the identifier definition only
  in the current file."

* Fixed the bug in coloring.

* Fixed the bug in `gams-show-identifier-defintion`.



Version 1.8 (Sat Dec  7, 2002)
----------------------------------

* Added the new function `gams-open-included-file` (binded C-cC-w).  If
  you execute this command on the file name after $include or $batinclude,
  you can open the included file.

* Added the new function `gams-goto-matched-paren` (binded to F8).  This
  command is the same as F8 in GAMSIDE and you can jump to the matched
  parenthesis.  This command is vaild only if the cursor is on the
  parenthesis.

  The position of the cursor where this command is valid (e.g)

    (a + b + c + d * f * h)
    ＾                     ＾
       Here and       here

  Note that with respect to the right parenthesis ), the cursor should be
  placed at the _next_ point after the ).

* Fixed the bug in `gams-ol-view-next`.  Until the previous, in Emacs 20
  and XEmacs, the `gams-ol-view-next` (binded to `N` by default) sometimes
  doesn't work properly in GAMS-OUTLINE buffer: a window doesn't scroll if
  you type `N` on the last line of the window.  I fixed this bug for Emacs
  20.  But XEmacs still has this bug.

* Added the new function `gams-show-identifier-defintion` (binded to F7
  and C-c. by default).

  While you are reading or editing a GAMS program, you may often go back
  to the declaration part of an identifier so as to see its definition.
  In such a case, you could use, for example, `isearch-backward` command
  or something.  But if the identifier is used many times at the different
  parts of the program, it is difficult to find the declaration part of
  the identifier.

  This command enables you to see the declaration part of the identifier
  under the cursor.  See "gams-sample.gms" file about how this command is
  used.  The new face `gams-highline-face` is also added.

* Added the new function `gams-outline-external` (binded to O in GAMS-LST
  mode).

  When a LST file is very large, it often takes much time to start
  GAMS-OUTLINE mode.  In stead of the lisp code, this command uses the
  external program to create GAMS-OUTLINE buffer.

  When a LST file is large, this command _may_ take much less time than
  `gams-outline`.  Generally,

  Small LST files => `gams-outline` is a little faster.
  Large LST files => `gams-outline-external` is faster.

  But it depends on the type of LST files.  `gams-outline` may be faster
  than `gams-outline-external` even for large LST files.  If you are
  satisfied with the speed of GAMS-OUTLINE mode, you need not use this
  command.  Just use `gams-outline`.

  As the external program, you can use the C program (gamsolc.exe) or the
  Perl script (gamsolperl.pl).  The C program works faster than the Perl
  script, but the C program is offered only for MS windows (I cannot
  compile the program with gcc on Unix).  The Perl script gamsolperl.pl
  works both on MS windows and Unix systems as long as Perl5 is installed
  in that system.  If you are MS windows user, use gamsolc.exe.  If you
  are Unix user, use gamsolperl.pl.

  To use this command, you need to set the proper values to the variable
  `gams-ol-external-program`.  If you use the Perl script,
  `gams-perl-command` also must be assign the value (the default values of
  two variables above are set to nil).  See the help discription of these
  variables.  Moreover, gamsolc.exe or gamsolperl.pl must be placed at the
  proper place.

* Fixed the various bugs of codes for XEmacs (thanks to H. Kremers).  Now,
  the full coloring works also on XEmacs.  But generally speaking this
  program is likely to work better on GNU Emacs.

* Fixed various minor bugs.


Version 1.7 (Tue Oct 22, 2002)
----------------------------------

* Binded `gams*start-processor` to C-cC-s and F9.  Now, you can run gams
  by typing these keys.

* Added the new function `gams-from-gms-to-outline` (binded to C-cC-i and
  F10 by default).  With this command, you can jump directly to the
  OUTLINE buffer from gms file buffer.

* Added the new function `gams-from-outline-to-gms` (binded to `;` by
  default).  With this command, you can jump directly to the gms file
  buffer from the OUTLINE buffer.

* Fixed the bugs in automatic indent.

* Added the new variable `gams-always-popup-process-buffer` (its default
  value is t) and the new function `gams-popup-process-buffer` (binded to
  C-cC-l by default).  If `gams-always-popup-process-buffer` is assigned
  nil, the process buffer does not popup.  `gams-popup-process-buffer`
  makes the process buffer popup.


* Changed the default value of `gams-template-cont-color` to nil.  Non-nil
  makes the program very slow.  If you want to make the template content
  buffer colored, set it by yourself.


* If you are an Emacs21 user, please set `gams-display-small-logo` to t.
  Something may happen on the modeline :-)


* Supported XEmacs.  But it is incomplete in the following aspects.

  1. I do not support the level 2 coloring (e.g., no color on explanatory
     text etc.).  So, even if you select the level 2 coloring with
     `gams-choose-font-lock-level`, the coloring level is 1.

  2. Many commands may not work on XEmacs.  As far as I know,
     `gams-comment-dwim`, `gams-comment-dwim-inline` do not work.

  I tested the program only with XEmacs 21.4 on MS windows.


* Fixed the bug in GAMS-TEMPLATE mode.


Version 1.6 (Sat Sep  7, 2002)
----------------------------------

* Modified `gams-comment-dwim` and `gams-comment-dwim-inline` (M-; and C-;
  respectively).  Now, you can select the position of end-of-line and
  inline comment when you insert them.

* Until the previous version, coloring doesn't work when you edit already
  written set elements in a slash pair.  I modified the program so that
  coloring works in such a situation.

* Changed key-bindings.

  Emacs Lisp Manual says

>  "The key sequences bound in a major mode keymap should usually start
>  with `C-c`, followed by a control character, a digit, or `{`, `}`, `<`,
>  `>`, `:` or `;`.  The other punctuation characters are reserved for
>  minor modes, and ordinary letters are reserved for users.".

  The previous key-bindings in GAMS mode are against this rule.  So, I
  have changed the default key-bindings.  In the new key-bindings, I
  attached C- (control key) to the old ones.

  For example,

    Old binding       New binding

    C-ck      =>  C-cC-k
    C-cd      =>  C-cC-d
    C-ce      =>  C-cC-e

  If you don't like these key-bindings, please change them by yourself.
  Key-bindings in other modes remain the same.  Please see the help in
  each mode or see the refcard "refcard-gams.pdf".

* Added the new variable `gams-indent-number-equation`.

* Fixed the bug in "dot-emacs-sample".  Until the previous version,
  (require 'gams) is located at the beginning of "dot-emacs-sample".  But
  some of settings are not valid if they are located after (require
  'gams).  So, if you use (require 'gams) in ".emacs.el", you must put it
  at the end of all GAMS settings.  But I recommend `autoload` rather than
  `require`.  See the new "dot-emacs-sample".

* Fixed the bug in `gams-ol-mark`.

* Changed the default value of `gams-docs-view-program` to
  "c:/Program Files/Adobe/Acrobat 5.0/Reader/AcroRd32.exe".

* Changed the default coloring.

* Fixed various minor bugs.


Version 1.5 (Fri Aug 23, 2002)
----------------------------------

* Modified `gams-font-lock-keywords-1` and `gams-font-lock-keywords-2`.

* Until the version 1.4, the automatic indent has many bugs and does not
  work well in various situations.  It is mainly because my rule and
  program for indent are ad-hoc.  In this version, I have modifed the
  large part of codes for automatic indent.  New codes may include (new)
  bugs, but they will generally work better than old ones.

  In the new indent rule, a line is indented properly only if the previous
  lines are already indented properly.

* Added the refcard.


Version 1.4 (Mon Aug  5, 2002)
----------------------------------

* Added the new function `gams-insert-on-off-text` which is binded to C-cc
  by default.  This command inserts an ontext-offtext pair.  If you attach
  universal-argument, this encloses the specified region with an
  ontext-offtext pair.

* Added the new face `gams-title-face`.

* Fixed the bugs in `gams-comment-dwim` and `gams-comment-dwim-inline`.

* Fixed bugs in automatic indentation and coloring.  Thanks to Marko
  Loparik.

* Added the new variable `gams-indent-equation-on` Non-nil means indent
  equation blocks.  If nil, already written equations are not affected by
  TAB.  Its default value is t.

* The values of `gams-inlinecom-symbol-start-default`,
  `gams-inlinecom-symbol-end-default`, and `gams-eolcom-symbol-default`
  are used as default inline and end-of-line comment symbols The default
  values of these variables are "{", "}", "!" respectively.

* If $inlinecom or $eolcom do not exists in the file, `gams-comment-dwim`
  and `gams-comment-dwim-inline` insert their default values determined by
  the variables `gams-inlinecom-symbol-start-default`,
  `gams-inlinecom-symbol-end-default`, and `gams-eolcom-symbol-default`.
  If you attach the universal argument when executing `gams-comment-dwim`
  and `gams-comment-dwim-inline`, you are asked which symbol to be
  inserted.

* Added the new function `gams-ol-item` binded to T in GAMS-OUTLINE mode.
  You can select viewable item combination from registered list.  You can
  register a new item combination in GAMS-ITEM-SELECT mode
  (`gams-ol-select-item`).

* Added the new function `gams-ol-select-quit` and `gams-ol-select-select`
  in GAMS-ITEM-SELECT mode.

* Fixed the bug in automatic indentation.


Version 1.3.1 (Sun Apr 14, 2002)
----------------------------------

* Fixed the bug in GAMS-OUTLINE mode.  Now, the values of REPORT SUMMARY
  field are displayed correctly.

* Modified `gams-calculate-indent-decl`.  Indentation rule for declaration
  type block is modified.

* Fixed the bug in colorization for inline and eol comments.

* Fixed the bug in colorization for explanatory text.


Version 1.3 (Mon Apr  1, 2002)
----------------------------------

* Supported automatic indentation.  You can indent GAMS program according
  to GAMS syntax.

  As in most major modes in Emacs, the indent-line function
  (`gams-indent-line`) is binded to TAB key.  By typing TAB key, you can
  indent the current line.  To indent whole lines in a region, use M-C-\
  (`indent-region`).  When you type RET and make a new line, indent is
  automatically inserted (`gams-newline-and-indent)`.

  If you want to use TAB key to insert TAB itself and bind
  `gams-indent-line` to another key, put the following setting in your
  "~/.emacs.el".

        (add-hook 'gams-mode-hook
                '(lambda ()
                 (let ((map gams-mode-map))
                  (define-key map [f2] 'gams-indent-line)
                  (define-key map "\t" 'gams-insert-tab))))

  In this example, `gams-indent-line` is binded to F2 key and the command
  for inserting TAB (`gams-insert-tab`) is binded to TAB key.

  Automatic indentation is off in the following cases: (i) In table
  blocks.  Since in table blocks format matters, I make indentation off
  there. (ii) In a ontext-offtext pair.  (iii) For already written
  equations in normal part (not in equations block).

  Four new customizable variables for indentation are added.
  `gams-indent-on`, `gams-indent-number`, `gams-indent-number-loop` and
  `gams-indent-number-mpsge`.  If you want to make automatic indentation
  off, set `gams-indent-on` to nil.  Its default value is of course t :-)

  Although I have tested indentation in several GMS files, it is likely
  not to work in various cases.  If you encounter odd behaviors of
  automatic indentation, please let me know it and send me an example
  program in which indentation does not work well.

  To make automatic indentation in GAMS mode work well, please end a
  reserved word block (e.g. parameter, table, set blocks etc.) with a
  semicolon (;) although it may not be necessarily required in GAMS
  syntax.

  I am a beginner of GAMS and don't know proper programming style in GAMS.
  So indentation rule is determined mainly by my tastes.  If you have
  suggestions or requests for indentation rule, please let me know it!

* Added the new customizable variable `gams-insert-dollar-control-on`.
  Until the previous version, $ key is binded to executing
  `gams-insert-dollar-control`.  But now $ key is binded to inserting $
  itself by default.  If you want to use $ key to execute
  `gams-insert-dollar-control`, set this variable to non-nil.

* Supported the rich coloring like GAMSIDE.  Newly introduced customizable
  faces are `gams-string-face`, `gams-slash-face`, `gams-operator-face`,
  `gams-explanation-face`, `gams-oth-cont-face`.  If you encounter odd
  behaviors of coloring, please let me know them with an example GAMS
  program in which coloring does not work well.  I'll fix them.  For Emacs
  21 users, please read BUGS file.

* Speed up coloring in GAMS mode!  Now, coloring (font-lock) requires much
  less time in GAMS mode.  In the previous version of gams.el, coloring
  requires extra time because of my silly mistake in the program :-)

* Added the new function `gams-choose-font-lock-level`.  This command
  changes the font-lock (coloring) level in GAMS, GAMS-LST, GAMS-OUTLINE
  modes.  By default, it is binded to C-cf in all three modes.  GAMS
  program files or LST files are often very large and font-lock requires
  much time to color such big files.  So before you open a big file, you
  had better change the font-lock level by this command.  The number of
  levels is three: 0, 1, and 2: 0 means no color (font-lock-mode is off),
  1 means minimum color, and 2 means maximum color.  If you want to open a
  big file, you had better set the font-lock level to 0.  The default
  font-lock level in each mode is determined by the value of customizable
  variables `gams-font-lock-level`, `gams-lst-font-lock-level`, and
  `gams-ol-font-lock-level`.  All default values are 2 (maximum).

* Supported `font-lock-fontify-block` (binded to M-gM-g).  With this
  command, you can re-color a part around the cursor (not an entire
  buffer).

* Added the new variable `gams-mode-load-hook`.  The content of this hook
  variable is run after "gams.el" is loaded.

* Changed `gams-outline` to make GAMS-OUTLINE mode faster.

* Added the new variable `gams-system-directory`.

* Added the new function `gams-modlib` (binded to C-cz).  With this
  command, you can extract a model from GAMS model library.  To use this,
  you must set the GAMS system directory to the variable
  `gams-system-directory`.

* Added the new function `gams-option` which is evoked through
  `gams-start-menu` (C-ct).  By selecting "Change option" in the process
  start menu, you can change and register several combinations of options.
  Registered option combinations are stored in the file
  `gams-statement-file`.

* Fixed the typo in "dot-emacs-sample".  Thanks to Steven Dirkse.

* Modified GAMS-OUTLINE mode so that the values of items in REPORT SUMMARY
  (NONOPT, INFEASIBLE, etc.) are displayed.

* Modified GAMS-OUTLINE mode coloring for SOLVER STATUS and REPORT
  SUMMARY.  I assume that 1, 2, and 8 of the value of MODEL STATUS mean no
  error (I am not sure whether this is appropriate or not).  If SOLVER
  STATUS and REPORT SUMMARY parts indicate some errors, they are colored.

* Fixed the bug in coloring for copied program listing in GAMS-LST mode.

* Thanks to Marko Loparik for his bug reports and suggestions.

* Fixed the bugs in coloring of GAMS-LST mode and added new coloring.

* Modified `gams-insert-single-quotation`.  Until the previous version,
  this command inserts "`'" if `gams-close-single-quotation-always` is
  non-nil.  The new one inserts "''".  The default value of
  `gams-close-single-quotation-always` has changed to nil.

* Added new functions `gams-comment-dwim` and `gams-comment-dwim-inline`
  (binded to M-; and C-; respectively).  With these commands, you can
  easily insert end-of-line or inline comments.  The end-of-line and
  inline comment symbols are determined by $eolcom and $inlinecom dollar
  control options in the file.  If comment symbols have already been
  specified in the file, they are used for these two commands.  Otherwise,
  you will be asked which comment symbols to use and $eolcon or $inlinecom
  will be inserted at the first line in the file automatically.  In MPSGE
  block, "!" is always used as the end-of-line comment symbol.  The
  default comment symbols are determined by the variables
  `gams-inlinecom-symbol-start-default`,
  `gams-inlinecom-symbol-end-default`, and `gams-eolcom-symbol-default`.
  The default values of these variables are "{", "}", "!" respectively.
  There is one more new variable `gams-comment-column`.

* Added the new variable `gams-template-cont-color`.  If this variable is
  assigned non-nil, the *Template Content* buffer is colorized.  The
  default value is t.  If you set nil to this variable, TEMPLATE mode
  works faster.

* Fixed various minor bugs.


Version 1.2 (Tue Feb  5, 2002)
----------------------------------

* Added new functions `gams-ol-widen-one-line` and
  `gams-ol-narrow-one-line` (binded to `o` and `l` respectively).  These
  commands change the widow height in GAMS-OUTLINE mode.

* Added a new function `gams-comment-on-off-text` (binded to `C-cC`).
  When this command is executed on a $ontext ($offtext), both $ontext
  $offtext are commented out (or uncommented out if they are already
  commented out).

* Added a new function `gams-remove-on-off-text` (binded to `C-cG`).  When
  this command is executed on a $ontext ($offtext), both $ontext
  ($offtext) and the corresponding $offtext ($ontext) are removed.

* Changed the default value of `gams-recenter-font-lock` to nil because it
  takes much time to recenter a relatively large buffer.

* Supported comment prefix other than *.  If you use $comment control to
  set your own comment prefix, it is automatically used in GAMS mode.  But
  a comment prefix other than * may not be recommended (?)

* Fixed the bug of font-lock in GAMS.  Until the previous version, the
  ontext-offtext region which includes dollar mark is not colored in Emacs
  20.  Now, such a region can be colored both in Emacs 20 and 21.

* Fixed the typo in dot-emacs-sample file.  Thanks to C. Starkweather.

* Several minor changes.


Version 1.1 (Sun Jan 20, 2002)
----------------------------------

* The name of GAMS-OVERVIEW mode is changed to GAMS-OUTLINE mode. overview
  or ov in the names of functions and variables are changed to outline or
  ol respectively.

  For example,
  `gams-overview` => `gams-outline`.
  `gams-ov-height` => `gams-ol-height`.

  Especially, take care of the customizable variables such as
  `gams-ol-height`, `gams-ol-height-two`, `gams-ol-view-item`.

* Supported `customize`.  You can change the values of customizable
  variables in GAMS mode by customize command.  Try to type M-x
  customize-apropos-groups [RET], gams [RET].

* Added the original faces for GAMS mode.  If you want to change default
  faces, use `custom-set-faces` (see "dot-emacs-sample" file) or M-x
  customize-face.

* Added the new function `gams-view-docs` (binded to `C-cm` by default)
  which enables you to view GAMS pdf manuals from Emacs.  Set proper
  values to the customizable variables `gams-docs-dir` and
  `gams-docs-view-program`.

* Added the new function `gams-jump-on-off-text` (binded to `C-cg` by
  default).  If you execute this command on $ontext ($offtext), then you
  jump to the corresponding $offtext ($ontext).

* Supported menu.  Useless?

* The author's email address is changed from <ged9203@srv.cc.hit-u.ac.jp>
  to <zbc08106@park.zero.ad.jp>.



Version 1.08 (Mon Dec  3, 2001)
----------------------------------

* Sorry, but I changed the name of the program from "gams-mode.el" to
  "gams.el" again.  It is because the name "gams-mode.el" is already used
  in the lisp written by Winston C. Yang (<winston@cs.wisc.edu> or
  <http://www.cs.wisc.edu/~winston/>).

* Added the GAMS-OVERVIEW mode.  Newly added custumizable variables are
  `gams-ov-height`, `gams-ov-height-two`, and `gams-ov-view-item`.

* Changed a lot of default keybindings in the GAMS-LST mode so that
  similar keybindings are applied to both the LST and OVERVIEW mode.  See
  the help in both modes for keybindings.

* Added the variable `gams-recenter-font-lock`.  Non-nil means font-lock
  again with recentering.  If your computer is slow, you had better set
  this to nil.

* Changed the default values of `gams-statement-upcase` and
  `gams-dollar-control-upcase` to nil.

* Changed the regular expression for `gams-font-lock-keywords`.

* Fixed various minor bugs.

* Modified the "dot-emacs-sample" file.  Thanks to Steven Dirkse.



Version 1.07.1 (Tue Oct 23, 2001)
----------------------------------

* Changed the name of the program from "gams.el" to "gams-mode.el".

* Fixed the bug of `gams-fill-paragraph` reported by Collin Starkweather.

* Fixed the bug of `gams-view-lst` and `gams-jump-to-lst`.



Version 1.07 (Mon Sep 24, 2001)
----------------------------------

* Added Easy templates handling (GAMS-TEMPLATE).  `gams-template` binded
  to `C-ce` by default.

* Multi processes.  Until ver 1.06, you can run only one process of GAMS
  in an Emacs.  But from this version, you can run multiple GAMS processes
  simultaneously if you set a variable `gams-multi-process` to non-nil.

* Added `gams-indent-line-function`.



Version 1.06 (Thu Sep 13, 2001)
----------------------------------

* Made a little change on the functions `gams-insert-statement` and
  `gams-insert-dollar-control`.

* TAB key is binded to inserting TAB.

* Fixed various bugs.



Version 1.05 (Mon Sep  3, 2001)
----------------------------------

* Added a variable `gams-file-extension`.  This variable is a list of
  extensions of files in which GAMS mode starts automatically.

* Changed the setting in .emacs.  Now you don't need to set
  auto-mode-alist and autoload in .emacs.  Just write (load "gams").  See
  the file `emacs-sample`.

* Corrected many typos and misspelling.

* Fixed various minor bugs.

* Fixed the bug in `gams-insert-dollar-control`.



Version 1.04 (Sat Sep  1, 2001)
----------------------------------

* Added a new function `gams-lst-jump-to-error-file` binded to `g` which
  was previously binded to `gams-lst-view-gms`.  Now you can jump to error
  places in included files inserted by, for example, $libinclude or
  $batiinclude statements.

* Added font-lock (colorization) to GAMS-LST mode so that keyword VAR,
  PARAMETER etc. are colorized.



Version 1.03 (Sat Aug 25, 2001)
----------------------------------

* Made a process window not disappear.

* Made a little change on `gams-start-menu`.

* Add a function `gams-insert-comment` and a variable `gams-user-comment`
  to insert user defined comment template.

* Set the auto-fill-mode off by default.



Version 1.02 (Thu Aug 23, 2001)
----------------------------------

* Fixed the bug in `gams-insert-parens` reported by Steven Dirkse.

* Fixed other various bugs.

* Added a variable `gams-statement-regexp-default` for font locking
  (colorization).

* Changed the default value of `gams:process-command-option`.

* Added a variable `gams-use-mpsge`.



Version 1.01 (Tue Aug 21, 2001)
----------------------------------

* Fixed the bug reported by Tor-Martin Tveit and Steven Dirkse.

* Changed `gams-insert-statement` and `gams-insert-dollar-control`.

* More items added to `gams-statement-up` by Steven Dirkse.





--------------------
Local Variables:
mode: markdown
fill-column: 74
coding: utf-8-dos
End:
