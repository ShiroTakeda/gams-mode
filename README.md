<!--
Author: Shiro Takeda
Maintainer: Shiro Takeda
-->

# GAMS-mode

[![MELPA](https://melpa.org/packages/gams-mode-badge.svg)](https://melpa.org/#/gams-mode)

This package offers the Emacs lisp program for using the numerical software GAMS in Emacs (GAMS mode for Emacs).

If you want to know how to install GAMS mode, read [Installation](#installation) below. If you want to know the latest changes added to GAMS mode, see [CHANGELOG.md](CHANGELOG.md) file.

## Table of contents

1. [Introduction (brief overview)](#introduction-brief-overview)
2. [Screenshots](#screenshots)
3. [Installation](#installation)
4. [Installing GAMS from Emacs](#installing-gams-from-emacs)
5. [Basic Usage](#basic-usage)
6. [Customization](#customization)
7. [YAML and Python code blocks font-locking](#yaml-and-python-code-blocks-font-locking)
8. [Miscellaneous](#miscellaneous)
9. [Acknowledgments](#acknowledgments)

## Introduction (brief overview)

### Introduction of GAMS mode for Emacs

GAMS mode for Emacs offers an integrated and flexible environment for using GAMS within Emacs.

This section presents a brief overview of what GAMS mode for Emacs is. Please read the section "Installation"' below for information about how to install GAMS mode. If you are upgrading from the previous version of GAMS mode, you can find the latest changes in [CHANGELOG.md](CHANGELOG.md) file.

You can obtain the latest version of this program from the website [GAMS mode for Emacs (https://github.com/ShiroTakeda/gams-mode/)](https://github.com/ShiroTakeda/gams-mode/).

When using GAMS, you need to perform the following tasks:

1. Edit GAMS program files
2. Call GAMS to execute the program
3. Read the output file
4. Debug the program
5. Examine the numerical values in the output file

And more...

GAMS mode for Emacs offers various features that increase your efficiency in all these tasks.

GAMS mode for Emacs includes five major modes (I will skip the explanation of the Emacs terminology "major mode." If you are not familiar with this term, I recommend reading the introductory documentation for Emacs first):


| Mode                  | Explanation                                   |
|:----------------------|:----------------------------------------------|
| GAMS mode:            | Editing GAMS program files.                   |
| GAMS-LST mode:        | Viewing LST files.                            |
| GAMS-SIL mode:        | Viewing GAMS program structure.               |
| GAMS-TEMPLATE mode:   | Handling templates of programs.               |
| GAMS-OUTLINE mode:    | Viewing important items of LST files.         |

Furthermore, the following features are included in each major mode.

### GAMS mode

This is the major mode for editing GAMS program files.

1. Inserting GAMS statements and dollar control options.
2. Automatic registration of new statements and dollar control options.
3. Calling GAMS from Emacs.
4. Syntax highlighting.
5. Handling templates of various programs (this is GAMS-TEMPLATE mode).
6. Automatic indentation.
7. Viewing GAMS program structure (GAMS-SIL mode).
8. Reading GAMS manual.
9. Extracting models from the GAMS model library.

I will explain each function in detail:

By registering GAMS statements and dollar control options beforehand, (1) enables you to insert them into the program file easily. You can insert long statements and dollar control options (that you are likely to mistype) without typing them yourself.

Although there are many GAMS statements and dollar control options, only a subset is registered by default in GAMS mode. This is because frequently used statements differ among users, and it is desirable to exclude rarely used statements from the input function candidates of (1). However, (2) enables you to register new statements and dollar control options. You can easily add the commands you frequently use to the candidate list for the command insertion function of (1).

(3) is the function to call GAMS directly from Emacs to execute the GMS file.

Like GAMS Studio (or GAMSIDE), (4) provides the colorization of GAMS program files according to GAMS syntax.

When editing GAMS program files, you may often use similar patterns frequently. In such cases, you may copy and paste the program repeatedly. However, it is undoubtedly more convenient if you can register frequently used patterns and select them. Or, although the pattern is not frequently used, it may be hard to remember. Also in that case, it seems convenient if you can use registered patterns. (5) offers you the feature for registering various patterns easily. In addition to registering, you can modify, delete, rename, and reorder existing templates easily.

Many people agree with the opinion that proper indentation is important for writing programs that others (or yourself) can read easily. However, it is quite tedious to insert spaces and TABs manually yourself. In GAMS mode, each line is automatically indented according to GAMS syntax (6).

When writing a GAMS program, we define many (sometimes hundreds of) variables, equations, sets, and parameters, and it is difficult to remember which identifier represents what. Feature (7) enables you to show the list of all identifiers defined in a program, allowing you to see the structure of the program.

Additionally, you can call a manual viewer from Emacs (8) to read GAMS manuals and view the GAMS model library in Emacs (9).

### GAMS-LST mode

This is the major mode for viewing the output file (i.e., LST file).

1. Display the error location and its meaning.
2. Jump to the error location in the program file.
3. Jump to various places in the LST file.
4. Color the content of the LST file.
5. Display important items of the LST file (this is GAMS-OUTLINE mode).

When editing GAMS programs, one of the most important tasks is debugging. Your efficiency in writing programs crucially depends on the efficiency of debugging. (1) and (2) are functions for that.

With (1) and (2), you can quickly perform the following tasks with simple key operations:

- Call GAMS and execute the program.
- Move to the LST file.
- Examine the location and meaning of errors.
- Go back to the error location in the program.

You can do similar tasks in GAMS Studio (GAMSIDE), but I believe GAMS mode offers a more convenient environment.

LST files often become quite large. In such cases, it is hard to search for the output you want to see. (3) provides you with the feature to move to various important items (such as PARAMETER, SET, VAR, EQU) in the LST file with simple key operations.

Function (4) colors the content of LST files.

As pointed out above, the LST file is often very large, and it is often very difficult to find the numerical values you want to see. It is also difficult to compare the numerical values in two different parts of the LST file. Although you may resolve these problems by defining parameters that display only relevant values, it is more convenient if you can examine the content of the LST file in a simple way.

(5) provides a way for that. With this feature, you can easily view the important elements (PARAMETER, VAR, EQU, etc.) in LST files.

You can see where the particular PARAMETER or VAR is and view its content. You can also compare the numerical values in one part of the file with those in another part. You can understand what this function is like by looking at the screenshots on  [the screenshots
page](https://photos.app.goo.gl/XS62pfooFUEs8Fty5).

These are the basic explanations of this program. Of course, there are many other functions!

Bug reports, requests, and suggestions are all welcome!

## Screenshots

See [screenshots page](https://photos.app.goo.gl/XS62pfooFUEs8Fty5).

## Installation

First, I explain the files distributed in the package.

| Filename                                             | Explanation                                                                                                              |
| :--------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| `README.md`                                          | This file. Please read this first.                                                                                       |
| [`gams-mode.el`](gams-mode.el)                       | The main Lisp program.                                                                                                   |
| [`gams-install.el`](gams-install.el)                 | Lisp program for installing GAMS directly from Emacs.                                                                    |
| [`sample_gams_code`](sample_gams_code)               | This folder includes sample GMS files. To learn how to use GAMS mode, read the `gams-sample.gms` file in this folder.    |
| [`gams-setting-sample.el`](gams-setting-sample.el)   | Sample settings file for `init.el`.                                                                                      |
| [`gams-template.txt`](gams-template.txt)                                  | Sample templates file.                                                                                                   |
| [`CHANGELOG.md`](CHANGELOG.md)                       | Change log file recording the history of changes. To know about changes and newly added functions, please read it.       |
| [`BUGS_PROBLEMS.md`](BUGS_PROBLEMS.md)               | Known bugs and problems.                                                                                                 |
| [`doc`](doc)                                         | Document folder including the reference card.                                                                            |
| [`lxi`](lxi)                                                | This folder includes files used to explain GAMS-LXI mode.                                                                |

If you are well acquainted with Emacs, installation is straightforward. Here, I explain the basic Emacs terminologies used below.  But if you are a novice user of Emacs, I recommend you to read the website [Emacs FAQ for Windows](http://www.gnu.org/software/emacs/manual/html_node/efaq-w32/index.html).


`"~/"`

This is Unix terminology rather than Emacs'. It represents a user's HOME directory, where configuration files are placed. In MS Windows, the default HOME directory is set to `C:\Users\username\AppData\Roaming`. To find your home directory, evaluate `(getenv "HOME")` in the *scratch* buffer on Emacs. You can set your HOME directory using the environment variable HOME.


`"~/.emacs.d/init.el"` or `"init.el"`

This is the configuration file that Emacs reads first when it starts. You can change Emacs' behavior by writing various settings in this file. Note that you must create this file yourself, as no "init.el" file exists by default (unless an administrator has created it for you).

`non-nil`

In Emacs terminology, non-nil means anything other than nil, including values such as 0, "a", or t. However, we usually use the symbol `t` as non-nil. So, when I say "set non-nil to x," set `t` to `x` (i.e., `(setopt x t)`).

### Installation of GAMS mode

#### Install from MELPA repository

You can install GAMS mode (`gams-mode.el`) from the MELPA repository. Type `M-x list-packages` and select gams-mode.

To use MELPA, add the following code to your `init.el` file:

```emacs-lisp
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
```

If you want to use a stable version, use GAMS mode from melpa-stable. If you want to use a developing version, use GAMS mode from melpa.

Note that it installs only the `gams-mode.el` file and does not install sample files or explanatory files. To use GAMS mode, you should first read the [GAMS mode website](https://github.com/ShiroTakeda/gams-mode/).

If the GAMS system folder is not included in the PATH environment variable, you need to set the GAMS system folder to PATH or set the full path to `gams.exe` in the variable `gams-process-command-name`. For example, if your `gams.exe` is located at `C:/GAMS/42/`, add the following line to `init.el`:

```emacs-lisp
(setopt gams-process-command-name "c:/GAMS/42/gams.exe")
```

These settings are generally sufficient. With them, when you open a file with the extension "gms" ("lst"), GAMS mode (GAMS-LST mode) will start automatically.

A sample settings file (`gams-setting-sample.el`) is distributed with this package. Please read it as well.

If you want to use GAMS-TEMPLATE mode, copy the sample template file `gams-template.txt` to `~/.emacs.d/`. This sample file contains many useful templates for writing GMS files.

There are several Lisp variables that determine the important behaviors of GAMS and GAMS mode. Please read the customization section below.

#### Manual Installation

To install `gams-mode.el` manually, follow the procedure below (steps 1 and 2 are not necessary when installing `gams-mode.el` from MELPA).

1. Place the `gams-mode.el` file in one of the directories listed in `load-path`. You can see the contents of `load-path` by entering `M-x customize-option <RET> load-path`. Alternatively, add the directory where `gams-mode.el` is installed to the `load-path` variable. Add the following to your `~/.emacs.d/init.el` file:

    ```emacs-lisp
    (setq load-path
          (cons "~/emacs.d/lisp/gams/" ;; Set the installed directory!
                load-path))
    ```

2. Add the following to your `~/.emacs.d/init.el` startup file (after setting `load-path`):

    ```emacs-lisp
    (require 'gams-mode)
    ```

Additionally, set proper values for `gams-process-command-name` and `gams-system-directory`.

## Installing GAMS from Emacs

GAMS mode can install GAMS directly from Emacs. This functionality is provided by the `gams-install.el` package. The installation requires admin rights under macOS and Linux, but not under Windows. After the installation, it is the user's responsibility to add GAMS folder to the PATH. GAMS installation folder is displayed at the end of the installation, at the bottom of the `*GAMS Installation*` buffer.

### Installation commands

- `M-x gams-install` - Install the latest version of GAMS
- `C-u M-x gams-install` - Prompt for a specific GAMS version to install
- `M-x gams-install-check-installation` - Check if GAMS is already installed and display the version

### Customization option

- `gams-install-directory` - Specify a custom installation directory for GAMS on Linux

## Configuration

In order to configure GAMS mode and other packages in your `init.el`, you may want to take advantage of `use-package`. Here is an example configuration:

``` emacs-lisp
(use-package gams-mode
  :ensure t
  :defer t ;; It is usually not necessary to load GAMS mode at startup. Better to defer loading
  :mode ("\\.inc\\'" . gams-mode) ;; To also associate *.inc files to GAMS mode
  :custom
  (gams-process-command-name "c:/GAMS/48/gams.exe") ;; Necessary if gams executable is not in the PATH
  (gams-fill-column 90)
  (gams-browse-url-function 'xwidget-webkit-browse-url) ;; To view GAMS manual in Emacs if xwidget is enabled in Emacs
  ;; Indent
  (gams-indent-number 2)
  (gams-indent-number-loop 2)
  (gams-indent-number-mpsge 2)
  (gams-indent-number-equation 2))
```

Font-locking for GAMS files faces the challenge that some GAMS commands may span several pages (e.g., `$on/offtext` comments) and may exceed Emacs' default size for font-locking, which is governed by the `jit-lock-chunk-size` variable. It is advisable to increase the value of this variable above its default of 1500. Larger values may slow down Emacs, but this is less of a concern these days with modern computers. Below is an example configuration:

``` emacs-lisp
(setopt jit-log-chunk-size 5000)
```

## Basic Usage

To learn how to use GAMS mode, it is best to read the `gams-sample.gms` file. The `gams-sample.gms` file enables you to acquire necessary skills in a learning-by-doing manner.

Here is the basic command listing. Try each command by yourself! You can also see the basic keybindings in `refcard-gams.pdf`.

### Auto-completion

GAMS mode provides in-buffer completion through standard Emacs completion-at-point-functions (CAPF). All GAMS commands (statements, dollar control options, etc.) are provided through CAPF (mapped by default in Emacs to `C-M-i`).

Another Emacs completion feature useful with GAMS mode is [Dynamic Abbrev expansion](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dynamic-Abbrevs.html), which automatically expands a word in the buffer based on the buffer content (mapped by default to `M-/`). This function is useful for expanding symbols at the point. For example, if the buffer contains `eq_mkt_clearing` and you type `eq_mk M-/`, Emacs inserts `eq_mkt_clearing`.

For users of the [auto-complete package](https://github.com/auto-complete/auto-complete) for auto-completion (an obsolete package that is no longer maintained), it is possible to use [gams-ac](https://github.com/ShiroTakeda/gams-ac) for auto-completion in GAMS mode.

For users of the [company package](http://company-mode.github.io/) for auto-completion, GAMS mode defines the following backends: `(company-files company-yasnippet company-dabbrev-code company-capf :separate)`. These backends provide auto-completion for file names, snippets, dynamic abbreviations, and CAPF. It is possible to customize the backends with the variable `gams-company-backends`.

### Key bindings

Here are essential key bindings. For details, please see the help in both modes.

#### GAMS mode

| Key binding    | Command Explanation                                              |
|:---------------|:-----------------------------------------------------------------|
| `C-c C-k`      | Insert GAMS statement with completion.                           |
| `C-c C-d`      | Insert GAMS dollar control option with completion.               |
| `C-c C-.`      | Show the identifier declaration part.                            |
| `C-c C-a`      | Show the identifier list in the buffer.                          |
| `C-c C-w`      | Open included file.                                              |
| `C-c C-v`      | Switch to the LST file and show errors if they exist.            |
| `C-c C-j`      | Switch to the LST file.                                          |
| `C-c C-t`      | Evoke process menu.                                              |
| `C-c C-s`      | Start GAMS.                                                      |
| `C-u C-c C-t`  | Edit command and start GAMS.                                     |
| `C-c C-e`      | Insert templates (GAMS-TEMPLATE).                                |
| `C-c C-o`      | Insert user-defined comment template.                            |
| `C-l`          | Recenter.                                                        |
| `C-c C-c`      | Insert an ontext-offtext pair.                                   |
| `C-c C-g`      | Jump between ontext and offtext.                                 |
| `C-c M-c`      | (Un)comment an ontext-offtext pair.                              |
| `C-c M-g`      | Remove an ontext-offtext pair.                                   |
| `C-c C-m`      | View GAMS manuals.                                               |
| `C-c C-f`      | Change the level of font-lock (colorization).                    |
| `C-c C-;`      | Insert inline comment.                                           |
| `C-c M-;`      | Insert end-of-line comment.                                      |
| `C-c C-x`      | Open a GDX file with GAMS Studio (same name file or from prompt. |

#### GAMS-LST mode

| Key binding    | Command explanation                                              |
|:---------------|:-----------------------------------------------------------------|
| `y`            | Jump to the error and show its number and meaning.               |
| `u`            | Jump back to the error place in the program file.                |
| `i`            | Jump to the input (GMS) file.                                    |
| `q`            | Close the buffer.                                                |
| `?`            | Help.                                                            |
| `o`            | Start GAMS-OUTLINE mode.                                         |
| `s(S)`         | Jump to the next (previous) SOLVE SUMMARY.                       |
| `r(R)`         | Jump to the next (previous) REPORT SUMMARY.                      |
| `v(V)`         | Jump to the next (previous) VAR entry.                           |
| `e(E)`         | Jump to the next (previous) EQU entry.                           |
| `p(P)`         | Jump to the next (previous) PARAMETER entry.                     |
| `L`            | Jump to a line you specify.                                      |
| `l`            | Jump to a line.                                                  |
| `SPACE`        | Scroll up.                                                       |
| `DELETE`       | Scroll down.                                                     |
| `1`            | Widen the window.                                                |
| `2`            | Spit the window.                                                 |
| `m`            | Move frame.                                                      |
| `w`            | Resize frame.                                                    |
| `z`            | Move a cursor to the other window.                               |
| `d,f,g,h,j,k`  | Keys for scrolling (see the help in GAMS-LST mode).              |
| `C-c C-x`      | Open a GDX file with GAMS Studio (same name file or from prompt. |

### GAMS template

If you want to know how to use GAMS-TEMPLATE, please see the help in GAMS-TEMPLATE mode. Start GAMS-TEMPLATE mode (`C-c C-e`) and press `?` in the Template List buffer.

### GAMS-OUTLINE mode

If you want to use GAMS-OUTLINE mode, it is best to see the sample GAMS file `outline-sample.gms`. Try running GAMS on that file. To know the commands in GAMS-OUTLINE mode, please see the help in GAMS-OUTLINE mode. Start GAMS-OUTLINE mode (type `o` in LST mode) and press `?` in the OUTLINE buffer.

## Customization

You can customize the behavior of Emacs and GAMS mode by changing the values of the following variables. The default values are given in brackets [ ].

You can change the value of these variables by adding the following lines to your `~/.emacs.d/init.el` file. For example:

```emacs-lisp
(setopt gams-process-command-name "c:/GAMS/37/gams.exe")
(setopt gams-statement-upcase nil)
```

Or you can use the built-in Emacs customization interface. Try `M-x customize-group [ENTER] gams [ENTER]`.

Please also read the sample file `gams-setting-sample.el`.

### Basic Customizable Variables in GAMS and GAMS-LST Mode:

- `gams-process-command-name` ["gams"]
  - GAMS program file name. If the GAMS system directory is not included in the PATH environment variable, you must set the full path to the GAMS program in this variable, like `c:/GAMS/42/gams.exe`.

- `gams-process-command-option` ["ll=0 lo=3 pw=100 ps=9999"]
  - Command line options passed to GAMS.

- `gams-statement-file` ["~/.emacs.d/gams-statement.txt"]
  - The name of the file in which user-specific statements are stored.

- `gams-fill-column` [80]
  - The column number used for `fill-paragraph` and `auto-fill-mode`.

- `gams-recenter-font-lock` [t]
  - Non-nil means that the buffer will be fontified when recentering. If your computer is slow, you may want to set this to nil.

- `gams-mode-hook` [nil]
  - Hook run when GAMS mode starts.

- `gams-mode-load-hook` [nil]
  - List of functions to be called when `gams-mode.el` is loaded.

- `gams-close-paren-always` [t]
  - Non-nil means that closing parentheses will always be inserted.

- `gams-user-comment`
  - User-defined comment template. You can insert the comment template defined in this variable by executing `gams-insert-comment`. `%` in the string indicates the cursor place and will disappear after template insertion. Note: You cannot include double quotations and backslashes in this variable!

- `gams-system-directory` [default to base directory of gams executable]
  - The GAMS system directory.

- `gams-inlinecom-symbol-start-default` ["/*"]
  - The default value for the inline comment start symbol.

- `gams-inlinecom-symbol-end-default` ["*/"]
  - The default value for the inline comment end symbol.

- `gams-eolcom-symbol-default` ["#"]
  - The default value for the end-of-line comment symbol.

- `gams-browse-url-function`  ["browse-url"]
  - The default function to browse GAMS documentation. On Emacs version that support `xwidget`, setting this to `xwidget-webkit-browse-url` allows to browse GAMS documentation inside Emacs with perfect rendering.

### GAMS-TEMPLATE Mode:

- `gams-template-file` ["~/.emacs.d/gams-template.txt"]
  - The name of the file used to store templates.

- `gams-save-template-change` [nil]
  - Nil means that the content of `gams-user-template-alist` will be saved into `gams-template-file` only when you quit Emacs. If non-nil, `gams-user-template-alist` is saved every time you make changes. If your Emacs often crashes, you may want to set this to non-nil.

### GAMS-OUTLINE Mode:

- `gams-ol-height` [15]
  - The height of the GAMS-OUTLINE buffer with one LST buffer.

- `gams-ol-height-two` [8]
  - The height of the GAMS-OUTLINE buffer with two LST buffers.

There are also other customizable variables, mainly keybindings and fonts. You can see a full list of customizable variables by executing:

```
M-x customize-group [ENTER]
gams [ENTER]
```

## YAML and Python code blocks font-locking

[GAMS Connect](https://www.gams.com/latest/docs/UG_GAMSCONNECT.html) extends GAMS language with YAML and Python code blocks. To enable font-locking for these code blocks, please install [`poly-gams`](https://github.com/ShiroTakeda/poly-gams/tree/main), a [`polymode`](https://polymode.github.io/) for GAMS mode.

## Miscellaneous

Bug reports, requests, and suggestions are welcome! Please write an email to me: Shiro Takeda at <shiro.takeda@gmail.com>.

## Acknowledgments

To write the GAMS mode package, I have used a lot of excellent Emacs Lisp code written by other people. These include "YaTeX" (Yet Another LaTeX mode), EPO (Editing Process Organizer), "RefTeX mode", c-sig.el, font-latex.el, lisp-mode.el, and indent.el, among others. In particular, I would like to express my acknowledgments to Yuuji Hirose, the author of the YaTeX and EPO packages (available at <http://www.gentei.org/~yuuji/software>). He has also written many other cool Lisp programs. You will be happy if you visit his website :-)


<!--

--------------------
Local Variables:
fill-column: 74
mode: markdown
End:

-->
