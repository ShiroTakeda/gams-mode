<!--
Author: Shiro Takeda
Maintainer: Shiro Takeda
-->

Known bugs and problems of GAMS mode.
============================================================

## Older Versions of Emacs 

I have only tested `gams-mode.el` in Emacs 29. Therefore, `gams-mode.el` is likely to not work well in older versions of Emacs.


## Viewing documents

The `gams-view-document` command (C-c C-m) does not work in older versions of GAMS that have a different folder structure compared to the current GAMS.


## Ending GAMS Statement Blocks with Semicolons

Automatic indentation and syntax highlighting often fail when GAMS statement blocks do not end with a semicolon (;). Although GAMS syntax does not necessarily require a semicolon (it is often optional), please end statement blocks with a semicolon.


## Keep GAMS Declaration Blocks Small

You might often include many elements in one declaration block. For example, you may declare dozens of sets in one `set` statement. However, such large declaration blocks often make GAMS mode extremely slow because it requires a lot of time to color the buffer. Therefore, it is better to divide large declaration blocks into several smaller blocks.


## TAB key

Emacs comes with various major modes such as C mode, Perl mode, Fortran mode, Java mode, LaTeX mode, etc. In these major modes, the TAB key is conventionally bound not to insert the TAB character itself but to another function, namely, indentation. GAMS mode follows this convention. Therefore, in GAMS mode, the TAB key is used to indent the current line and not to insert a TAB character.

If you want to use the TAB key to insert a TAB character, add the following code to your `init.el`:

```emacs-lisp
;; Bind indent-line to F2.
(define-key gams-mode-map [f2] 'gams-indent-line)
;; Bind inserting TAB character to TAB key.
(define-key gams-mode-map "\t" 'gams-insert-tab)
```

With this code, the TAB key will be bound to insert a TAB character, and the F2 key will be bound to indentation.

## File name

In GAMS mode, file names with spaces and characters other than alphabets and numbers often cause problems (e.g., a file name like "test (example 1).gms"). To avoid issues, it is better to use file names containing only alphabets and numbers.



<!--
--------------------
Local Variables:
mode: markdown
fill-column: 76
coding: utf-8-dos
End:
-->
