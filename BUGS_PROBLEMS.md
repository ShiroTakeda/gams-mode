<!--
Author: Shiro Takeda
Maintainer: Shiro Takeda
Time-stamp: <2017-07-31 10:36:48 st>
-->

Known bugs and problems of GAMS mode.
============================================================

Note: When you open this file in Emacs, this buffer must be in Org-mode. To
unfold items, push TAB key (or Shift + TAB).

## The old version Emacs

I only test gams-mode.el in Emacs 25 and gams-mode.el is likely not to work
well in the old version of Emacs.


## Viewing documents

`gams-view-docs` does not work in the old versions of GAMS which has
different folder structure to the current GAMS.


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
code in your ".emacs.el":

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

  
## Troubles in coloring

First of all, there could be a lot of bugs in the coloring function of the
GAMS mode. If you find abormal behaviors, please report them.
  
To color the buffer of gms files, GAMS mode uses font-lock function which is
the built-in function of Emacs. GAMS mode gives the information of coloring
pattern to the font-lock and then the font-lock colors the buffer according
to the coloring information.

### Coloring for expressions that span multiple lines

Coloring function in Emacs (font-lock function) is not basically designed
for coloring expressions that span multiple lines. It does not mean that
font-lock cannot color expressions across multiple lines, but it requires
quite complicated programming. For the details,

http://www.gnu.org/software/emacs/elisp/html_node/Multiline-Font-Lock.html#Multiline-Font-Lock

This applies to, for example, comment texts in $ontext-$offtext pair.
Because of this limitation, automatic recoloring for texts in
$ontext-$offtext does not work.

To cover this shortcoming, gams-mode.el provides the command `gams-recenter`
which is binded to `C-l`. When the variable `gams-recenter-font-lock` is
assigned non-nil like

    (setq gams-recenter-font-lock t)

typing `C-l` recenters the line and recolors the block around the cursor.
If you edit $ontext-$offtext command and coloring of texts fails, please
recolor the buffer manually by `C-l`.


### Setting for font-lock support mode

In the default setting (in recent Emacs), `jit-lock-mode` is set to the
value of `font-lock-support-mode`. `jit-lock-mode` usually speeds up
coloring speed in Emacs but it often causes troubles in GAMS mode.

You have two choices for this:

1. Make font-lock-support-mode off in GAMS mode.

   One choice is to quit using font-lock support mode. By this setting, it
   is likey to take more time for opening large gms files but you will
   encounter much less troubles. To make font-lock support mode off in GAMS
   mode, put the following setting in your "init.el".

        (setq font-lock-support-mode
            '((gams-mode . nil) (t . jit-lock-mode)))

2. Use `jit-lock-mode` with a sufficiently large value of
   `jit-lock-chunk-size`.

   When you use `jit-lock-mode`, the coloring ofen fails, in particular,
   coloring over multiple lines. However, setting sufficiently large value
   to the variable `jit-lock-chunk-size` may resolve this problem. So add
   the following setting in your "init.el".

        (setq jit-lock-chunk-size 50000)

   But note that the large value of `jit-lock-chunk-size` often causes Emacs
   to hang up.



<!--
--------------------
Local Variables:
mode: markdown
fill-column: 76
coding: utf-8-dos
End:
-->
