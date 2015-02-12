
$setglobal incf ./include/include-sample.gms

* gams-include-file: ./include/include-sample.gms
$include %incf%

* $if not incf=="0" $include ./include/include-sample.gms

parameter test;

test = 100;

display m, n;

* --------------------
* Local Variables:
* fill-column: 76
* End:
