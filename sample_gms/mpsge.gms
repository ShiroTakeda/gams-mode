$ontext

(defun gams-regexp-opt (strings &optional paren)
  (regexp-opt strings paren))

(defvar gams-mpsge-regexp
  (gams-regexp-opt
    gams-statement-mpsge t)
  "Regular expression for mpsge dollar control")

(gams-regexp-opt gams-statement-mpsge t)

(setq gams-mpsge-regexp_
  "\\(\\(?:auxiliary\\|co\\(?:mmodities\\|ns\\(?:traint\\|umers?\\)\\)\\|demand\\|model\\|prod\\|report\\|sectors?\\):\\)")

(looking-at (concat "^[$][ \t]*" gams-regexp-mpsge))

(looking-at gams-regexp-mpsge)

(looking-at gams-mpsge-regexp_)

(defvar gams-regexp-mpsge
  (concat (gams-regexp-opt gams-statement-mpsge t))
  "regular expression for mpsge type statements")

gams-regexp-mpsge
"\\(\\(?:auxiliary\\|co\\(?:mmodities\\|ns\\(?:traint\\|umers?\\)\\)\\|demand\\|model\\|prod\\|report\\|sectors?\\):\\)"

"\\(\\(?:AUXILIARY\\|CO\\(?:MMODITIES\\|NS\\(?:TRAINT\\|UMERS?\\)\\)\\|DEMAND\\|MODEL\\|PROD\\|REPORT\\|SECTORS?\\):\\)"

(let ((case-fold-search t)) (looking-at "ABC"))

abc


$offtext
parameter
    test
    test2
;

$ontext

$model:MONGOL

$sectors:
    Q(i)$vq0(i) 	! Production
    XD(i)$vq0(i)	! Export and domestic supply
    A(i)$va0(i)		! Armington aggregation
    C			! Consumption
    U			! Fictitious utility
    INV			! Investment
    EX(i)$vexp0(i)	! Export
    IM(i)$vimp0(i)	! Import
    KA$(not f_mk)	! Capital allocation
    LA$(not f_ml)	! Labor allocation

$commodities:
    PQ(i)$vq0(i) 	! Price of output
    PX(i)$vexp0(i)	! Export price
    PD(i)$vad0(i)	! Domestic price
    PA(i)$va0(i)		! Price index of Armington goods
    PC			! Price index of consumption
    PU			! Price of fictitious utility
    PINV		! Price index of investment
    PM(i)$vimp0(i)	! Price of imported goods
    PLS(i)$f_sl(i) 	! Wage rate
    PLU			! Wage rate
    PKS(i)$f_sk(i)	! Rental price
    PKU			! Rental price
    PFX			! Price of foreign exchange

$consumers:
    HH 			! Income of household

$auxiliary:    
    ESL$(fl_mw or fl_wc) ! Excess supply of labor
    UR$FL_wc		 ! Unemployment rate
    EXSUB(i)$fl_exp(i)	 ! Export subsidy
    ATAX(i)$fl_atax(i)	 ! Tax on animal

$prod:a
    i:
    o:
    

$offtext




* --------------------
* Local Variables:
* mode: gams
* fill-column: 80
* End:
