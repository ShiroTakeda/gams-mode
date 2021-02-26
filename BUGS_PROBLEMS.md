<!--
Author: Shiro Takeda
Maintainer: Shiro Takeda
-->

Known bugs and problems of GAMS mode.
============================================================

## The old version Emacs

I only test gams-mode.el in Emacs 27 and gams-mode.el is likely not to work
well in the old version of Emacs.


## Viewing documents

`gams-view-document` (C-cC-m) does not work in the old versions of GAMS
which has different folder structure to the current GAMS.


## End gams statement block with `;`

Automatic indent and coloring often fail when gams statement blocks do not
end with character `;` (semicolon). Although gams syntax does not
necessarily require `;` (`;` is often omissible), please end statement
blocks with `;`.


## Make each gams declaration (definition) block small

You may often include many elements into one declaration block. For example,
you may declare dozens of sets in one `set` statement. But, such large
declaration block often makes GAMS mode extremely slow because it requires a
lot of time to color the buffer. So, you had better divide a large
declaration block into several small blocks.


## TAB key

Emacs comes with various major modes such as C mode, Perl mode, Fortran
mode, Java mode, LaTeX mode etc. In these major modes, TAB key is
conventionally binded not to inserting TAB character itself but to the
another function, namely, indentation function. GAMS mode follows this
convention of major modes. So, in GAMS mode, TAB key is used to make
indentation of the current line and not used to insert TAB character.

But if you want to use TAB key to insert TAB character, put the following
code in your "init.el":

    ;; Bind indent-line to F2.
    (define-key gams-mode-map [f2] 'gams-indent-line)
    ;; Bind inserting TAB character to TAB key.
    (define-key gams-mode-map "\t" 'gams-insert-tab)

By this code, TAB key is binded to inserting TAB character and F2 key is
binded to the indentation.


## File name

In GAMS mode, file names with spaces and characters other than alphabet and
number often cause troubles (e.g. file name like "test (example 1).gms").
To avoid troubles, you had better use file name only with alphabet and
number.

  

<!--
--------------------
Local Variables:
mode: markdown
fill-column: 76
coding: utf-8-dos
End:
-->
