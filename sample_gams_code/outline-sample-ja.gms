$title  GAMS-OUTLINE mode の説明のためのプログラム．
display "@ GAMS-OUTLINE mode の説明のためのプログラム．";
$ontext
Time-stamp:     <2017-07-15 12:52:51 st>
Filename:       outline-sample.gms
Author:         Shiro Takeda
First-written:  <2001/10/26>

[Note]:

  このプログラムは GAMS-OUTLINE mode の説明のためのプログラムです．

  このプログラムを GAMS で実行し， LST ファイル上で `o' をタイプしてください．
  GAMS-OUTLINE mode が起動します．

  【注】LST ファイルで日本語が文字化けする場合には pw オプションに十分大きい値を
  とって GAMS を実行してみてください．例: gams outline-sample-ja.gms pw=150

$offtext

display "";
display "@ このファイルは GAM-OUTLINE mode の説明のためのプログラムです．";
display "";
display "HELP を見るには `?' をタイプしてください．";
display "";
display "";
display "@ 記号の説明と基本的な用法";
display "";

*       ----------------------------------------------------------------------
*       表示される項目 (item) のタイプ．
display "表示される項目 (item) のタイプ．";
display "";
display "OTH (other) は文字列．";
display "`SET' は `set'";
display "PAR は `parameter'";
display "VAR は `VAR'";
display "EQU は `EQU'";
display "VRI は `VARIABLE'";
display "LOO は LOOPS";
display "SUM は SOLVE SUMMARY と REPORT SUMMARY";
display "[ と ] で囲まれているのは special comment line";
display "";
display "キー割当";
display "";
display "SPACE  = 現在の行の項目の内容を表示";
display "N      = 次の項目を表示";
display "P      = 一行前の項目を表示";
display "t      = 表示される項目の選択";
display "T      = 表示される項目の組み合わせを選択";
display "";
display "m      = 項目にマークする";
display "u      = マークを除去";
display "y      = マークされた項目にジャンプする";
display "";
display "i      = LST ファイルのバッファーに戻る";
display ";      = GMS ファイルのバッファーに戻る";
display "?      = ヘルプの表示";
display "q      = GAMS-OUTLINE mode を終了";
display "";
display "c      = フォローモードの切り替え";
display "x      = 表示スタイルの切り替え";
display "l      = ウィンドウを一行分拡大";
display "o      = ウィンドウを一行分縮小";
display "C-l    = リセンター";
display "";
display "RET    = スクロール・アップ";
display "DEL    = スクロール・ダウン";
display "n      = 一行下に移動";
display "p      = 一行上に移動";
display ",      = バッファーの先頭に移動";
display ".      = バッファーの終りに移動";
display "";
display "w      = フレームのサイズの変更";
display "e      = フレームの移動";
display "";
display "C-cC-f = font-lock のレベルの選択";
display "";
display "各コマンドを自分で試してみてください．";
display "他のキー割当についてはヘルプを見てください";

*       ----------------------------------------------------------------------
*       GAMS-OUTLINE mode で special comment line を表示したい場合には，GMS ファ
*       イルで以下のような形で display 命令と "@" を組み合わせます．
display "";
display "@ COMで始まる行は special comment line です．";
display ""
display "special comment line を表示させるには @ を display とともに利用します．";
display "書き方については GMS ファイルを見てください．";

*       ----------------------------------------------------------------------
*       例 1.
*       ----------------------------------------------------------------------
display "";
display "@ 例 1: 単純な例";
display "";

set
    iter Iteration index                /iter1*iter20/
;
parameter
    num             Iteration number
    a(iter)         Parameter a
    b(iter)         Parameter b
    c(iter,*)       Parameter for a and b;
a("iter1") = 0;

loop(iter,
    num = ord(iter);
    a(iter+1) = a(iter) + 3.14 * 0.01;
    b(iter+1) = sin(a(iter+1));
    c(iter+1,"a") = a(iter+1);
    c(iter+1,"b") = b(iter+1);
);

display "'PARAMTERS' は次のように表示されます", a, b, c;
display "";

*       ----------------------------------------------------------------------
*       例 2.
*       ----------------------------------------------------------------------
display "";
display "@ 例 2: ある一つの項目をマークし，二つの項目を同時に表示させる";
display "";
display "まずある行で `m' をタイプします．例えば，上の PAR a という行で `m' を";
display "タイプしてください．そして他の行，例えば下の here という項目の行に移動します．";
display "そこでスペースをタイプします．";
display "すると， 二つのウィンドウに二つの項目の内容が同時に表示されます．";
display "マークをとりたければ `u' をタイプします．";

parameter
    here    '上の "PAR  a" という行をマークし，それからこの行に移動してください．';

here = 0;
display "";
display here;
display "";

*       ----------------------------------------------------------------------
*       例 3.
*       ----------------------------------------------------------------------
display "";
display "@ 例 3: core and periphery モデル．表示される項目の変更をしてみる．";
display "";
display "この例ではいろいろな項目が表示されています．"
display "- VAR, EQU, PAR, SET, SUM, OTH, LOO, VRI, COM."
display "";
display "表示する項目を選択することができます．"
display "このバッファーで `t' をタイプしてください．すると SELECT-ITEM mode が起動します．"
display "";
display "さらに，表示する項目の組み合わせを登録しておくことができます．";
display "それには SELECT-ITEM mode で `a' をタイプしてください．";
display "";
display "組み合わせを登録したら `T' (gams-ol-item) をタイプすることで選択することができます．";
display "";

* The model presented in this example is the core-periphery model of Chap 5 in
* Fujita, Krugman, and Venables (1999) "Spatial Economy", MIT press.
set     itr     Times of iteration (lambda)             /iter1*iter11/
        tc      Times of iteration (transport cost)     /1*5/
        allo    Vector of omegas                        /omone, omtwo, omratio/;

parameters
    lowest  The lowest value of transport cost,
    highest The highest value of transport cost;
lowest = 1.3;
highest = 2;

*       Declare model parameters.
parameters
    mu      Expenditure share on manufactured goods,
    sig     Elasticity of subustitution,
    sigm    one minus sig,
    vt      Value of transport cost,
    lam     The share of workers in region one;

*       Declare endogenous variables.
variables
    wone    Nominal wage of region one,
    wtwo    Nominal wage of region two,
    omeone  Real wage of region one,
    ometwo  Real wage of region two,
    ratio   Ratio of real wage omeone devided by onetwo;

*       Declare equations.
equations
    weqone          Wage equation for wone,
    weqtwo          Wage equation for wtwo,
    rweqone         Real wage equation for omega one,
    rweqtwo         Real wage equation for omega two,
    eqratio         eq for RATIO;

*       Equation definitions:
weqone ..

    (wone**sig)
    =e= (mu *   lam * wone + (1-mu) /2)
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

*       Declare model.
model   fkv     Core and periphery model
        / weqone, weqtwo, rweqone, rweqtwo, eqratio /;

*       ----------------------------------------------------------------------
*       Insert numerical values in parameters.
mu = 0.4;
sig = 5;
sigm = 1 - sig;

parameter
    lambda          Value of lam,
    iterlog         Iteration log,
    log             Ratio of real wages in two regions;

parameters
    count1,
    count2;

*       Initial values parameters.
parameters
    wone0   Initial value
    wtwo0   Initial value
    omeone0 Initial value
    ometwo0 Initial value;

*       ----------------------------------------------------------------------
*       Loop.
display "@ Loop の始まり";

loop(tc,
    count2 = (ord(tc) - 1)/(card(tc) - 1);
    vt = (1-count2) * lowest + count2 * highest;

*       Set initial values of the first iteration (tc).
    wone0 = 2;
    wtwo0 = 2;
    omeone0 = 2;
    ometwo0 = 2;
    display tc;

    loop(itr,
        display itr;
        display "Current transport cost:", vt;

*       Determine `lam'.
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

        display wone.l, wone.lo, wone.up, wone.m, weqone.m, weqtwo.m;
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

display "ループの結果", log;
* $libinclude plot log

*       ----------------------------------------------------------------------
*       例 4.
*       ----------------------------------------------------------------------
display "";
display "";
display "@ 例 4: ベクトル変数";
display "";
display "";

*       Model M2-1s: Closed 2x2 Tax-Ridden Economy --  Vector Syntax
table bmflow(*,*)  Benchmark flows (in value terms)
               x       y        w     cons
x            100       0     -100        0
y              0     100     -100        0
w              0       0      200     -200
l            -20     -60        0       80
k            -60     -40        0      100
tax          -20       0        0       20
;
set     i       Goods index  /x, y/
        f       Factors index /l, k/;
alias (i,j)

parameter
    ybar(i)         Benchmark output levels
    fdbar(f,i)      Benchmark factor inputs
    cbar(i)         Benchmark final demand
    pbar(f,i)       Benchmark factor price
    endow0(f)       Factor endowments
    txf(f,i)        Ad-valorem tax rate on sector i inputs
    txo(i)          Proportioanl tax rate on sector i outputs
    ubar            Benchmark expenditure;

*       Extract values from the table:
ybar(i)         = bmflow(i,i);
fdbar(f,i)      = -bmflow(f,i);
cbar(i)         = -bmflow(i,"w");
ubar            = sum(i, cbar(i));
endow0(f)        = bmflow(f,"cons");

txf("l",i)      =  -bmflow("tax",i) / fdbar("l",i);
pbar(f,i)       = 1 + txf(f,i);
txo(i)          = 0;

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

*       ----------------------------------------------------------------------
*       賦存量の増加
display "@ 賦存量の増加";

set     sce     / sce1*sce10 /;
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

display "@ おしまい．";

* --------------------
* Local Variables:
* fill-column: 80
* mode: gams
* End:
