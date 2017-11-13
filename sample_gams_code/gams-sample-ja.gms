$title GAMS mode for Emacsの使い方を説明するためのサンプルプログラム
$ontext
Time-stamp:     <2017-07-13 20:43:32 st>
Filename:       "gams-sample-ja.gms"
Author:         Shiro Takeda
First-written:  <2001/08/13>
$offtext

*       ----------------------------------------------------------------------
$stitle         LST ファイルの名前と場所の指定:
$ontext
以下のコードは、LST ファイルの名前と場所を指定するためのものです。指定を有効
にするには、先頭の「**」のうちの一つを除去してください。
$offtext
** gams-lst-file: .\lst\lst-sample.lst
*       この指定では LST ファイルは→のようになります -> .\lst\sample.lst:

** gams-lst-file: c:\sample.lst
*       この指定では LST ファイルは→のようになります -> c:\sample.lst:

** gams-lst-dir: .\lst\
*       この指定では LST ファイルは→のようになります -> .\lst\gams-sample.lst

** gams-lst-dir: c:\
*       この指定では LST ファイルは→のようになります -> c:\gams-sample.lst

$ontext
解説：

  * gams.el version 6.2 用の説明．

  * Emacs (or Meadow) の操作の基本的なことについては，Emacs のメニューのヘル
    プ→ Emacs tutorial を読んでください．

  * 「バッファ」，「ミニバッファ」，「ウィンドウ」等の Emacs の用語についても
    tutorialを参照してください．

  * "C-cC-v"のような表記は通常の Emacs の説明と同じような意味を表します．例
    えば，

    `C-cC-v' -->  "Control key + c" を押して，その後 "Control + v" を押す
                   ということ．
    `M-q'    -->  "Alt key + q" を押すということです．

  * M-x describe-variable や M-x describe-function というコマンドにより変数や
    関数の説明を読むことができます．例えば，`gams-process-command-name' とい
    う変数の説明を読みたいときには

    M-x describe-variable ENTER
    gams-process-command-name ENTER

    とタイプすればよいです．

  * バグの報告には M-x gams-report-bug コマンドを利用してください．

$offtext

*       これは Inline comment symbol の設定．
$inlinecom /* */
*       これは End-of-line comment symbol の設定．
$eolcom #

*       読み込むファイルの名前
$setglobal sub_program ./include/include-sample.gms

$ontext
適切に設定されていれば，このバッファーのモードは GAMS modeになっているはずで
す (モードラインに GAMS という文字があれば，GAMS mode になっています)． GAMS
modeになっていない場合には "~/.emacs.d/init.el" ファイルの設定 (特に
load-path の設定) をもう一度チェックしてください．

        ----------------------------------------------------------------------
$offtext
$stitle        基本的な利用法
$ontext
        ----------------------------------------------------------------------

まず，このファイルに対して GAMS を実行してみます．`C-cC-t'とタイプしてください．
ミニバッファーに次のようなメッセージがでるはずです．


    Start GAMS (s), Kill GAMS process (k), Change GAMS command (c), Change options (o).


ここで `s' を押すと下側にウィンドウが開き，GAMS が実行されます．または，[F9]
か `C-cC-s' を押しても同じように GAMS がスタートします．

「注」 GAMS がスタートしない，あるいは上手く実行されないときには，適切な設定
がされていないはずです．次の点をチェックしてください．

  + .init.el 内で shell (bash や cmdproxy) を適切に設定していますか？ 

  + 変数 `gams-process-command-name' が適切に設定されていますか？ GAMS のシス
  テムフォルダにパスを通していないのなら，変数 `gams-process-command-name' に
  gams.exe へのフルパスを指定しないといけないです．

GAMSのプロセスが終了したら，`C-cC-v' か [F10] を押してください．これで LSTファ
イルに移動します．

LSTファイルを開いたら，"No error message is found" というメッセージがミニバッ
ファーに出るはずです．これはこの gms ファイルがエラーがなく上手く実行された
ということを意味します．

ここで，`i' (か `b') を押すと，元の GMS ファイルのバッファーに戻ります．

次に，以下にある * で始まる行の * を消去して，GAMS を実行してください
(`C-cC-t' を押し，`s' を押す)．

$offtext
*               この行のコメントをとってください．エラーの位置．
$ontext
実行したら，LSTファイルに移動してください (C-cC-v か F10)．すると，ウィンドウ
が二つに分割され，ミニバッファーに次のようなメッセージが表示されます．

    Key: [u]=Jump to the error place, [i]=Jump to the main input file.

上のウィンドウはエラーの行，下のウィンドウはエラーの内容を表示します．

上のウィンドウは次のような表示になっているはずです．

        
              次に，以下にある * で始まる行の * を消去して，GAMS を実行してください
              (`C-cC-t' を押し， `s' を押す)．
               
         114               この行のコメントをとってください．エラーの位置．
         ***               $409
         *** LINE     86 INPUT       c:\WorkDir\gams\gams-sample-ja.gms
              実行したら，LSTファイルに移動してください (C-cC-v か F10)．すると，ウィンドウ
              が二つに分割され，ミニバッファーに次のようなメッセージが表示されます．


これは，ごく普通の構文エラー (syntax error) です．エラーの位置とエラー番号
(140) を示しています．

同時に下側のウィンドウはエラーの内容 (エラー番号 140 の意味) を表示します．
このケースは，"Unknown symbol" というエラーだということがわかります．


        409  Unrecognizable item - skip to find a new statement
                looking for a ';' or a key word to get started again

        **** 1 ERROR(S)   0 WARNING(S)
        GAMS 24.5.6  r55090 Released Nov 27, 2015 WEX-WEI x86 64bit/MS Windows                                   07/13/17 20:42:00 Page 28
        GAMS mode for Emacsの使い方を説明するためのサンプルプログラム
        Include File Summary


LSTファイル内で `y' をタイプすると，最初のエラーの位置にジャンプします．

次に，LSTファイルで `u' をタイプしてください．GAMS ファイル内のエラーが置きて
いる位置にジャンプします．

以上の手順，つまり

 o GAMSを実行 (`f9' or `C-cC-s').
 o LSTファイルに移動 (`f10' or `C-cC-v').
 o エラーの位置，内容を確認．
 o GMSファイルのエラー箇所にジャンプ (`u')

を繰り返すことで，簡単に GMS ファイルをデバッグ (debug) することができます．


(*) `u' と `i' (or `b') の違い．

もしエラーが存在していたら，次のようなメッセージがミニバッファーに表示されま
す．

    Key: `u' = Jump to the error place, `i' = Jump to the input file.


`u' ではエラーの位置にジャンプします． `i' ではインプットファイル (トップレベ
ルのプログラム) にジャンプします．

エラーはインプットファイルではなく，インプットファイルから読み込まれたサブルー
チンファイルで生じている場合があります．`u' を押すとインプットファイルであろ
うが，サブルーチンファイルであろうが，とにかくエラーの場所にジャンプします
が，`i' ではインプットファイルにジャンプします．

インプットファイルの名前は LST ファイルの最下部にある FILE SUMMARY フィールド
から取得されます．


Syntax エラー以外のエラー (例えば、execution) の場合には，エラー行しか表示さ
れないかもしれません．例えば，以下にある "* b = 1/a;" という行の先頭の * を除
去して，GAMS を実行して、LST ファイルに移動してください。
$offtext
parameter a       Parameter a
          b       Parameter b;
a = 0;
* b = 1/a;
parameter c, d, e;

$ontext

次の行で `l' をタイプしてください．


 *** Exec Error at line 197: division by zero (0)


すると，エラー行 (197) にジャンプします．さらに，そこで `b' をタイプすれ
ば，GMS ファイル内のエラーの位置にジャンプします．

$offtext
*        ----------------------------------------------------------------------
$stitle         GAMS mode のその他のコマンド．
*        ----------------------------------------------------------------------

* ------------------
$stitle         プロセスについて．
* ------------------
$ontext

[コマンドラインの変更]

上で説明したように，`C-cC-ts' とタイプすることで，GAMS process を起動できま
す．さらに，ユニバーサルアーギュメント (つまり，C-u) を付け加えた場合には，
プロセスを起動する前に，コマンドラインを修正することができます．

`C-uC-cC-t' とタイプしてください．


    Start GAMS (s), Kill GAMS process (k), Change GAMS command (c), Change options (o).


ここで `s' を押すと，次のようなメッセージがミニバッファーに表示されます．


    Edit command if you want:  gams gams-sample.gms ll=0 lo=3 pw=100


ここで自分の望む通りにコマンドラインを修正できます．例えば，


    Edit command if you want:  gams gams-sample.gms ll=0 lo=3 pw=120


と修正したとします．すると，この後以下のようなメッセージがでます．



    Use this command line also in the future?

ここで `y' と答えると，次のような行がこのファイルの第一行目に追加されます．


    *#!gams gams gams-sample.gms ll=0 lo=3 pw=120


次にGAMSを実行するときには，この行がそのままコマンドラインとしてシェルに渡さ
れます (要するに，この行がコマンドラインとして，そのまま実行されるというこ
と)．もし，デフォールトのコマンドラインに戻したいときには，この行を消去してく
ださい．


[*#! 記法によるコマンドラインの指定]

GMS ファイルの最初の行に *#! で始まる表現があった場合，GAMS mode はその行を
そのままコマンドラインとして実行します．

例えば，一番最初の行に次のように書いてください．


        *#!c:/GAMS/win64/24.6/gams.exe gams-sample.gms ll=0 lo=3 pw=100 o=.\gams-sample-alt.lst


すると，C-cC-s で


c:/GAMS/win64/24.6/gams.exe gams-sample.gms ll=0 lo=3 pw=100 o=.\gams-sample-alt.lst


が，そのままコマンドラインとして実行されます．これはシェルスクリプトにおける
#!/usr/bin/perl や #!/bin/sh といった記法と同じような機能です．

GAMS mode が実行するコマンドラインは，デフォールトでは変数
`gams-process-command-name' と`gams-process-command-option' によって決定され
ます．これは，デフォールトでは全てのファイルに同じコマンドラインが適用される
ということを意味します．もし，ある特定のファイルについては，コマンドラインを
変更したい場合には，この "*#!" 記法を使うことで対処できます．


[GAMS のプロセスを kill する (停止させる) ]

GAMSのプロセスが走っているときに，`C-cC-tk' とタイプするとプロセスを停止させ
ることができます．$ontext-$offtext に囲まれた部分のコードを実行して、以下の
手順をおこなってください。

 (1) `C-cC-t'
 (2) `s'
 (3) `C-cC-t' while a GAMS process running.
 (4) `k'

ontext-oftext のペアを除去するには ontext か offtext の上で `C-cM-c' を実行
してください．
$offtext

$ontext
*       Type `C-cM-c' on the above ontext!  To comment out them, type
*       the same.

set     o       /o1*o100000/;
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

[コマンドラインのオプションを変更する．]

プロセスメニュー (C-cC-t) で `o' を押すことによりコマンドラインのオプション
を変更することができます．また，新たなオプションの組み合わせを登録しておくこ
とができます．

登録したオプションは `gams-statement-file' (で決定されるファイル) に保存され
ます．

デフォールトのオプションの組み合わせは変数 `gams-process-command-option' の
値で決定されます．


[GAMSのコマンドを変更する．]

プロセスメニュー (C-cC-t) で `c' を押すことにより GAMS のコマンドを変更するこ
とができます．また，新たなコマンドを登録しておくことができます．

登録したオプションは `gams-statement-file' (で決定されるファイル) に保存され
ます．

デフォールトのオプションの組み合わせは変数 `gams-process-command-option' の
値で決定されます．

$offtext
* ------------------
$stitle         LST ファイルの名前と場所の指定
* ------------------
$ontext

GMS ファイルに GAMS を実行すると，GAMS ファイルと同じ名前 (拡張子部分のみ異な
る) の LST ファイルが同じフォルダに作成されます．しかし，LST ファイルの名前
と場所を自分で指定することもできます．

例えば，LST ファイルの名前を lst-sample.lst とし，さらにそれを doc というサブ
フォルダに出力したいとします．その場合，GMS ファイルに次のような行を加えてお
きます．

        * gams-lst-file: .\doc\lst-sample-2.lst


(* は本当は行頭になくてはなりません)

このコードは次の二つの意味を持ちます．

1) GAMS が 'o=.\doc\lst-sample.lst' というオプション付きで実行される．

2) この GMS ファイルから C-cC-v (or F10) キーで .\doc\lst-sample.lst に移動
   できます．

この機能を試しに利用してみたいときには，この GMS ファイルの 3 行目の行頭の
`**' を `*' に変更してください．

同様に，`gams-lst-dir' を使えばLSTファイルを出力する「フォルダ」を指定できます．

例えば

        * gams-lst-dir: .\lst

というコードを加えると gams-sample.lst は ".\lst\" というフォルダに出力され
ることになります．

$offtext
* ----------------------------
$stitle         GAMS の命令の補完入力．
* ----------------------------
$ontext

GAMS の命令を補完入力できます．`C-cC-k' とタイプしてください．すると，ミニバッ
ファーに次のようなメッセージが表示されます．


    Insert statement (default = set):

ここで，space か tab キーを押すと，補完入力の候補が表示されます．ここで
ENTER を押すとデフォールト値である set がそのまま入力されます．あるいは `v'
を押して space を押すと `VARIABLE' が自動的にミニバッファーに入力 (補完) され
ます．

同様に，dollar control option も補完入力できます．この場合は， `C-cC-d' をタ
イプしてください．

さらに，既に入力されているコマンドの上で `C-uC-cC-k' or `C-uC-cC-d' を実行す
ると，新しいコマンドに置き換えることができます．
$offtext

parameter       replace;        # `parameter' の上で C-uC-cC-k

$ontext

さらに，より多機能な `gams-insert-statement-extended' (C-cC-n) というコマンド
もあります．このコマンドでは model, solve, file, option, if, while, loop,
put を入力する際に，引数等を補完入力することができます．

$offtext
* -------------------------------------------
$stitle         新しいコマンドの登録
* -------------------------------------------
$ontext

デフォールトでは登録されていないコマンドを入力しようとした場合，それをその後
も利用できるように登録しておくことができます．
例えば，`C-cC-d' で `gdxin' と入力してください．


    Insert dollar control (default = $abort): $gdxin


ここで enter を押すと，次のように聞かれます．


    Store `gdxin' for future use?  Type `y' if yes: 


`y' を押せば dollar control `$gdxin' を登録することができます．登録されれば，
補完入力の候補の一つとして表示されるようになります．登録された命令が
"~/gams-statement.txt" ファイルに保存されます．もし，間違えて登録してしまった
場合には，"~/gams-statement.txt" を開いて消してください．

dollar control だけではなく statement (C-cC-k) の入力についても，同じように登
録できます．デフォールトの gams.el には全ての命令は登録されていません．
よく利用する命令については自分で登録するようにしてください．

$offtext

* ---------------------------
$stitle         引用記号と括弧
* ---------------------------

$ontext

`gams-close-paren-always', `gams-close-double-quotation-always',
`gams-close-single-quotation-always' という変数に non-nil が設定されている場
合には， ', ", ( をタイプすると，それに対応する ', ", ) を自動的に入力します．
`(' にユニバーサルアーギュメントを付けると (つまり，C-u( とタイプすると),
閉括弧は自動では入力されません．

$offtext
* ---------------------------------------
$stitle         コメント用のテンプレートの入力
* ---------------------------------------
$ontext

他の人 (あるいは，あなた自身) が読み易いコードを書くには，コード内に適切なコ
メントを書いておく必要があります． `C-cC-o' でコメントのテンプレートを入力す
ることができます．入力されるコメントのテンプレートは `gams-user-comment' とい
う変数で決定されます．

$offtext

* ---------------
$stitle         GAMS-TEMPLATE mode.
* ---------------
$ontext

GAMS-TEMPLATE mode (デフォールトでは `C-cC-e') によって様々なテンプレートを入
力することができます．

GAMS mode には `gams-template.txt' というサンプルのテンプレートファイル (テ
ンプレートが登録されたファイル) が付属しています．これを "~/.emacs.d/" ディ
レクトリに保存しておいてください (あるいは `gams-template-file' という変数で
指定)．GAMS-TEMPLATE mode を使うには GAMS mode のバッファーで`C-cC-e' とタイ
プしてください． GAMS-TEMPLATE mode 内のコマンドについては
*Template List* バッファーで `h' を押してください．

$offtext

* ----------------
$stitle         パラグラフの整形
* ----------------
$ontext

他のメジャーモードと同様に，GAMS mode でもパラグラフの整形ができます．次のパ
ラグラフにカーソルを置いて，`M-q' を押してください．


*       Put the cursor around here!  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph....


    Put the cursor around here!  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph....



上のパラグラフはそれぞれ次のように整形されます．


*       Put the cursor around here!  This is a sample paragraph.  This is a
*       sample paragraph.  This is a sample paragraph.  This is a sample
*       paragraph.  This is a sample paragraph.  This is a sample paragraph.
*       This is a sample paragraph....


    Put the cursor around here!  This is a sample paragraph.  This is a
    sample paragraph.  This is a sample paragraph.  This is a sample
    paragraph.  This is a sample paragraph.  This is a sample paragraph.
    This is a sample paragraph....

$offtext
* ---------------------
$stitle         コメントアウト
* ---------------------
$ontext

GAMS では行頭に * を付けることでコメントアウトする (コメント行にする) ことが
できます． GAMS mode ではリージョンを選択して，C-cC-; をタイプすることでその
リージョン全体をコメントアウトすることができます．コメントアウトされたリージョ
ンを元に戻す (* をとる) には，ユニバーサルアーギュメントを付けて C-cC-; を実
行すればよい (つまり，C-uC-cC-; とタイプする)．

$offtext

* gams-include-file: ./include/include-sample.gms
$include %sub_program%

* ---------------------
$stitle         Font-lock (色付け).
* ---------------------
$ontext

GAMS mode ではコードの色付けに対応しています (色付け機能は Emacs 用語で
font-lock 機能と言います)．

font-lock をオンにすると，GAMS の syntax に従いコードが自動で色付けされます．
font-lock をオンにするには "~/.emacs.d/init.el" ファイルに以下のコードを付け
加えておけばよいです．

(global-font-lock-mode t)


`gams-choose-font-lock-level' (binded to C-cC-f) を実行することで色付けのレベ
ルを変更することができます．

 0 => 色付けなし．
 1 => 最小限の色付け．
 2 => 最大限の色付け．

$offtext
*       Type `C-cC-f' and change the coloring level!

set    k       Index k                / 1,2 /
       l       Index l                / l1*l10 /;

parameter    s       Parameter s     / 1 /
             t       Parameter t     / 2 /
             u(k)    Parameter u;
u(k) = 1;

display "Parameter p/q", u;
display 'Single quote / p/q', u;

variable
    p(k)    Variable p;         # End-of-line comment.

equation
    eq_p(k) Equation;           /* Inline comment. */

eq_p(k) .. p(k) =e= u(k);

$ontext

行数の多いファイルを開くときには，色付け処理のために非常に時間がかかるかもし
れません．その場合には色付けレベルを 1 にする (あるいは 0 にしておく) ほうが
よいかもしれません．

デフォールトの色付けレベルは `gams-font-lock-level',
`gams-lst-font-lock-level', `gams-ol-font-lock-level' という変数の値によって
決まります．どれもデフォールトでは 2 に設定されています．

また，`font-lock-fontify-block' という命令 (M-gM-g) によってカーソルの周りの
ブロックの色付けをすることができます．自動で色付けされない場合には，この命令
を実行してみてください．

色付けの機能に問題がある場合には作者に連絡してください．

$offtext
* ---------------------------------------------
$stitle         identifier の宣言部分の表示
* ---------------------------------------------
$ontext

GAMS のプログラムを書いたり読んだりするときには， identifier (parameter,
variable, equation として宣言されたもの) の宣言をおこなっている部分を確認する
ことがよくあると思います．そのような場合，例えば `isearch-backward' コマンド
等の検索用コマンドを利用し対処することができます．しかし，その identifier が
プログラムの様々な箇所に現れるとき，あるいは他のファイルで宣言しているときに
は，検索コマンドでは簡単に宣言部分を見つけられないでしょう．

`gams-show-identifier' (F7 or `C-cC-.') コマンドを使えば，identifier の宣言部
分を簡単に見つけることができます．以下の例を試してみてください．

$offtext

a = 1;                  # a の上で F7 を押す．
display a;              # a の上で F7 を押す．
u(k) = 1;               # u と k の上で F7 を押す．
p.fx(k) = 10;
display p.l;            # p の上で F7 を押す．

$ontext
例えば、`a' の上で F7 をタイプすると、上に `a' の宣言部分、左にはファイルの構
造が表示されます．

ミニバッファーに次のような表示が現れます。

The declaration part of `a': [?]help,[d]ecl,[n]ext,[p]rev,[e]copy,[r]escan,[ ]restore,[ENT]jump

ここで n (or p) をタイプすると次に (一個前に) a が現れる位置にジャンプします。
d をタイプすると宣言部分に移動します。また、c をタイプすると元々の位置に移動
します。

スペースを押すと、元々のウィンドウの状態が回復されます。

詳しくは、? キーを押してください。


さらに、サブルーチンファイル内の宣言部分も表示されます。

試して、以下の "ene", "out", "util", "com", and "sec" の上で F7 を押してくだ
さい。"include-sample.gms" ファイル内の宣言部分が表示されます。

$offtext
display ene;            # Type F7 on the identifier ene
display op;             # Type F7 on the identifier out
display util;
display m, n;

ene(com,sec) = 100;
op(sec) = 1000;
display ene, op, sec, com;

$ontext

ユニバーサルアーギュメントを付けた場合 (i.e. C-uC-cC-.)、どの identifier を
表示するか聞かれます。

$offtext
* ---------------------------------------------
$stitle         identifier のリストの表示
* ---------------------------------------------
$ontext

`gams-show-identifier-list' (binded to `C-cC-a' by default) を使えば、
現在のファイル内で定義されている identifier のリストを表示します。
使い方は、 C-cC-a のあと ? をタイプしてください。

$offtext
* -----------------------------------
$stitle         ontext-offtext ペアに関するコマンド
* -----------------------------------
$ontext

`gams-insert-on-off-text' (binded to `C-cC-c' by default) は ontext-offtextを
挿入します。C-u を付けると (i.e. `C-uC-cC-c') リージョンを ontext-offtextで囲
みます。

Using `gams-jump-on-off-text' (`C-cC-g') on an ontext (offtext), you can
jump to the corresponding offtext (ontext).

Using `gams-comment-on-off-text' (`C-cM-c') on an ontext (offtext), you
can comment out or uncomment a pair of ontext-offtext.

Using `gams-remove-on-off-text' (`C-cM-g') on an ontext (offtext), you
can remove a pair of ontext-offtext.

$offtext
display "Try to type C-cC-c, C-uC-cC-c, C-cC-g, C-cM-c, and C-cM-g",
        "on a ontext or offtext!";

* ---------------------------------------------------------
$stitle         ブロックの整形
* ---------------------------------------------------------
$ontext
`gams-align-block' (C-cC-y) によって table やその他のブロックの整形をするこ
とができます。

[例1]

以下の table ブロックで Header line から終りまでのリージョンを選択し、C-cC-y
-> t -> 3 -> y とタイプしてみてください。すると数値の桁をそろえることができま
す。

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

[例 2]

また、以下のコードの `Start' から `End' の部分を選択し、C-cC-y -> o とタイプ
してください。「=」が揃うように整形されます。

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

* ----------------------
$stitle         自動インデント
* ----------------------
$ontext

GAMS のシンタックスに応じてコードを自動でインデントできます．

M-C-\        =       これはリージョンをインデント．
TAB          =       これはカレントラインをインデント．

以下の部分をリージョン指定して `M-C-\' をタイプしてみてください．

$offtext

*       ----------------------------------------------------------------------
*       ここから．
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
*       ここまで．
*       ----------------------------------------------------------------------

$ontext
=== Note === 自動インデントを上手く機能させるには，各ブロック
(e.g. parameter, table, set, display blocks etc.) がセミコロン (;) で終了し
ている必要があります．ブロックの終了を表すセミコロンは省略できる場合が多いで
すが，できるだけ省略しないようにしてください．

$offtext

* -------------
$stitle         マニュアルの呼出し．
* -------------
$ontext

GAMSIDE では HELP -> DOC から GAMS のマニュアル (PDFファイル) を見ることがで
きます．GAMS mode でも `C-cC-m' によって同じことができます．このコマンドを利
用するには変数 `gams-docs-directory', `gams-docs-view-program' が適切に設定さ
れている必要があります．

$offtext
* ----------------------
$stitle         GAMS モデルライブラリ．
* ----------------------
$ontext

`gams-modlib' (C-cC-z) のよって GAMS モデルライブラリを見ることができます．こ
のコマンドを利用するには `gams-system-directory' に適切な値が設定されている必
要があります．

$offtext
* --------------------------------
$stitle         インライン・行末コメント
* --------------------------------
$ontext

You can insert the inline and end-of-line comment by `gams-comment-dwim'
and `gams-comment-dwim-inline' (binded to M-; and C-cM-; respectively).

If the file includes $eolcom and $inlinecom dollar control options, the
end-of-line and inline comment symbols are determined by such values.

If $inlinecom or $eolcom do not exists in the file, `gams-comment-dwim'
and `gams-comment-dwim-inline' insert their default values determined by
the variables `gams-inlinecom-symbol-start-default',
`gams-inlinecom-symbol-end-default', and `gams-eolcom-symbol-default'.

If you attach the universal argument when executing `gams-comment-dwim'
and `gams-comment-dwim-inline', you are asked which symbol to be
inserted.

MPSGE ブロックでは "!" が常に end-of-line comment symbol として利用されます．

Try to type M-;, C-cM-;, or C-uC-;, C-uC-cM-;
(note that eol and inline comment symbols are already defined in this file)

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
* --------------------------------
$stitle         コメントのリージョンを隠す
* --------------------------------
$ontext

C-cC-h でコメントのリージョンを隠すことができます．

隠れたリージョンを再び表示させるにはもう一度 C-cC-h を押します．

$offtext
*        ----------------------------------------------------------------------

$stitle         GAMS LST mode におけるその他のコマンド．
*        ----------------------------------------------------------------------
$ontext

If you type `M-x help ENTER' and `m' in a LST file buffer, you can read
the simple explanation of GAMS LST mode (or type `?' in a LST file
buffer).  It is like this:

gams-lst-mode is an interactive Lisp function in `gams'.
(gams-lst-mode)

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

$stitle        GAMS-OUTLINEモード．
*        ----------------------------------------------------------------------
$ontext

The GAMS-OUTLINE enables you to outline important components in the LST
file.

You can learn the basic usage of GAMS-OUTLINE mode by reading a sample
file "outline-sample.gms" which is distributed with this file.

To start the GAMS-OUTLINE mode, type `o' in the LST file buffer.  Try to
start GAMS-OUTLINE mode on this file (run GAMS on this file and switch
to the LST file and type `o').  Or you can directly move to the
GAMS-OUTLINE mode by typing C-cC-i.

$offtext
display "";
display "@ これは gams-sample.gms ";
display "";
display "";
display "@ GAMS-OUTLINE mode は↓のような表示をできる．";
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

display "LSTファイル内の PARAMTERS は以下のような表示に:", x, y, z;
display "";
display "";
display "GAMS-OUTLINE モードについて詳しくは outline-sample.gms というサンプルのファイル";
display "or GAMS-OUTLINE mode のヘルプ (このバッファーで `?' を押す).";

display a;


* --------------------
* Local Variables:
* fill-column: 76
* mode: gams
* End:

