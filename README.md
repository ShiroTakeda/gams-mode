<!--
Author: Shiro Takeda
Maintainer: Shiro Takeda
-->

GAMS-mode
============================================================

This package offers the Emacs lisp program for using the numerical
software GAMS in Emacs (GAMS mode for Emacs).

If you want to know how to install GAMS mode, read
[Installation](#installation) below. If you want to know the latest
changes added to GAMS mode, see [CHANGELOG.md](CHANGELOG.md) file.

------------------------------------------------------------

# The contents of this file.

<!-- some long code -->

1. [Introduction (brief overview)](#introduction-brief-overview)
2. [Screenshots](#screenshots)
3. [Installation](#installation)
4. [Basic Usage](#basic-usage)
5. [Customization](#customization)
6. [TODO](#todo)
7. [Miscellaneous](#miscellaneous)
8. [Acknowledgments](#acknowledgments)

------------------------------------------------------------

# Introduction (brief overview)

## Introduction of GAMS mode for Emacs.

GAMS mode for Emacs offers an integrated and flexible environment for using GAMS in Emacs.

This section presents a brief overview of what GAMS mode for Emacs is. Please read the section "Installation"' below for information about how to install GAMS mode. If you are upgrading from the previous version of GAMS mode, you can find the latest changes in [CHANGELOG.md](CHANGELOG.md) file.

You can obtain the latest version of this program at the website [GAMS mode for Emacs (https://github.com/ShiroTakeda/gams-mode/)](https://github.com/ShiroTakeda/gams-mode/).

1. When you use GAMS, you must do the following jobs:
2. Edit GAMS program file,
3. Call GAMS to execute the program,
4. Read the output file,
5. Debug the program,
6. Examine the numerical values in the output file,

and so on... 

GAMS mode for Emacs offers various kinds of features which raise your
efficiency in all these jobs.

GAMS mode for Emacs offers the following five major modes (I skip the
explanation of the Emacs terminology "major mode." If you cannot
understand the terminology, I recommend you to read the introductory
document of Emacs first).

| Mode                  | Explanation                                   |
|:----------------------|:----------------------------------------------|
| GAMS mode:            | Editing GAMS program files.                   |
| GAMS-LST mode:        | Viewing LST files.                            |
| GAMS-SIL mode:        | Viewing GAMS program structure.               | 
| GAMS-TEMPLATE mode:   | Handling templates of programs.               |
| GAMS-OUTLINE mode:    | Viewing important items of LST files.         |

Furthermore, the following features are included in each major mode.

## GAMS mode

This is the major mode for editing GAMS program file.

1. Inserting GAMS statements and dollar control options.
2. Automatic registering of new statements and dollar control options.
3. Calling GAMS from Emacs
4. Syntax hilighting.
5. Handling templates of various programs (this is GAMS-TEMPLATE mode).
6. Automatic indent.
7. Viewing GAMS program structure (GAMS-SIL mode).
8. Reading GAMS manual.
9. Extracting models from GAMS model library.

I will explain each function in detail.

By registering GAMS statements and dollar control options beforehand, (1)
enables you to insert them into the program file easily.  You can insert
the long statements and dollar control options (that you are likely to
mistype) without typing them by yourself.

Although there are a lot of GAMS statements and dollar control options,
only a part of them is registered by default in GAMS mode.  It is because
frequently used statements differ according to users, and because it is
desirable to exclude rarely used statements from candidates of input
function of (1). However, (2) enables you to register new statements and
dollar control options.  You can easily add the commands that you
frequently use to the candidate for command inserting function of (1).

(3) is the function to call GAMS directly from Emacs for executing the gms
file.

Like GAMS Studio (or GAMSIDE), (4) provides the colorization of GAMS
program files according to GAMS syntax.

When editing GAMS program files, you may often use similar patterns
frequently.  In that case, you may copy and paste the program repeatedly.
But it is undoubtedly more convenient if you can register frequently used
patterns and select them.  Or, although the pattern is not frequently
used, it may be hard to remember it.  Also in that case, it seems
convenient if you can use registered patterns.  (5) offers you the feature
for registering various patterns easily.  In addition to registering, you
can modify, delete, rename and re-order existing templates easily.

Many people agree with the opinion that the proper indent is important for
writing programs that other people (or yourself) can read easily.  But it
is quite tedious to insert spaces and TABs manually by yourself.  In GAMS
mode, each line is automatically indented according to GAMS syntax (6).

When we write a GAMS program, we define many (sometimes hundreds of)
variables, equations, sets and parameters and it is difficult to remember
which identifier represents what.  Feature (7) enables you to show the
list of all identifiers defined in a program and you can see the structure
of a program.

In addition, you can call a manual viewer from Emacs (8) to read GAMS
manuals and you can view GAMS model library in Emacs (9).


## GAMS-LST mode

This is the major mode for viewing the output file (i.e. LST file).

1. Display the error place and its meaning.
2. Jump to the error place in the program file.
3. Jump to the various places in the LST file.
4. Color the content of the LST file.
5. Display the important items of the LST file (this is the GAMS-OUTLINE mode).

In editing GAMS program, one of the most important job is debugging.  Your
efficiency of writing program crucially depends on the efficiency of
debugging.  (1) and (2) are the functions for that.

With (1) and (2), you can do the following jobs quickly with simple key
operation.

* Call GAMS and execute the program.
* Move to the LST file.
* Examine the place and meaning of errors.
* Go back to the error place in the program.

You can do similar things also in GAMSIDE, but, I think GAMS mode offers
the more convenient environment.

LST files often become quite large.  In that case, it is hard to search
the output that you want to see.  (3) provides you the feature for moving
to various important items (such as PARAMETER, SET, VAR, EQU) in the LST
file with simple key operation.

Function (4) colors the content of LST files.

As pointed out above, the LST file is often very large and it is often
very difficult to find the numerical values you want to see. And it is
also difficult to compare the numerical values in two different parts of
the LST file.  Although you may be able to resolve these problems by
defining parameters that display only relevant values, it is more
convenient if you can examine the content of the LST file in a simple way.

(5) provides the way for that.  With this feature, you can easily view the
important elements (PARAMETER, VAR, EQU, etc.) in LST files.

You can see where the particular PARAMETER or VAR are and can see the
content of them.  You can also compare the numerical values in a part of
the file with that in another part.  You are able to know what this
function is like by looking at the screenshots placed at [the screenshots
page](https://www.flickr.com/search/?sort=date-taken-desc&safe_search=1&tags=gamsmode&user_id=144666886%40N07&view_all=1).

These are the simple explanation of this program.  Of course, there are a
lot of other functions!

Bug reports, requests, and suggestions are all welcome!


------------------------------------------------------------

# Screenshots

See [screenshots page](https://www.flickr.com/search/?sort=date-taken-desc&safe_search=1&tags=gamsmode&user_id=144666886%40N07&view_all=1).


------------------------------------------------------------

# Installation

First, I explain the files distributed in the package.

| Filename                                           | Explanation                                                                                                                 |
|:---------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|
| `README.md`                                        | This file.  First read this file.                                                                                           |
| [`gams-mode.el`](gams-mode.el)                     | This is the main lisp program.                                                                                              |
| [`sample_gams_code`](sample_gams_code)             | This folder includes sample gms files. If you want to learn how to use GAMS mode, read gams-sample.gms file in this folder. |
| [`gams-setting-sample.el`](gams-setting-sample.el) | Sample file of settings in init.el file.                                                                                    |
| `gams-template.txt`                                | Sample file of templates.                                                                                                   |
| [`CHANGELOG.md`](CHANGELOG.md)                     | Change log file that records history of changes.  If you want to know changes and newly added functions, please read it.    |
| [`BUGS_PROBLEMS.md`](BUGS_PROBLEMS.md)             | Known bugs and problems.                                                                                                    |
| [`doc`](doc)                                       | Document folder which includes the reference card.                                                                          |
| `lxi`                                              | This folder includes files used to explain GAMS-LXI mode.                                                                   |
 
If you are well acquainted with Emacs, installation is straightforward.
Here, I explain the basic Emacs terminologies used below.  But if you are
a novice user of Emacs, I recommend you to read the website
http://www.gnu.org/software/emacs/manual/html_node/efaq-w32/index.html.

`"~/"`

This is Unix terminology rather than Emacs'. This represents a user's HOME
directory. A user's HOME directory is the directory (folder) where his
configuration files are placed. If you are MS Windows, the default HOME
directory is set to "c:\Users\username\AppData\Roaming". If you want to
know to which directory your home directory is set, evaluate (getenv
"HOME") in the *scratch* buffer on Emacs.  You can set your HOME directory
by the environmental variable HOME.


`"~/.emacs.d/init.el"` or `"init.el"`

This is the configuration file that Emacs tries to read first when it is
started.  You can change the behavior of Emacs by writing various settings
in this file.  Note that this is the file that you must create by yourself
and there exists no "init.el" file by default (unless the administrator
has created it for you).

`non-nil`

In Emacs terminology, non-nil means anything other than nil, and values
such as 0, "a", or t all mean non-nil.  But we usually use symbol t as
non-nil.  So, when I say "set non-nil to x", set t to x (i.e. `(setq x t)`).

------------------------------------------------------------

## Installation of GAMS mode.

### Install from MELPA repository.

You can install GAMS mode (gams-mode.el) from MELPA repository.  Type M-x
list-packages and select gams-mode.

To use melpa, put the following code in your init.el file.

    (add-to-list 'package-archives
                 '("melpa" . "http://melpa.milkbox.net/packages/") t)
    (add-to-list 'package-archives
                 '("melpa-stable" . "http://stable.melpa.org/packages/") t)
                 
If you want to use a stable version, use GAMS mode in melpa-stable.  If
you want to use a developing version, use GAMS mode in melpa.
                 
Note that it installs only gams-mode.el file and does not install sample
files and explanatory files.  So to use GAMS mode, you had better read
GAMS mode web site first.  <https://github.com/ShiroTakeda/gams-mode/>

If the GAMS system folder is not included in PATH environemtal variable,
you need to set GAMS system folder to PATH or you need to set the full
path to gams.exe to the variable 'gams-process-command-name'. For example,
your gams.exe is placed at "c:/GAMS/win64/GAMS24.1/", then add the
following line to init.el:

    (setq gams-process-command-name "c:/GAMS/37/gams.exe")

In addition, you had better set 'gams-system-directory' like
   
    (setq gams-system-directory "c:/GAMS/37/")
    
If you want to color an Emacs buffer, add the followings, too.

    (require 'font-lock)
    (global-font-lock-mode t)

Basically, this is all you must set.  With these settings, when you open a
file with extension "gms" ("lst"), GAMS mode (GAMS-LST mode) will
automatically start.  Byte-compiling gams-mode.el may raise the speed of
GAMS mode (but you need not necessarily do it).

There is a sample setting file ("gams-setting-sample.el") distributed with
this file.  Please read it, too.

If you want to use GAMS-TEMPLATE mode, you had better copy the sample
template file "gams-template.txt" in "~/.emacs.d/".  This sample file
contains a lot of useful templates for writing gms files.

There are several lisp variables which decide the important behaviors of
GAMS and the GAMS mode.  So, please read the customization part below,
too.


### Install manually

To install gams-mode.el manually, you need to follow the procedure below
(1 and 2 are not necessary when you install gams-mode.el by MELPA).

1.  Put "gams-mode.el" file into one of the directories listed in
    `load-path`.  You can see the contents of `load-path` by entering `M-x
    customize-option <RET> load-path`.  Or add the directory where
    "gams-mode.el" is installed to `load-path` variable.  For this, add
    the following in your "~/.emacs.d/init.el" file:

        (setq load-path
             (cons "~/emacs.d/lisp/gams/" ;; Set the installed directory!
              load-path))

2. Add the following into your "~/.emacs.d/init.el" startup file (after
   load-path setting)

        (require 'gams-mode)

3. In addition, you had better set proper values to
   `gams-process-command-name` and `gams-system-directory`.


------------------------------------------------------------

# Basic Usage

To learn how to use the GAMS mode, it is best to read "gams-sample.gms"
file.  "gams-sample.gms" file enables you to acquire necessary skills in a
learning-by-doing way.

Here is the basic command listing.  Try each command by yourself!  You can
see basic keybindins also in refcard-gams.pdf.

## GAMS mode:
----------

Key-binding Command explanation

| Key           | Explanation                                         |
|:--------------|:----------------------------------------------------|
| `C-c C-k`     | Insert GAMS statement with completion.              |
| `C-c C-d`     | Insert GAMS dollar control option with completion.  |
| `C-c C-.`     | Show the identifier declaration part.               |
| `C-c C-a`     | Show the identifier list in the buffer.             |
| `C-c C-w`     | Open included file.                                 |
| `C-c C-v`     | Switch to the LST file and show errors if exist.    |
| `C-c C-j`     | Switch to the LST file.                             |
| `C-c C-t`     | Evoke process menu.                                 |
| `C-c C-s`     | Start GAMS                                          |
| `C-u C-c C-t` |  Edit command and start GAMS.                       |
| `C-c C-e`     | Insert templates (GAMS-TEMPLATE).                   |
| `C-c C-o`     | Insert user defined comment template.               |
| `C-l`         | Recenter.                                           |
| `C-c C-c`     | Insert an ontext-offtext pair.                      |
| `C-c C-g`     | Jump between ontext and offtext.                    |
| `C-c M-c`     | (Un)comment an ontext-offtext pair.                 |
| `C-c M-g`     | Remove an ontext-offtext pair.                      |
| `C-c C-m`     | View GAMS pdf manuals.                              |
| `C-c C-f`     | Change the level of font-lock (colorization)        |
| `C-c C-;`     | Insert inline comment.                              |
| `C-c M-;`     | Insert end-of-line comment.                         |
                                                                      
## GAMS-LST mode:
--------------

| Key       | Explanation                                                 |
|:----------|:------------------------------------------------------------|
| `y`       | Jump to the error and show its number and meaning.          |
| `u`       | Jump back to the error place in the program file.           |
| `i`       | Jump to the input (GMS) file.                               |
| `q`       | Close the buffer.                                           |
| `?`       | Help.                                                       |
| `o`       | Start the GAMS-OUTLINE mode.                                |

| Key       | Explanation                                                 |
|:----------|:------------------------------------------------------------|
| `s(S)`    | Jump to the next (previous) SOLVE SUMMARY.                  |
| `r(R)`    | Jump to the next (previous) REPORT SUMMARY.                 |
| `v(V)`    | Jump to the next (previous) VAR entry.                      |
| `e(E)`    | Jump to the next (previous) EQU entry.                      |
| `p(P)`    | Jump to the next (previous) PARAMETER entry.                |
| `L`       | Jump to a line you specify.                                 |
| `l`       | Jump to a line.                                             |

| Key       | Explanation                                                 |
|:----------|:------------------------------------------------------------|
| `SPACE`   | Scroll up.                                                  |
| `DELETE`  | Scroll down.                                                |
| `1`       | Wien the window.                                            |
| `2`       | Spit the window.                                            |
| `m`       | Moe frame.                                                  |
| `w`       | Reize frame.                                                |
| `z`       | Moe a cursor to the other window.                           |

d,f,g,h,j,k Keys for scrollings (see the help in GAMS-LST mode).

For details, please see the help in both modes.

If you want to know how to use GAMS-TEMPLATE, please see the help in
GAMS-TEMPLATE mode, (start GAMS-TEMPLATE mode (C-cC-e) and push ? in the
*Template List* buffer).

If you want to use GAMS-OUTLINE mode, you had better see the sample GAMS
file "outline-sample.gms".  Try to run GAMS on that file.  And if you want
to know commands in GAMS-OUTLINE mode, please see the help in the
GAMS-OUTLINE mode, (start GAMS-OUTLINE mode [type o in the LST mode] and
push ? in the OUTLINE buffer).

------------------------------------------------------------

# Customization

You can custumize the behavior of Emacs and GAMS mode by changing the
values of the following variables.  Default value is given in []

You can change the value of these variables by adding in your
"~/.emacs.d/init.el", for example,

    (setq gams-process-command-name "c:/GAMS/37/gams.exe")
    (setq gams-statement-upcase nil)

Or you can use `customize` built in Emacs.  Try M-x customize-groups
[ENTER] gams [ENTER.]

Please read the sample file "gams-setting-sample.el", too.

## Basic customizable variables in GAMS and GAMS-LST mode:

`gams-process-command-name` ["gams"]

"*GAMS program file name.  If you do not include the GAMS system
directory in PATH environmental variable, you must set the full
path to GAMS program in this variable like c:/GAMS20.0/gams.exe."


`gams-process-command-option` ["ll=0 lo=3 pw=100 ps=9999"]

"*Command line options passed to GAMS"


`gams-statement-file` ["~/.emacs.d/gams-statement.txt"]

"*The name of the file in which user specific statements are
stored."


`gams-fill-column` [80]

"*The column number used for fill-paragraph and auto-fill-mode."
    

`gams-recenter-font-lock` [t]

"Non-nil means that font-lock-fontify buffer when recentering.  If
your computer is slow, you may better set this to nil."


`gams-file-extension` ['("gms")]

"*List of gams program file extensions. If you open a file with an
extension included in this list, GAMS mode starts automatically.
It doen't matter whether upper case or lower case."
    

`gams-mode-hook ` [nil]

"*Hook run when gams-mode starts."


`gams-mode-load-hook` [nil]

"*List of functions to be called when gams-mode.el is loaded."


`gams-close-paren-always` [t]

"*Non-nil means that close parenthesis."


`gams-user-comment`

"*User defined comment template. You can insert the comment template
defined in this variable by executing `gams-insert-comment`.  % in the
string indicates the cursor place and will disappear after template
insertion. NB: You cannot include double quoatations and backslashes in
this variables!"


`gams-system-directory` ["c:/GAMS/win64/24.7/"]

"The GAMS system directory."


`gams-inlinecom-symbol-start-default` ["/*"]

"The default value for inline comment start symbol."


`gams-inlinecom-symbol-end-default` ["*/"]

"The default value for inline comment end symbol."


`gams-eolcom-symbol-default` ["#"]

"The default value for eol comment symbol."
    

## GAMS-TEMPLATE mode:

`gams-template-file` ["~/.emacs.d/gams-template.txt"]

"*The name of a file used to store templates."
  

`gams-save-template-change` [nil]

"Nil means that save the content of `gams-user-template-alist` into
`gams-template-file` only when you quit Emacs.  If non-nil, save
`gams-user-template-alist` every time you made changes.  If your Emacs
often crashes, you may had better set it to non-nil."


## GAMS-OUTLINE mode:

`gams-ol-height` [15]

"*The height of the GAMS-OUTLINE buffer with one LST buffer."


`gams-ol-height-two` [8]

"*The height of the GAMS-OUTLINE buffer with two LST buffers."


There are also other customizable variables, mainly keybindings and fonts.
You can see a full list of customizable variables by executing:

    M-x customize-groups [ENTER]
    gams [ENTER]

    
------------------------------------------------------------

# TODO:

See TODO file.


------------------------------------------------------------

# Miscellaneous

Bug reports, requests and suggestions are welcome!  Write an email to me.
Shiro Takeda <shiro.takeda@gmail.com>

    
------------------------------------------------------------

# Acknowledgments

To write the package GAMS mode, I have used a lot of excellent emacs lisp
codes written by other people.  They include "YaTeX" (Yet Another LaTeX
mode), EPO (Editing Process Organizer), "RefTeX mode", `c-sig.el`,
`font-latex.el`, `lisp-mode.el`, and `indent.el` etc.  In particular, I
would like to express acknowledgments to Yuuji Hirose who is the author of
YaTeX and EPO packages (they are available at
<http://www.gentei.org/~yuuji/software>).  He also have written other lots
of cool lisp programs.  You will be happy if you visit to his web site :-)


<!--

--------------------
Local Variables:
fill-column: 74
mode: markdown
End:

-->
