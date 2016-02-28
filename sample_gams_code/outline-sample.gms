$title	A sample program for GAMS-OUTLINE mode.
display "@ A sample program for GAMS-OUTLINE mode.";
$ontext
Time-stamp:	<2016-02-28 14:19:23 st>
Filename:	outline-sample.gms
Author:		Shiro Takeda
First-written:	<2001/10/26>

[Note]:

  For gams-mode.el version 3.6.

  This program is written to show how to use GAMS-OUTLINE mode (abbreviated as
  GAMS-OL mode).

  Try to run GAMS on this file and switch to the LST file (`C-cC-v') and type
  `o'.  Then you can start the GAMS-OUTLINE mode.

$offtext

display "";
display "@ This file is written to show how to use the GAM-OUTLINE mode.";
display "";
display "Type `?' for help!";
display "";
display "";
display "@ Basic explanation and usage.";
display "";

*	----------------------------------------------------------------------
*	Types of viewable items.
display "Types of displayed items:";
display "";
display "Strings are labelled as OTH (other).";
display "Sets are labelled as SET.";
display "Parameters are labelled as PAR.";
display "'VAR' is labelled as VAR.";
display "'EQU' is labelled as EQU.";
display "'VARIABLE' is labelled as VRI.";
display "LOOPS is labelled as LOO.";
display "SOLVE and REPORT SUMMARY are labelled as SUM.";
display "A special comment line is enclosed with [ and ].";
display "";
display "Basic keybindings:";
display "";
display "SPACE	= Show the content of the item on the current line.";
display "N	= Show the content of the next item.";
display "P	= Show the content of the previous item.";
display "t	= Select viewable items.";
display "T	= Select registered item combination.";
display "";
display "m	= Mark an item.";
display "u	= Unmark an item.";
display "y	= Jump to the marked item.";
display "";
display "i	= Switch back to the LST buffer.";
display ";	= Switch back to the GMS buffer.";
display "?	= Show the help.";
display "q	= Quit GAMS-OUTLINE mode.";
display "";
display "c	= Toggle the follow mode.";
display "x	= Toggle the display style.";
display "l	= Widen the window with one line.";
display "o	= Narrow the window with one line.";
display "1	= Widen the window.";
display "C-l	= Recenter.";
display "";
display "RET	= Scroll up.";
display "DEL	= Scroll down.";
display "n	= Next line.";
display "p	= Previous line.";
display ",	= Go to the beginning of the buffer.";
display ".	= Go to the end of the buffer.";
display "";
display "w	= Resize frame.";
display "e	= Move frame.";
display "";
display "C-cC-f = Choose font-lock level.";
display "";
display "Try each command by yourself.	See the help for other keybindings.";

*	----------------------------------------------------------------------
*	If you want to display a special comment line in a GAMS-OL mode buffer,
*	use the statement display with "@" like this:
display "";
display "@ The line starting with @ like this line is a special comment line.";
display ""
display "To create a special comment line, use the display statement with @";
display "See the sample gms file.";

*	----------------------------------------------------------------------
*	Example 1.
*	----------------------------------------------------------------------
display "";
display "@ Example 1: A simple example.";
display "";

set
    iter Iteration index		/ iter1*iter20 /
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

display "'PARAMTERS' in the LST file are displayed like:", a, b, c;
display "";

*	----------------------------------------------------------------------
*	Example 2.
*	----------------------------------------------------------------------
display "";
display "@ Example 2: Mark an item and view two items simultaneously.";
display "";
display "Type `m' (mark) on a line, for example, PAR  a above.";
display "and move to ther line, for example, here below";
display "and type SPACE.";
display "Then, you can view two items simultaneously in two different windows.";
display "If you want to unmark, type `u'.";

parameter
    here    'Mark "PAR  a" above and move to this line';

here = 0;
display "";
display here;
display "";

*	----------------------------------------------------------------------
*	Example 3.
*	----------------------------------------------------------------------
display "";
display "@ Example 3: Solve the core and periphery model.  Select viewable items.";
display "";
display "In this example, various items are displayed,"
display "- VAR, EQU, PAR, SET, SUM, OTH, LOO, VRI, COM."
display "";
display "You can select the items displayed."
display "Type `t' in this buffer, then SELECT-ITEM mode will start."
display "";
display "Moreover, you can register the viewable item combinations";
display "in SELECT-ITEM mode (type `a' in that mode).";
display "";
display "If you have registered various viewable item combinations,";
display "then you can select them by typing `T' (gams-ol-item)";
display "";

* The model presented in this example is the core-periphery model of Chap 5 in
* Fujita, Krugman, and Venables (1999) "Spatial Economy", MIT press.
set	itr	Times of iteration (lambda)		/ iter1*iter11 /
	tc	Times of iteration (transport cost)	/ 1*5 /
	allo	Vector of omegas			/ omone, omtwo, omratio /;

parameters
    lowest  The lowest value of transport cost
    highest The highest value of transport cost;
lowest = 1.3;
highest = 2;

*	Declare model parameters.
parameters
    mu	    Expenditure share on manufactured goods
    sig	    Elasticity of subustitution
    sigm    one minus sig
    vt	    Value of transport cost
    lam	    The share of workers in region one;

*	Declare endogenous variables.
variables
    wone    Nominal wage of region one
    wtwo    Nominal wage of region two
    omeone  Real wage of region one
    ometwo  Real wage of region two
    ratio   Ratio of real wage omeone devided by onetwo;

*	Declare equations.
equations
    weqone	    Wage equation for wone
    weqtwo	    Wage equation for wtwo
    rweqone	    Real wage equation for omega one
    rweqtwo	    Real wage equation for omega two
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
display "@ Loop starts here.";

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

display "@@ Show the results from loop. ", log;
* $libinclude plot log

*	----------------------------------------------------------------------
*	Example 4.
*	----------------------------------------------------------------------
display "";
display "";
display "@ Example 4: Vector variable";
display "";
display "";

*	Model M2-1s: Closed 2x2 Tax-Ridden Economy --  Vector Syntax

table bmflow(*,*)  Benchmark flows (in value terms)
		 x	 y	  w	cons
	x      100	       -100
	y	       100     -100
	w			200	-200
	l      -20     -60		  80
	k      -60     -40		 100
	tax    -20	 0		  20

set	i	Goods index	/ x, y /
	f	Factors index	/ l, k /;
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
display "@ Increase the endowment.";

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

display "@ Program ends here.";

* --------------------
* Local Variables:
* fill-column: 80
* End:
