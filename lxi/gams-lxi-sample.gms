$title	A sample program for GAMS-OUTLINE mode.
display "com: A sample program for GAMS-OUTLINE mode.";
$ontext
Time-stamp:	<2016-02-28 14:18:27 st>
Author:		Shiro Takeda
First-written:	<2001/10/26>

[Note]:

  This program is written to show how to use the GAMS-LXI mode.

  When you run GAMS on GAMSIDE, a file with extension ".lxi" (hereafter the LXI
  file) is created.  GAMSIDE uses this LXI file to show a list of important
  items of the LST file in the left window.  GAMS-LXI mode provides the same
  function.

  When you start the GAMS-LXI mode,

  1) gams-mode.el creates the LXI file from the LST file and
  2) shows a list of important items of the LST file in the left buffer
  3) In the right buffer, the content of the LST file is displayed.

   --------------------------------------
   | A list of     | Content of LST     |
   | important     |                 	|
   | items of LST  |                 	|
   | file.         |                 	|
   |               |                 	|
   | This is       |                 	|
   | created from  |                 	|
   | LXI file.     |                 	|
   |               |                 	|
   | GAMS-LXI mode | GAMS-LXI-VIEW mode |
   --------------------------------------


  * Difference between GAMS-LXI mode and GAMS-OUTLINE mode.

  GAMS-LXI mode resembles GAMS-OUTLINE mode.  But there are differences between
  two modes:

  1) Types of listed items.

  2) GAMS-OUTLINE mode directly loads the LST file while GAMS-LXI loads only a
     part of it.

  The second feature of GAMS-LXI mode becomes an advantage when the LST file is
  quite large.  Since Emacs has limitation on its memory usage (about 400MB), it
  is difficult to read the large LST file by GAMS-OUTLINE mode.  On the other
  hand, GAMS-LXI mode loads only a part of the LST file and thus can see the
  content of the quite large LST file.


[Prerequisite]

  To use GAMS-LXI mode, two external non-lisp commands are required:
  "gamslxi.exe" and "gamslxi-import.exe".

  The former is a program for creating the LXI file from the LST file and the
  latter is for loading the content of the LST file.

  To use two commands, you need to set the following lisp variables:
  `gams-lxi-command-name' and `gams-lxi-import-command-name'.

  For example, if two commands are placed at "c:/home/lisp" directory, put the
  following setting in "~/.emacs.el":

    (setq gams-lxi-command-name "c:/home/lisp/gamslxi.exe")
    (setq gams-lxi-import-command-name "c:/home/lisp/gamslxi-import.exe")

  If you place two commands in the directory included in environmental variable
  PATH, the following setting will do.
  
    (setq gams-lxi-command-name "gamslxi.exe")
    (setq gams-lxi-import-command-name "gamslxi-import.exe")


  Try to run GAMS on this file. After creating LST file, type C-cC-x. Then,
  GAMS-LXI mode will start.

  Type `?' in the GAMS LXI mode for viewing the help.


[Other customizable variables]

  * `gams-lxi-maximum-line' (the default value is 500000):

    The maximum number of lines for GAMS-LXI mode. This determines the maximum
    number of lines of the LST file that GAMS LXI mode loads.  If the number of
    lines of the LST file exceeds this value, GAMS-LXI mode only loads a part of
    it.

  * `gams-lxi-extension' (the default value is "lxi"):

    "The default extention used for the LXI file."

  * `gams-lxi-width' (the default value is 40):

     "The default width of the GAMS-LXI buffer."


[Notes]

  The LXI file created by gams-mode.el is not compatible with that created by
  GAMSIDE.

$offtext

*	----------------------------------------------------------------------
*	Example 1.
*	----------------------------------------------------------------------
set
    iter Iteration index		/iter1*iter20/
;
parameter
    num		    Iteration number
    a(iter)	    Parameter a
    b(iter)	    Parameter b
    c(iter,*)	    Parameter for a and b;
a("iter1") = 0;

loop(iter,
    num = ord(iter);
    a(iter+1) = a(iter) + 3.14 * 0.01;
    b(iter+1) = sin(a(iter+1));
    c(iter+1,"a") = a(iter+1);
    c(iter+1,"b") = b(iter+1);
);

*	----------------------------------------------------------------------
*	Example 3.
*	----------------------------------------------------------------------

* The model presented in this example is the core-periphery model of Chap 5 in
* Fujita, Krugman, and Venables (1999) "Spatial Economy", MIT press.
set	itr	Times of iteration (lambda)		/iter1*iter11/
	tc	Times of iteration (transport cost)	/1*5/
	allo	Vector of omegas			/omone, omtwo, omratio/;

parameters
    lowest  The lowest value of transport cost,
    highest The highest value of transport cost;
lowest = 1.3;
highest = 2;

*	Declare model parameters.
parameters
    mu	    Expenditure share on manufactured goods,
    sig	    Elasticity of subustitution,
    sigm    one minus sig,
    vt	    Value of transport cost,
    lam	    The share of workers in region one;

*	Declare endogenous variables.
variables
    wone    Nominal wage of region one,
    wtwo    Nominal wage of region two,
    omeone  Real wage of region one,
    ometwo  Real wage of region two,
    ratio   Ratio of real wage omeone devided by onetwo;

*	Declare equations.
equations
    weqone	    Wage equation for wone,
    weqtwo	    Wage equation for wtwo,
    rweqone	    Real wage equation for omega one,
    rweqtwo	    Real wage equation for omega two,
    eqratio	    eq for RATIO;

*	Equation definitions:
weqone ..

    (wone**sig)
    =e= (mu *	lam * wone + (1-mu) /2)
    / (lam * (wone**sigm) + (1-lam) * ((wtwo * vt)**sigm))
    + ((mu * (1-lam) * wtwo + (1-mu)/2) * (vt**sigm))
    /(lam * ((wone * vt)**sigm) + (1-lam) * (wtwo**sigm));

weqtwo ..

    (wtwo**sig)
    =e= ((mu * lam *wone + (1-mu)/2) * (vt**sigm))
    /(lam * (wone**sigm) + (1-lam) * ((wtwo * vt)**sigm))
    + (mu * (1-lam) * wtwo + (1-mu) /2)
    /(lam * (wone * vt)**sigm + (1-lam) * (wtwo**sigm));

rweqone ..

    omeone =e= wone * (lam * (wone**sigm)
	+ (1-lam) * ((wtwo * vt)**sigm))**(-mu/sigm);

rweqtwo ..

    ometwo =e= wtwo * (lam * ((wone * vt)**sigm)
	+ (1-lam) * (wtwo**sigm))**(-mu/sigm);

eqratio .. ratio =e= omeone / ometwo;

*	Declare model.
model	fkv	Core and periphery model
	/ weqone, weqtwo, rweqone, rweqtwo, eqratio /;

*	----------------------------------------------------------------------
*	Insert numerical values in parameters.
mu = 0.4;
sig = 5;
sigm = 1 - sig;

parameter
    lambda	    Value of lam,
    iterlog	    Iteration log,
    log		    Ratio of real wages in two regions;

parameters
    count1,
    count2;

*	Initial values parameters.
parameters
    wone0   Initial value
    wtwo0   Initial value
    omeone0 Initial value
    ometwo0 Initial value;

*	----------------------------------------------------------------------
*	Loop.
display "com: Loop starts here.";

loop(tc,
    count2 = (ord(tc) - 1)/(card(tc) - 1);
    vt = (1-count2) * lowest + count2 * highest;

*	Set initial values of the first iteration (tc).
    wone0 = 2;
    wtwo0 = 2;
    omeone0 = 2;
    ometwo0 = 2;
    display tc;

    loop(itr,
	display itr;
	display "Current transport cost:", vt;

*	Determine `lam'.
	count1 = (ord(itr) - 1)/(card(itr) - 1);
	lambda(itr) = (1-count1)*0 + count1*1;
	lam = lambda(itr);

	display "Current lambda:", lam;

	wone.l = wone0;
	wtwo.l = wtwo0;
	omeone.l = omeone0;
	ometwo.l = ometwo0;

	display "Initail values",
	    wone.l, wtwo.l, omeone.l, ometwo.l;

	fkv.iterlim = 3000;
	solve fkv using mcp;

	display weqone.m, weqtwo.m;
	iterlog(itr, tc,  "omone") = omeone.l;
	iterlog(itr, tc, "omtwo") = ometwo.l;
	iterlog(itr, tc, "omratio") = ratio.l;

	log(itr, tc) = iterlog(itr, tc, "omratio");

	wone0 = wone.l;
	wtwo0 = wtwo.l;
	omeone0 = omeone.l;
	ometwo0 = ometwo.L;
    );
);

display "Show the results from loop. ", log;
* $libinclude plot log

*	----------------------------------------------------------------------
*	Example 4.
*	----------------------------------------------------------------------

*	Model M2-1s: Closed 2x2 Tax-Ridden Economy --  Vector Syntax

table bmflow(*,*)  Benchmark flows (in value terms)
		 x	 y	  w	cons
	x      100	       -100
	y	       100     -100
	w			200	-200
	l      -20     -60		  80
	k      -60     -40		 100
	tax    -20	 0		  20

set	i	Goods index  /x, y/
	f	Factors index /l, k/;
alias (i,j)

parameter
    ybar(i)	    Benchmark output levels
    fdbar(f,i)	    Benchmark factor inputs
    cbar(i)	    Benchmark final demand
    pbar(f,i)	    Benchmark factor price
    endow0(f)	    Factor endowments
    txf(f,i)	    Ad-valorem tax rate on sector i inputs
    txo(i)	    Proportioanl tax rate on sector i outputs
    ubar	    Benchmark expenditure;

*	Extract values from the table:
ybar(i)		= bmflow(i,i);
fdbar(f,i)	= -bmflow(f,i);
cbar(i)		= -bmflow(i,"w");
ubar		= sum(i, cbar(i));
endow0(f)	 = bmflow(f,"cons");

txf("l",i)	=  -bmflow("tax",i) / fdbar("l",i);
pbar(f,i)	= 1 + txf(f,i);
txo(i)		= 0;

$ontext

$model:m2_1

$sectors:
  v(i)    ! Activity level (vector variable)
  w       ! Welfare index

$commodities:
  pw      ! Utility price
  p(i)    ! Goods prices
  pf(f)   ! Factor prices

$consumers:
  cons    ! Representative consumer

$prod:v(i) s:1
  o:p(i)  q:ybar(i)       a:cons  t:txo(i)
  i:pf(f) q:fdbar(f,i)    p:pbar(f,i)  a:cons  t:txf(f,i)

$prod:w  s:1
  o:pw    q:ubar
  i:p(i)  q:cbar(i)

$demand:cons
  d:pw    q:ubar
  e:pf(f) q:endow0(f)

$offtext
$sysinclude mpsgeset m2_1

m2_1.iterlim = 0;
$include M2_1.GEN
solve m2_1 using mcp;
m2_1.iterlim = 2000;

*	----------------------------------------------------------------------
*	Increase the endowment.

set	sce	/ sce1*sce10 /;
parameter
    endow(f)
    utility Utility level;
endow(f) = endow0(f);

loop(sce,
    endow0(f) = (1 + ord(sce)/100) * endow(f);
    display endow0;
$include M2_1.GEN
    solve m2_1 using mcp;
    utility(sce) = w.l;
);
display utility;

* --------------------
* Local Variables:
* fill-column: 80
* End:
