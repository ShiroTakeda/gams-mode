* gams-master-file: ../sample.gms
$ontext
Copyright (C)   2003 Shiro Takeda
Time-stamp: 	<2014-08-31 17:04:57 straycat>
Filename:	include-sample.gms
Author: 	Shiro Takeda
First-written:	<2003/05/19>

[Note]

	* gams-master-file: gams-sample.gms

The line like this is the specification of the master gms file (the top-level
gms file). This indicates this "include-sample.gms" file is the subroutine file
of "gams-sample.gms".

This master file information is used for `gams-show-identifier' and
`gams-show-identifier-list' commands. For example, type F7 on parameter `a'
below. GAMS mode recongnizes that the top-level file is "gams-sample.gms" and
shows the declaration part of `a' in "gams-sample.gms" file.

$offtext

*	Type F7 on `a'.  It is declared in "gams-sample.gms" file.
display a;

set	sec	Sector index		/ i1*i100 /
	com	Commoditiy index	/ j1*j100 /;
display sec,com;

parameter
	ene(com,sec)	Energy consumption
	op(sec)		Output
	util		Utility;
ene(com,sec) = 0;
op(sec) = 100;
util = 0;
display ene, op, util;

$include ./include/include-sample-2.gms

m = 100;
n = 200;

display m, n;

* --------------------
* Local Variables:
* mode: gams
* fill-column: 80
* End:
