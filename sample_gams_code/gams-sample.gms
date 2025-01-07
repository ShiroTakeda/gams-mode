$title A sample file for learning how to use GAMS mode for Emacs.
$ontext
Filename:       "gams-sample.gms"
Author:         Shiro Takeda
First-written:  <2001/08/13>

_TODO_:

$offtext

*       ----------------------------------------------------------------------
$stitle         Specification of lst file or lst file directory (sample code):
*       ----------------------------------------------------------------------
$ontext
To activiate lst file specification, remove one of two asterisks at the
beginning of the line.
$offtext

** gams-lst-file: ./lst/lst-sample.lst
*       The above code means that lst file -> ./lst/lst-sample.lst:

** gams-lst-file: g:/lst-sample.lst
*       The above code means that lst file -> g:/lst-sample.lst:

** gams-lst-dir: ./lst/
*       The above code means that lst file -> ./lst/gams-sample.lst

** gams-lst-dir: g:/
*       The above code means that lst file -> g:/gams-sample.lst

$ontext

Commentary:

  * For gams-mode.el version 6.12.

  * Notations like "C-cC-v" follow the Emacs convention. For example,

    `C-cC-v' ->  Type "Control key + c" and then type "Control + v" key.
    `M-q'    ->  Type "Meta (or Alt) key + q".

  * You can see the explanation of variables and commands by M-x
    describe-variable and M-x describe-function respectively.

  * Bug reports, requests, and suggestions are all welcome!  If you find bugs,
    please use M-x gams-report-bug.

$offtext

*       Inline comment symbol
$inlinecom /* */

*       End-of-line comment symbol
$eolcom #

*       The name of the included program file.
$setglobal sub_program ./include/include-sample.gms

$ontext
If your setting is proper, this buffer must be in GAMS mode (if the mode line
contains the string "GAMS", you are in GAMS mode).  If you are not in GAMS mode,
please check your configuration in "~/.emacs.d/init.el" (in particular,
load-path setting).

$offtext
*        ----------------------------------------------------------------------
$stitle         Basic usage.
*        ----------------------------------------------------------------------
$ontext

First, try to run GAMS on this file.  Type `C-cC-t', then you see the following
message in the echo area (mini-buffer).


    Start GAMS (s), Kill GAMS process (k), Change GAMS command (c), Change options (o).


Type `s', and GAMS will start.  Or if you type F9 key or `C-cC-s', GAMS will
directly start.

[Note] if GAMS does not start or does not work well, there are likely to be some
problems in configurations. Please check the following:

  + Does a shell (such as cmdproxy or bash) work properly in your Emacs?

  + Check the setting of the variable `gams-process-command-name'. If you do not
    include the GAMS system directory in the environmental variable PATH, you
    must set the full path to GAMS to `gams-process-command-name'.


When the GAMS process finishes, type `C-cC-v' or F10 key to switch to the LST
file buffer.

In the LST buffer, you will see a message "No error message is found" in the
echo are.  This message means that this gms file was executed successfully
without any error.

Type `i' (or `b') to jump back to the gms file buffer.

Next, uncomment the following line (delete * before "Uncommen this ..." line)
and run GAMS (type `C-cC-t' and type `s').

$offtext
*              Uncomment this line.  Error is here.
$ontext

Then, you will see the following message in the echo are

    GAMS ended with 'Compilation' errors!  C-cC-v or [F10]= LST file.

Switch to the LST buffer (C-cC-v or f10) and you will see two windows and the
following message in the echo are.

    LastMod 2021/02/24 10:37:40: [u]=Jump to the error place, [i]=Jump to the main input file

and you see the following message in the LST buffer

     105                Uncomment this line.  Error is here.
    ****                        $140 $36   $342            $342
    ****  36  '=' or '..' or ':=' or '$=' operator expected
    ****      rest of statement ignored
    **** 140  Unknown symbol
    **** 342  Illegal suffix syntax - has to start with a letter

Note that when you encounter errors in GAMS, you should see the _first_ error.
In this case, the first error is the error of number $140.  This is a typical
syntax error message in LST files, namely, "Unknown symbol" error. This means
that you use the symbol not defined (declared) before.

The above message also shows the line with the error in the gms buffer, that is,
105.


If you type `y' in the LST file buffer, you can go to the first error place from
anywhere in the buffer.  Try it.

Next, type `u' in the LST buffer and you will jump back to the error line in the
program file buffer.

Repeating the same procedure

o Run GAMS (`F9' or `C-cC-s').
o Switch to LST buffer (`F10' or `C-cC-v').
o See the error line and its meaning.
o Jump back to the error line in the program file buffer (`u')

you can easily debug your GMS file.


[Note] The difference between `u' and `i' (or `b').

If an error exists, the following message will appear in the echo are.


    [u]=Jump to the error place, [i]=Jump to the main input file


If there is only one program file, you had better type `u'.  But there may be
many program files if you use $INCLUDE etc. and errors may be included in
subroutine files.  In this case, you may want to jump to the main input file
instead of the subroutine file with the error.  Then you had better type `i'
instead of `u'.

`u' = Jump to the error place
==> Jump to the file where the error exists (it may be a subroutine file).

`i' (or `b') = Jump to the main input file.
==> The main input file is the top level program file (its name is taken from
    the FILE SUMMARY field in the LST file.)

When you encounter another types of errors, only the error line may be
displayed.  For example, uncomment the line "* b = 1/a;" below (delete
*) and run GAMS and type `C-cC-v'.
$offtext
parameter a       Parameter a
          b       Parameter b
;
a = 0;
* b = 1/a; # Uncomment this line.
parameter c, d, e;

$ontext
Type `l' on the following error line


     *** Exec Error at line 185: division by zero (0)


then you will jump to the error line (185).  Moreover, type `b' and you jump to
the GMS file.

$offtext
*        ----------------------------------------------------------------------
$stitle         Other commands in GAMS mode.
*        ----------------------------------------------------------------------

* ---------------------------------------------------------
$stitle         Process handling.
* ---------------------------------------------------------
$ontext

[Running GAMS and editing a command line.]

As described above, you can start GAMS process by typing `C-cC-ts' (or F9).
Moreover, if you attach the universal argument (i.e. C-u), you are able to edit
the command line before starting process.

If you type `C-uC-cC-t', you see


    Start GAMS (s), Kill GAMS process (k), Change GAMS command (c), Change options (o).


If you type `s' here, you encounter a message like


    Edit command if you want:  gams gams-sample.gms


and you can edit the command line.  Moreover, when you edit the command line,
you are asked to use it in the future like this.


    Use this command line also in the future?


If you answer `y' to this, the following line will be inserted in the first line
of this file.


    *#!gams gams-sample.gms ll=0 lo=3 pw=95


When you evoke GAMS on this file next time, this line is passed to the shell as
the command line.  If you want to restore the default command line, just delete
this line.


[Specify a command line by *#! notation]

When there is a line beginning with *#! on the first line in a GMS file, GAMS
mode uses its content as a command line.  For example, suppose that you write
the following statement in the first line

    *#!c:/GAMS/win64/24.6/gams.exe gams-sample.gms ll=0 lo=3 pw=100 o=./gams-sample-alt.lst

Then,

c:/GAMS/win64/24.6/gams.exe gams-sample.gms ll=0 lo=3 pw=100 o=./gams-sample-alt.lst

is executed as a command line.  This is a function like #!/usr/bin/perl or
#!/bin/sh for shell scripts.  By default, the command line is determined by
`gams-process-command-name' and `gams-process-command-option' and it is common
to all GMS files. But when you want to use a different command line for a
specific file, use this *#! notation.


[Kill (stop) the GAMS process.]

If you type `k' when a GAMS process is running, you can kill (stop) the process.
Uncomment the following programs and try them.

 (1) `C-cC-t'
 (2) `s'
 (3) `C-cC-t' while a GAMS process running.
 (4) `k'

To uncomment a ontext-oftext pair, type `C-cM-c' on ontext or offtext.
$offtext
$ontext
*       Type `C-cM-c' on the above ontext!  To comment out them, type
*       the same.

set     o       /o1*o10000000/;
parameter
    xx(o)
    yy(o)
    ;
xx("o1") = 0;

loop(o,
    yy(o) = sin(xx(o));
    xx(o+1) = 0.1 + xx(o);
);
display yy;

$offtext
$ontext

[Change command line options.]

If you type `o' in the process menu, you can change and register a new command
line option combiantion.  Registered option combiantion is stored in the
variable `gams-user-option-alist' and saved in the file decided by the variable
`gams-statement-file'.

The default option combiantion is determinied by the value of
`gams-process-command-option'.


[Change gams command.]

If you type `c' in the process menu, you can change (and register) alternative
GAMS commands. You can set the default GAMS pcommand by the value of
`gams-process-command-name'. But you may often want to use gams.exe of different
versions. In such cases, register other gams.exe by this menu.

$offtext
* ---------------------------------------------------------
$stitle         Specify the place and name of the LST file.
* ---------------------------------------------------------
$ontext

When you run GAMS on a gms file, GAMS creates the LST file with the same name in
the same directory.  However, you can specify the name and place of the LST file
explicitly.

For example, if you want to let `lst-sample.lst' be the name of the LST file
corresponding to this gams-sample.gms and put it in the subdirectory `lst'.
Then, add the following code somewhere in this file:


    * gams-lst-file: ./lst/lst-sample.lst


(Note that * must really be on the beginning of line)

This code has two effects

1) gams is executed with option 'o=./lst/lst-sample.lst'

2) You can switch from the gms file to ./lst/lst-sample.lst by C-cC-v (or
   F10).

If you want to try this, please delete one `*' in the gams-lst-file line of this
file and run gams (see the beginning part of this file).

Similarly, you can specify the directory where the lst file is stored by setting
gams-lst-dir.

For example,

    * gams-lst-dir: ./lst

This code implies the lst directory is "./lst/" and the lst file name is stored
as "./lst/gams-sample.lst".


$offtext
* ---------------------------------------------------------
$stitle         GAMS statement completions.
* ---------------------------------------------------------

$ontext

You can insert GAMS statements with completion.  Type `C-cC-k', then the
following message will appear in the echo are.


    Insert statement (default = set):


Type SPACE or TAB key and the list of candidates will appear.  If you type
ENTER, the default value `set' is inserted.  Or if you type, for example, `v'
and then `SPACE', and the statement `VARIABLE' will be automatically inserted in
the echo are.

Similarly, dollar control options can be inserted with completion.  In this
case, type `C-cC-d'.

Moreover, if you type `C-uC-cC-k' or `C-uC-cC-d' on the existing statement or
dollar control, you can replace it with the new one.
$offtext

parameter       replace;        # Type C-uC-cC-k on `parameter'

set     s       Index   / 1*10 /;

parameter
    p(s)        Unit cost               # End-of-line comment.
    out_up(s)   Upper limit on out(s)
    t_dem       Total demand
;
out_up(s) = uniform(1,7);
p(s) = uniform(1,2);
t_dem = sum(s, out_up(s)*0.8);
display out_up, p, t_dem;

variable
    OUT(s)      Output of factory s
    TCOST       Total cost
;
equation
    eq_tcost
    eq_dem      Demand constraint
    eq_out(s)   "Constraint on out(s)";         /* Inline comment. */

eq_tcost .. TCOST =e= sum(s, p(s)*OUT(s));

eq_dem ..  sum(s, OUT(s)) =g= t_dem;

eq_out(s) .. OUT(s) =l= out_up(s);

out.lo(s) = 0;

$ontext
Moreover, the command `gams-insert-statement-extended' (C-cC-n) is also
available.  This command helps you in inserting various arguments for gams
statement such as model, solve, file, option, if, while, loop, and put.

For example, try

C-cC-n -> model [ENTER]

and then

C-cC-n -> solve [ENTER]

$offtext

* model cost_min Cost minimization / eq_tcost, eq_dem, eq_out /;
* solve cost_min using lp minimizing TCOST;

* ---------------------------------------------------------
$stitle         Automatic registration of a new statement.
* ---------------------------------------------------------
$ontext

If you are to insert a statement not registered by default, you can register it
for the future use.  For example, if you type `abort' like


    Insert statement (default = set): abort


and type `ENTER', then you are asked


    Store `abort' for future use?  Type `y' if yes:


If you type `y' here, the statement `abort' is registered and it is included in
the list of candidates of statement completion.  These registered statements are
saved in the file "~/.emacs.d/gams-statement.txt".  If you have registered
unnecessary statements, open the file "~/.emacs.d/gams-statement.txt" and delete
them manually.

GAMS has a lot of statements.  But only basic statements are registered in
gams-mode.el by default.  So, please register statements that you frequently use
by yourself.

$offtext

* ---------------------------------------------------------
$stitle         auto-complete mode for GAM mode.
* ---------------------------------------------------------
$ontext

auto-complete.el (auto-complete minor mode) enables you to complete words with
popup menu. You can use auto-complete mode in GAMS mode.

To use auto-complete, you first need to install "auto-complete.el" which can be
installed from MELPA.

To use auto-complete in GAMS mode, add the following code to init.el.

        ;; Load gams-auto-complete.
        (require 'gams-ac)
        ;; Initial setup for auto-complete in GAMS mode.
        (gams-ac-after-init-setup)

If you want to add words for auto-complete mode by yourself, add words to the
variable `gams-ac-source-user-keywords-list` like

        ;; Add the following words to candidates of auto-complete.
        (setq gams-ac-source-user-keywords-list
              '("computable" "general" "equilibrium"))

$offtext

* ---------------------------------------------------------
$stitle         Quotation and parenthesis.
* ---------------------------------------------------------
$ontext

Type ', ", or (, and the corresponding ', ", and ) will be automatically
inserted if lisp variables `gams-close-paren-always',
`gams-close-double-quotation-always' and `gams-close-single-quotation-always'
are assigned non-nill.  If you attach the universal argument to `(', then only
`(' is inserted.

$offtext

* ---------------------------------------------------------
$stitle         Insert user defined comment template.
* ---------------------------------------------------------

$ontext

To write a gms file that other people (or yourself) can understand easily, it is
good to use comments effectively.  You can insert a comment template by typing
`C-cC-o' (gams-insert-comment).  Inserted template is defined by a variable
`gams-user-comment'.  You can change the value of this variable.  For example, I
put the following in my "init.el".

     (setq gams-user-comment
           "*       ------------------------------------------------------------------------
     *      %
     ")

Please see the help of `gams-user-comment'.

$offtext

* ---------------------------------------------------------
$stitle         GAMS-TEMPLATE.
* ---------------------------------------------------------
$ontext

GAMS-TEMPLATE mode (binded to `C-cC-e' by default) enables you to handle
templates easily.  You can easily insert, re-edit, delete, rename, re-order, and
add templates.

There is a sample template file "gams-template.txt" which is distributed with
this file.  Save it in your "~/.emacs.d/" directory.  To start GAMS-TEMPLATE
mode, type `C-cC-e' in the GAMS mode buffer.  If you want to know the commands
in GAMS-TEMPLATE mode, type `h' in the *Template List* buffer.

$offtext

* ---------------------------------------------------------
$stitle         Fill paragraph.
* ---------------------------------------------------------
$ontext

As in other major modes, filling paragraph works in GAMS mode.  Put the cursor
in the next commented out paragraph and type `M-q'.


*       Put the cursor around here!  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph....


    Put the cursor around here!  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph....


*  This makes two paragraph respectively like

*       Put the cursor around here!  This is a sample paragraph.  This is a
*       sample paragraph.  This is a sample paragraph.  This is a sample
*       paragraph.  This is a sample paragraph.  This is a sample paragraph.
*       This is a sample paragraph....

    Put the cursor around here!  This is a sample paragraph.  This is a sample
    paragraph.  This is a sample paragraph.  This is a sample paragraph.  This
    is a sample paragraph.  This is a sample paragraph.  This is a sample
    paragraph....

$offtext

* ---------------------------------------------------------
$stitle         Commenting out
* ---------------------------------------------------------
$ontext

You can comment out the region with *.  Select a region and type C-cC-;, then
you can comment out that region.  If you can use C-cC-; to uncomment the
commented-out region. C-cC-; is binded to `gams-comment-or-uncoment-region`
command which is aliased for `commented-or-uncomment-region`.

$offtext

* gams-include-file: ./include/include-sample.gms
$include %sub_program%

* ---------------------------------------------------------
$stitle         Font-lock (coloring).
* ---------------------------------------------------------
$ontext

GAMS mode for Emacs supports various coloring (font-lock in Emacs terminology).

If you set font-lock-mode on, coloring automatically works in GAMS mode,
GAMS-LST mode, and GAMS-OUTLINE mode.  To set font-lock-mode on in these three
modes, put the following your "~/.emacs.d/init.el" file:

(global-font-lock-mode t)

You can choose three coloring levels by `gams-choose-font-lock-level' (binded to
C-cC-f).

 0 => no coloring.
 1 => minimum coloring.
 2 => maximum coloring.

Try it!

$offtext
*       Type `C-cC-f' and change the coloring level!

set    k       Index k                / 1, 2 /
       l       Index l                / l1*l10 /;

parameter    v       Parameter v     / 1 /
             t       Parameter t     / 2 /
             u(k)    Parameter u;
u(k) = 1;

display "Parameter p and q", u;
display 'Single quote p and q', u;

$ontext
This command is available in GAMS mode, GAMS-LST mode, and GAMS-OUTLINE mode.

If you open a large file, it will take much time to color a buffer.  So, you may
be better choose low coloring level before opening a large file.

The default level of coloring in each mode is determinied by the variable
`gams-font-lock-level', `gams-lst-font-lock-level', and
`gams-ol-font-lock-level'.  All default values are 2 (maximum level).

Moreover, you can re-color a part aroung the cursor (not an entire buffer) by
using `font-lock-fontify-block' (binded to M-gM-g).  It is much faster.

If you encounter odd behavior of coloring, please let me know it!  I will fix
them.

$offtext

* ---------------------------------------------------------
$stitle         Display the declaration place of an identifier.
* ---------------------------------------------------------
$ontext

While you are reading or editing a GAMS program, you may often go back to the
declaration place of an identifier so as to see its definition.  In such a case,
you could use, for example, `isearch-backward' command or something.  But if the
identifier is used many times at the different places of the program or
declared/used in the subroutine files, it is difficult to find the declaration
place of the identifier.

`gams-show-identifier' (binded to F7 or `C-cC-.' by default) enables you to see
the declaration place of the identifier under the cursor.  Try to type F7 on the
following examples.

$offtext
u(k) = 1;               # Type F7 on the identifier u and k
out.fx(s) = 10;
display out.l;          # Type F7 on the identifier p

$ontext
If you type F7 on, for example, the identifier "u", u's declaration place will
appear in the upper window and the position of the cursor will be displayed in
the left window.  You will see the following message in the echo are:

    'u' is declared as parameter: [?]help,[d]ecl,[n]ext,[p]rev,[e]copy,[r]escan,[ ]restore,[ENT]jump,[TAB]jump+keep

If you type n(p), you can move to the next (previous) place where "u" appears.
Type d, you can move to the declaration place.  Type c, you can move to the
original point.

If you type SPC, the previous window position will be restored.  If you type
ENT, you will jump to the declaration place.  If you type other keys, two
buffers will continue to be displyed.

Typing ? will show the help.

`gams-show-identifier' can show the declaration place in the subroutine files.

The identifier "ene", "out", "util", "com", "sec", "m" and "n"" below are
declared in the subroutine file "include-sample.gms" and "include-sample-2.gms".
Type F7 on each identifier.

$offtext
display ene;            # Type F7 on the identifier ene
display op;             # Type F7 on the identifier oq
display util;

ene(com,sec) = 100;
op(sec) = 1000;
display ene, op, sec, com;

m = -100;
n = -200;

display m, n;

a = 1;                  # Type F7 on the identifier a
display a;              # Type F7 on the identifier a

$ontext
If you attach universal-argument, (i.e. C-uC-cC-.), you are asked the identifier
that you want to search.  Try "C-uC-cC-.".

$offtext

* ---------------------------------------------------------
$stitle         Display the list of identifiers.
* ---------------------------------------------------------
$ontext

`gams-show-identifier-list' (binded to `C-cC-a' by default) displays the list
identifiers (sets, parameters, variables and so on) defined in the current
program file.  To learn how to use this command, try C-cC-a and type `?'.

If you use `gams-show-identifier-list' (C-cC-a), it shows all identifiers
including those which are defined in subroutine files. However, if you use the
following expression to include subroutine files, GAMS mode cannot read the
subroutine files because GAMS mode does not know the value of %sub_program%.

    $include %sub_program%

In this case, you can make GAMS mode read the subroutine
`./include/include-sample.gms' by adding to the following code before $include
command.

    * gams-include-file: ./include/include-sample.gms
    $include %sub_program%

The line starting with "* gams-include-file:" specifies the subroutine file for
`gams-show-identifier-list'.

The value of %sub_program% changes through $set or $setglobal command, but you
can specifiy the default subroutine file name by `gams-include-file'.

$offtext

* ---------------------------------------------------------
$stitle         Commands on a ontext-offtext pair.
* ---------------------------------------------------------
$ontext

`gams-insert-on-off-text' (binded to `C-cC-c' by default) inserts an
ontext-offtext pair.  If you attach the universal-argument (i.e. `C-uC-cC-c'),
this command encloses the specified region with an ontext-offtext pair.

Using `gams-jump-on-off-text' (`C-cC-g') on an ontext (offtext), you can jump to
the corresponding offtext (ontext).

Using `gams-comment-on-off-text' (`C-cM-c') on an ontext (offtext), you can
comment out or uncomment a pair of ontext-offtext.

Using `gams-remove-on-off-text' (`C-cM-g') on an ontext (offtext), you can
remove a pair of ontext-offtext.

$offtext
display "Try to type C-cC-c, C-uC-cC-c, C-cC-g, C-cM-c, and C-cM-g",
        "on a ontext or offtext!";

* ---------------------------------------------------------
$stitle         Align block.
* ---------------------------------------------------------

$ontext
You can align table and other blocks according to GAMS systax by
`gams-align-block' (C-cC-y).

[Example 1]

Set the region from the header line to the end of the table and type C-cC-y -> t
-> 3 -> y.  Then, the table below is formatted.

*       Before
table table1    test table
                Japan   USA       EU     China  Korea
agriculture       70          4   24         197     3
fishery               21     8     0       17      27
textile           4         6      106     2         -8
food                9     415    0       95         15
energy            0        8      6      -327     7
;

*       After
table table1    test table
               Japan    USA     EU    China    Korea
agriculture       70      4     24      197        3
fishery           21      8      0       17       27
textile            4      6    106        2       -8
food               9    415      0       95       15
energy             0      8      6     -327        7

[Example 2]

Set the regions from `Start' to `End' and then type C-cC-y -> o.  Then all =
symbols are aligned like

parameter
    abc(*);

*       Before
*       Start.
abc("agriculture") = 100;
abc("fishery") = 200;
abc("textile") = 1;
abc("food") = 20;
abc("energy") = 123;
*       End.

*       After
*       Start.
abc("agriculture") = 100;
abc("fishery")     = 200;
abc("textile")     = 1;
abc("food")        = 20;
abc("energy")      = 123;
*       End.

display abc;
$offtext

* ---------------------------------------------------------
$stitle         Automatic indentation.
* ---------------------------------------------------------
$ontext

You can indent GAMS programs accordint to GAMS syntax.

M-C-\        =       Indent region.  Specify region and type M-C-\.
TAB          =       Indent the current line.

Select the following region and the type `M-C-\' (`indent-region').

$offtext

*       ----------------------------------------------------------------------
*       From here.
*       ----------------------------------------------------------------------

set     i       Index   / i1*i2 /
j       Index   / j1*j2 /;

parameter
para(i,j)       Parameter a
parb(i,j)       Parameter b
parc(i,j,*)     Parameter c;

para(i,j) = uniform(0,1);

loop((i,j),

*       Display i.
display "Display set i", i;
*       Display j.
display "Display set j", j;
if((para(i,j) > 0.5),
display "para is greater than 0.5!";
else
display "para is less than 0.5!";
);

parb(i,j) = para(i,j) * 2;
parc(i,j,"a") = para(i,j);
parc(i,j,"b") = parb(i,j);

*       Display parc.
display parc;
);

*       ----------------------------------------------------------------------
*       Until here
*       ----------------------------------------------------------------------
$ontext

Select the above region and type `M-C-\' (`indent-region'), then the above
region is indented like the following:

set     i       Index   / i1*i2 /
        j       Index   / j1*j2 /;

parameter
    para(i,j)       Parameter a
    parb(i,j)       Parameter b
    parc(i,j,*)     Parameter c;

para(i,j) = uniform(0,1);

loop((i,j),

*       Display i.
    display "Set i", i;
*       Display j.
    display "Set j", j;
    if((para(i,j) > 0.5),
        display "para is greater than 0.5!";
    else
        display "para is less than 0.5!";
    );

    parb(i,j) = para(i,j) * 2;
    parc(i,j,"a") = para(i,j);
    parc(i,j,"b") = parb(i,j);

*       Display parc.
    display parc;
);

=== Note ===
To make automatic indentation in GAMS mode work well, please end reserved word
blocks (e.g. parameter, table, set, display blocks etc.)  with a semicolon (;)
although it may not be necessarily required in GAMS syntax.

$offtext

* ---------------------------------------------------------
$stitle         View manual.
* ---------------------------------------------------------
$ontext

In GAMS Studio (or GAMSIDE), you can view GAMS manuals from Help.  The same kind
of command is available in GAMS mode.  The command name is `gams-view-document'
and it is binded to `C-cC-m' by default.

Try type `C-cC-m' in the GAMS mode buffer. Then you see the following message in
echo area.

    Press ENTER key if you use online manual. Press other keys for offline manual.

If you press ENTER key, then the default brower opens GAMS online manual (GAMS
Documentation Center). If you press other key, the brower opens local GAMS
manual.

In addition, you can search a command in GAMS manuals. Try C-uC-cC-m on the
command `uniform' in the code below, then you can directly search `uniform' in
the GAMS online manual (this command search function is only available on the
online manual).
$offtext
loop((i,j),
    parb(i,j) = uniform(0,1); # Press C-uC-cC-m on the command `uniform'.
);
$ontext

To use this command, you need to set the proper values to the variables
`gams-system-directory', `gams-docs-directory'.  See the explanation of two
variables.
$offtext

* ---------------------------------------------------------
$stitle         GAMS model library.
* ---------------------------------------------------------
$ontext

GAMS provides the model library. By `gams-model-library' (binded to C-cC-z), you
can view models in GAMS model library from Emacs.  To use this, you must set the
GAMS system directory to the variable `gams-system-directory'.

To use `gams-model-library', you need to set the proper value to the variable
`gams-system-directory'. Note that this command works only in GAMS of ver.22.8
or later.

To extract files from the library, this command uses `gamslib.exe'.  You need to
set the proper value to the variable `gams-gamslib-command'.

$offtext

* ---------------------------------------------------------
$stitle         Inline and end-of-line comments
* ---------------------------------------------------------
$ontext

You can insert the inline and end-of-line comment by `gams-comment-dwim' and
`gams-comment-dwim-inline' (binded to M-; and C-cM-; respectively).

If the file includes $eolcom and $inlinecom dollar control options, the
end-of-line and inline comment symbols are determined by such values.

If $inlinecom or $eolcom do not exists in the file, `gams-comment-dwim' and
`gams-comment-dwim-inline' insert their default values determined by the
variables `gams-inlinecom-symbol-start-default',
`gams-inlinecom-symbol-end-default', and `gams-eolcom-symbol-default'.

If you attach the universal argument when executing `gams-comment-dwim' and
`gams-comment-dwim-inline', you are asked which symbol to be inserted.

In MPSGE block, "!" is always used as the end-of-line comment symbol.

Note: It is desirable to use a single character as eol and inline comment
symbols.  GAMS mode cannot handle multi-character symbols well.

Try to type M-;, C-cM-;, or C-uC-cM-;, C-uM-; (note that eol and inline comment
symbols are already defined in this file)

Try to type M-; and C-cM-;.

$offtext
parameter
    eol1        "End-of-line comment.    Type M-;"
    eol2        "End-of-line comment 2.  Type M-;"
;
parameter
    inl1        "Inline comment.    Type C-cM-;"
    inl2        "Inline comment 2.  Type C-cM-;"
;

* ---------------------------------------------------------
$stitle         Hide (or show) comment regions.
* ---------------------------------------------------------
$ontext

You can hide and show comment regions by C-cC-h.

$offtext

* ---------------------------------------------------------
$stitle         Org mode like headling representation
* ---------------------------------------------------------
$ontext

In GAMS mode, you can use outline representation like Org-mode (or outline
mode).

By default, lines starting with `*@` are regarded as headlines.

      *@    The top level headline
      *@@   Second level
            text text
      *@@@  Third level
            text text
      *@    Another top level headline

You can change outline representation by the following two commands:

+ `gams-orglike-cycle` (binded to TAB key)
+ `gams-orglike-global-cycle` (binded to Shift+TAB key).

`gams-orglike-cycle` command works only on headlines and toggles hide/show the
body of programs. `gams-orglike-global-cycle` toggles hide/show entire program.
Try TAB and Shift+TAB.

For details, see `orglike-headline.gms' and `orglike-headline-alt.gms' files.


$offtext

*        ----------------------------------------------------------------------

$stitle         Other commands in GAMS LST mode.
*        ----------------------------------------------------------------------
$ontext

If you type `M-x help ENTER' and `m' in a LST file buffer, you can read the
simple explanation of GAMS LST mode (or type `?' in a LST file buffer).  It is
like this:

gams-lst-mode is an interactive Lisp function in `gams'.  (gams-lst-mode)

Major mode for viewing GAMS LST file.

The following commands are available in the GAMS-LST mode:

y               Jump to the error and show its number and meaning.
u               Jump back to the error place in the program file.
i               Jump to the input (GMS) file.
q               Close the buffer.
?               Display this help.
.               Display the Included File Summary.

o               Start the GAMS-OUTLINE mode.

s(S)            Jump to the next (previous) SOLVE SUMMARY.
r(R)            Jump to the next (previous) REPORT SUMMARY.
v(V)            Jump to the next (previous) VAR entry.
e(E)            Jump to the next (previous) EQU entry.
p(P)            Jump to the next (previous) PARAMETER entry.

l               Jump to a line you specify.
L               Jump to a line.

SPC             Scroll up.
M-v or DEL      Scroll down.
1               Widen the window.
2               Split the window.
m               Move frame.
w               Resize frame.
z               Move a cursor to the other window.


[Commands for Scrolling.]

...

[snip]


Try each command by yourself.


$offtext
*        ----------------------------------------------------------------------

$stitle         GAMS-OUTLINE mode.
*        ----------------------------------------------------------------------
$ontext

The GAMS-OUTLINE enables you to outline important components in the LST file.

You can learn the basic usage of GAMS-OUTLINE mode by reading a sample file
"outline-sample.gms" which is distributed with this file.

To start the GAMS-OUTLINE mode, type `o' in the LST file buffer.  Try to start
GAMS-OUTLINE mode on this file (run GAMS on this file and switch to the LST file
and type `o').  Or you can directly move to the GAMS-OUTLINE mode by typing
C-cC-i (or F12).

$offtext
display "";
display "@ This is gams-sample.gms";
display "";
display "";
display "@ The GAMS-OUTLINE mode is like this!";
display "";

set     iter    Iteration index                / iter1*iter20 /;

parameter
    num             Iteration number
    x(iter)         Parameter x
    y(iter)         Parameter y
    z(iter,*)       Parameter for x and y;

x("iter1") = 0;

loop(iter,
    num = ord(iter);
    x(iter+1) = x(iter) + 3.14 * 0.01;
    y(iter+1) = sin(x(iter+1));
    z(iter+1,"a") = x(iter+1);
    z(iter+1,"b") = y(iter+1);
);

display "PARAMTERS in the LST file are displayed like:", x, y, z;
display "";
display "";
display "For details of GAMS-OUTLINE mode, read a sample file outline-sample.gms";
display "and the help in GAMS-OUTLINE mode (type `?' in this buffer).";

display a;
display ene, op, sec, com;
display m, n;

$show

* --------------------
* Local Variables:
* fill-column: 80
* mode: gams
* End:
