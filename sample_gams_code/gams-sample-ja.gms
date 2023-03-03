$title GAMS mode for Emacsの使い方を説明するためのサンプルプログラム
$ontext
Filename:       "gams-sample-ja.gms"
Author:         Shiro Takeda
First-written:  <2001/08/13>
$offtext

*       ----------------------------------------------------------------------
$stitle         LST ファイルの名前と場所の指定:
$ontext
以下のコードは、LST ファイルの名前と場所を指定するためのものです。指定を有効にす
るには、先頭の「**」のうちの一つを除去してください。
$offtext
** gams-lst-file: ./lst/lst-sample.lst
*       この指定では LST ファイルは→のようになります -> ./lst/sample.lst:

** gams-lst-file: g:/sample.lst
*       この指定では LST ファイルは→のようになります -> g:/sample.lst:

** gams-lst-dir: ./lst/
*       この指定では LST ファイルは→のようになります -> ./lst/gams-sample.lst

** gams-lst-dir: g:/
*       この指定では LST ファイルは→のようになります -> g:/gams-sample.lst

$ontext
解説：

  * gams-mode.el version 6.12 用の説明．

  * Emacs の操作の基本的なことについては，Emacs のメニューのヘルプ→ Emacs
    tutorial を読んでください．

  * 「バッファ」，「エコーエリア」，「ウィンドウ」等の Emacs の用語についても
    tutorialを参照してください．

  * "C-cC-v"のような表記は通常の Emacs の説明と同じような意味を表します．例えば，

    `C-cC-v' -->  "Control key + c" を押して，その後 "Control + v" を押す
                   ということ．
    `M-q'    -->  "Alt key + q" を押すということです．

  * M-x describe-variable や M-x describe-function というコマンドにより変数や関
    数の説明を読むことができます．例えば，`gams-process-command-name' という変数
    の説明を読みたいときには

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
適切に設定されていれば，このバッファーのモードは GAMS modeになっているはずです
(モードラインに GAMS という文字があれば，GAMS mode になっています)． GAMS modeに
なっていない場合には "~/.emacs.d/init.el" ファイルの設定 (特にload-path の設定)
をもう一度チェックしてください．

        ----------------------------------------------------------------------
$offtext
$stitle        基本的な利用法
$ontext
        ----------------------------------------------------------------------

まず，このファイルに対して GAMS を実行してみます．`C-cC-t'とタイプしてください．
エコーエリア（ミニバッファー）に次のようなメッセージがでるはずです．


    Start GAMS (s), Kill GAMS process (k), Change GAMS command (c), Change options (o).


ここで `s' を押すと下側にウィンドウが開き，GAMS が実行されます．または，[F9]か
`C-cC-s' を押しても同じように GAMS がスタートします．

「注」 GAMS がスタートしない，あるいは上手く実行されないときには，適切な設定がさ
れていないはずです．次の点をチェックしてください．

  + shell (cmdproxy や bash) を適切に設定していますか？

  + 変数 `gams-process-command-name' が適切に設定されていますか？ GAMS のシステ
    ムフォルダにパスを通していないのなら，変数 `gams-process-command-name' に
    gams.exe へのフルパスを指定しないといけないです．

GAMSのプロセスが終了したら，`C-cC-v' か [F10] を押してください．これで LSTファイ
ルに移動します．

LSTファイルを開いたら，"No error message is found" というメッセージがエコーエリア
に出るはずです．これはこの gms ファイルがエラーがなく上手く実行されたということ
を意味します．

ここで，`i' (か `b') を押すと，元の GMS ファイルのバッファーに戻ります．

次に，以下にある * で始まる行の * を消去して，GAMS を実行してください(`C-cC-t'
を押し，`s' を押す)．

$offtext
*               この行のコメントをとってください．エラーの位置．
$ontext
実行したら，LSTファイルに移動してください (C-cC-v か F10)．すると，エコーエリア
に次のようなメッセージが表示されます．

    Key: [u]=Jump to the error place, [i]=Jump to the main input file.

さらに、LST ファイルのウィンドウに次のように表示されるはずです．


     108                 この行のコメントをとってください．エラーの位置．
    ****                 $409
    **** 409  Unrecognizable item - skip to find a new statement
    ****        looking for a ';' or a key word to get started again
          実行したら，LSTファイルに移動してください (C-cC-v か F10)．すると，ウィンドウが
          二つに分割され，エコーエリアに次のようなメッセージが表示されます．

GAMS でエラーが生じているときには、「最初のエラー」に注目します．この例の場合は
「$409」のエラーになります。これは「Unrecognizable item」というエラーです（この
行．．．という文が GAMS には命令として認識できないというエラー）。

エラー箇所にエラー番号が表示され、さらにその下にエラーの意味が表示されます。また、
エラーの箇所の行番号も表示されます。このエラーでは「108」というのが行番号です。


LSTファイル内で `y' をタイプすると，最初のエラーの位置にジャンプします．

次に，LSTファイルで `u' をタイプしてください．GAMS ファイル内のエラーが置きてい
る位置にジャンプします．

以上の手順，つまり

 o GAMSを実行 (`F9' or `C-cC-s').
 o LSTファイルに移動 (`F10' or `C-cC-v').
 o エラーの位置，内容を確認．
 o GMSファイルのエラー箇所にジャンプ (`u')

を繰り返すことで，簡単に GMS ファイルをデバッグ (debug) することができます．


(*) `u' と `i' (or `b') の違い．

もしエラーが存在していたら，次のようなメッセージがエコーエリアに表示されます．


    Key: [u]=Jump to the error place, [i]=Jump to the main input file.


`u' ではエラーの位置にジャンプします． `i' ではインプットファイル (トップレベル
のプログラム) にジャンプします．

エラーはインプットファイルではなく，インプットファイルから読み込まれたサブルーチ
ンファイルで生じている場合があります．`u' を押すとインプットファイルであろうが，
サブルーチンファイルであろうが，とにかくエラーの場所にジャンプしますが，`i' では
インプットファイルにジャンプします．

インプットファイルの名前は LST ファイルの最下部にある FILE SUMMARY フィールドか
ら取得されます．


Syntax エラー以外のエラー (例えば、execution error) の場合には，エラー行しか表示
されないかもしれません．例えば，以下にある "* b = 1/a;" という行の先頭の * を除
去して，GAMS を実行して、LST ファイルに移動してください。
$offtext
parameter a       Parameter a
          b       Parameter b;
a = 0;
* b = 1/a;      # * を消してみてください．
parameter c, d, e;

$ontext

次の行で `l' をタイプしてください．


**** Exec Error at line 174: division by zero (0)


すると，エラー行 (174) にジャンプします．さらに，そこで `b' をタイプすれば，GMS
ファイル内のエラーの位置にジャンプします．

$offtext
*        ----------------------------------------------------------------------
$stitle         GAMS mode のその他のコマンド．
*        ----------------------------------------------------------------------

* ------------------
$stitle         プロセスについて．
* ------------------
$ontext

[コマンドラインの変更]

上で説明したように，`C-cC-ts' とタイプすることで，GAMS process を起動できます．
さらに，ユニバーサルアーギュメント (つまり，C-u) を付け加えた場合には，プロセス
を起動する前に，コマンドラインを修正することができます．

`C-uC-cC-t' とタイプしてください．


    Start GAMS (s), Kill GAMS process (k), Change GAMS command (c), Change options (o).


ここで `s' を押すと，次のようなメッセージがエコーエリアに表示されます．


    Edit command if you want:  gams gams-sample-ja.gms logOption=3 pageWidth=100


ここで自分の望む通りにコマンドラインを修正できます．例えば，


    Edit command if you want:  gams gams-sample-ja.gms logOption=3 pageWidth=160


と修正したとします．すると，この後以下のようなメッセージがでます．



    Use this command line also in the future?

ここで `y' と答えると，次のような行がこのファイルの第一行目に追加されます．


    *#!gams gams-sample-ja.gms logOption=3 pageWidth=160


次にGAMSを実行するときには，この行がそのままコマンドラインとしてシェルに渡されま
す (要するに，この行がコマンドラインとして，そのまま実行されるということ)．もし，
デフォールトのコマンドラインに戻したいときには，この行を消去してください．


[*#! 記法によるコマンドラインの指定]

GMS ファイルの最初の行に *#! で始まる表現があった場合，GAMS mode はその行をその
ままコマンドラインとして実行します．

例えば，一番最初の行に次のように書いてください．


        *#!c:/GAMS/42/gams.exe gams-sample.gms logOption=0 pageWidth=100 o=./gams-sample-alt.lst


すると，C-cC-s で


c:/GAMS/42/gams.exe gams-sample.gms logOption=0 pageWidth=100 o=./gams-sample-alt.lst


が，そのままコマンドラインとして実行されます．これはシェルスクリプトにおける
#!/usr/bin/perl や #!/bin/sh といった記法と同じような機能です．

GAMS mode が実行するコマンドラインは，デフォールトでは変数
`gams-process-command-name' と`gams-process-command-option' によって決定されます．
これは，デフォールトでは全てのファイルに同じコマンドラインが適用されるということ
を意味します．もし，ある特定のファイルについては，コマンドラインを変更したい場合
には，この "*#!" 記法を使うことで対処できます．


[GAMS のプロセスを kill する (停止させる) ]

GAMSのプロセスが走っているときに，`C-cC-tk' とタイプするとプロセスを停止させるこ
とができます．$ontext-$offtext に囲まれた部分のコードを実行して、以下の手順をお
こなってください。

 (1) `C-cC-t'
 (2) `s'
 (3) `C-cC-t' while a GAMS process running.
 (4) `k'

ontext-oftext のペアを除去するには ontext か offtext の上で `C-cM-c' を実行して
ください．
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

プロセスメニュー (C-cC-t) で `o' を押すことによりコマンドラインのオプションを変
更することができます．また，新たなオプションの組み合わせを登録しておくことができ
ます．

登録したオプションは `gams-statement-file' (で決定されるファイル) に保存されます．

デフォールトのオプションの組み合わせは変数 `gams-process-command-option' の値で
決定されます．


[GAMSのコマンドを変更する．]

プロセスメニュー (C-cC-t) で `c' を押すことにより GAMS のコマンドを変更すること
ができます．また，新たなコマンドを登録しておくことができます．

登録したオプションは `gams-statement-file' (で決定されるファイル) に保存されます．

デフォールトのオプションの組み合わせは変数 `gams-process-command-option' の値で
決定されます．

$offtext
* ------------------
$stitle         LST ファイルの名前と場所の指定
* ------------------
$ontext

GMS ファイルに GAMS を実行すると，GAMS ファイルと同じ名前 (拡張子部分のみ異なる)
の LST ファイルが同じフォルダに作成されます．しかし，LST ファイルの名前と場所を
自分で指定することもできます．

例えば，LST ファイルの名前を lst-sample.lst とし，さらにそれを doc というサブフォ
ルダに出力したいとします．その場合，GMS ファイルに次のような行を加えておきます．

        * gams-lst-file: ./doc/lst-sample-2.lst


(* は本当は行頭になくてはなりません)

このコードは次の二つの意味を持ちます．

1) GAMS が 'o=./doc/lst-sample.lst' というオプション付きで実行される．

2) この GMS ファイルから C-cC-v (or F10) キーで ./doc/lst-sample.lst に移動
   できます．

この機能を試しに利用してみたいときには，この GMS ファイルの始めのところにある
「** gams-lst-file:...」という行の行頭を「*」に変更してみてください。

同様に，`gams-lst-dir' を使えばLSTファイルを出力する「フォルダ」を指定できます．

例えば

        * gams-lst-dir: ./lst

というコードを加えると gams-sample.lst は "./lst/" というフォルダに出力されるこ
とになります．

$offtext
* ----------------------------
$stitle         GAMS の命令の補完入力．
* ----------------------------
$ontext

GAMS の命令を補完入力できます．`C-cC-k' とタイプしてください．すると，エコーエリア
に次のようなメッセージが表示されます．


    Insert statement (default = set):

ここで，space か tab キーを押すと，補完入力の候補が表示されます．ここでENTER を
押すとデフォールト値である set がそのまま入力されます．あるいは `v'を押して
space を押すと `VARIABLE' が自動的にエコーエリアに入力 (補完) されます．

同様に，dollar control option も補完入力できます．この場合は， `C-cC-d' をタイプ
してください．

さらに，既に入力されているコマンドの上で `C-uC-cC-k' or `C-uC-cC-d' を実行すると，
新しいコマンドに置き換えることができます．
$offtext

parameter       replace;        # `parameter' の上で C-uC-cC-k

$ontext

さらに，より多機能な `gams-insert-statement-extended' (C-cC-n) というコマンドも
あります．このコマンドでは model, solve, file, option, if, while, loop, put を入
力する際に，引数等を補完入力することができます．

$offtext
* -------------------------------------------
$stitle         新しいコマンドの登録
* -------------------------------------------
$ontext

デフォールトでは登録されていないコマンドを入力しようとした場合，それをその後も利
用できるように登録しておくことができます．例えば，`C-cC-d' で `gdxin' と入力して
ください．


    Insert dollar control (default = $abort): $gdxin


ここで enter を押すと，次のように聞かれます．


    Store `gdxin' for future use?  Type `y' if yes:


`y' を押せば dollar control `$gdxin' を登録することができます．登録されれば，補
完入力の候補の一つとして表示されるようになります．登録された命令が
"~/gams-statement.txt" ファイルに保存されます．もし，間違えて登録してしまった場
合には，"~/gams-statement.txt" を開いて消してください．

dollar control だけではなく statement (C-cC-k) の入力についても，同じように登録
できます．デフォールトの gams-mode.el には全ての命令は登録されていません．よく利
用する命令については自分で登録するようにしてください．

$offtext

* ---------------------------------------------------------
$stitle         GAMS mode での auto-complete mode の利用
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

* ---------------------------
$stitle         引用記号と括弧
* ---------------------------

$ontext

`gams-close-paren-always', `gams-close-double-quotation-always',
`gams-close-single-quotation-always' という変数に non-nil が設定されている場合に
は， ', ", ( をタイプすると，それに対応する ', ", ) を自動的に入力します．`(' に
ユニバーサルアーギュメントを付けると (つまり，C-u( とタイプすると),閉括弧は自動
では入力されません．

$offtext
* ---------------------------------------
$stitle         コメント用のテンプレートの入力
* ---------------------------------------
$ontext

他の人 (あるいは，あなた自身) が読み易いコードを書くには，コード内に適切なコメン
トを書いておく必要があります． `C-cC-o' でコメントのテンプレートを入力することが
できます．入力されるコメントのテンプレートは `gams-user-comment' という変数で決
定されます．

$offtext

* ---------------
$stitle         GAMS-TEMPLATE mode.
* ---------------
$ontext

GAMS-TEMPLATE mode (デフォールトでは `C-cC-e') によって様々なテンプレートを入力
することができます．

GAMS mode には `gams-template.txt' というサンプルのテンプレートファイル (テンプ
レートが登録されたファイル) が付属しています．これを "~/.emacs.d/" ディレクトリ
に保存しておいてください (あるいは `gams-template-file' という変数で指定)．
GAMS-TEMPLATE mode を使うには GAMS mode のバッファーで`C-cC-e' とタイプしてくだ
さい． GAMS-TEMPLATE mode 内のコマンドについては
*Template List* バッファーで `h' を押してください．

$offtext

* ----------------
$stitle         パラグラフの整形
* ----------------
$ontext

他のメジャーモードと同様に，GAMS mode でもパラグラフの整形ができます．次のパラグ
ラフにカーソルを置いて，`M-q' を押してください．


*       Put the cursor around here!  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph....


    Put the cursor around here!  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph.  This is a sample paragraph....



上のパラグラフはそれぞれ次のように整形されます．


*       Put the cursor around here!  This is a sample paragraph.  This is a
*       sample paragraph.  This is a sample paragraph.  This is a sample
*       paragraph.  This is a sample paragraph.  This is a sample paragraph.
*       This is a sample paragraph....


    Put the cursor around here!  This is a sample paragraph.  This is a sample
    paragraph.  This is a sample paragraph.  This is a sample paragraph.  This
    is a sample paragraph.  This is a sample paragraph.  This is a sample
    paragraph....

$offtext
* ---------------------
$stitle         コメントアウト
* ---------------------
$ontext

GAMS では行頭に * を付けることでコメントアウトする (コメント行にする) ことができ
ます． GAMS mode ではリージョンを選択して，C-cC-; をタイプすることでそのリージョ
ン全体をコメントアウトすることができます．コメントアウトされたリージョンを元に戻
す (* をとる) には，ユニバーサルアーギュメントを付けて C-cC-; を実行すればよい
(つまり，C-uC-cC-; とタイプする)．

$offtext

* gams-include-file: ./include/include-sample.gms
$include %sub_program%

* ---------------------
$stitle         Font-lock (色付け).
* ---------------------
$ontext

GAMS mode ではコードの色付けに対応しています (色付け機能は Emacs 用語でfont-lock
機能と言います)．

font-lock をオンにすると，GAMS の syntax に従いコードが自動で色付けされます．
font-lock をオンにするには "~/.emacs.d/init.el" ファイルに以下のコードを付け
加えておけばよいです．

(global-font-lock-mode t)


`gams-choose-font-lock-level' (binded to C-cC-f) を実行することで色付けのレベル
を変更することができます．

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

行数の多いファイルを開くときには，色付け処理のために非常に時間がかかるかもしれま
せん．その場合には色付けレベルを 1 にする (あるいは 0 にしておく) ほうがよいかも
しれません．

デフォールトの色付けレベルは `gams-font-lock-level', `gams-lst-font-lock-level',
`gams-ol-font-lock-level' という変数の値によって決まります．どれもデフォールトで
は 2 に設定されています．

また，`font-lock-fontify-block' という命令 (M-gM-g) によってカーソルの周りのブロッ
クの色付けをすることができます．自動で色付けされない場合には，この命令を実行して
みてください．

色付けの機能に問題がある場合には作者に連絡してください．

$offtext
* ---------------------------------------------
$stitle         identifier の宣言場所の表示
* ---------------------------------------------
$ontext

GAMS のプログラムを書いたり読んだりするときには， identifier (parameter,
variable, equation として宣言されたもの) の宣言をおこなっている部分を確認するこ
とがよくあると思います．そのような場合，例えば `isearch-backward' コマンド等の検
索用コマンドを利用し対処することができます．しかし，その identifier がプログラム
の様々な箇所に現れるとき，あるいは他のファイルで宣言しているときには，検索コマン
ドでは簡単に宣言部分を見つけられないでしょう．

`gams-show-identifier' (F7 or `C-cC-.') コマンドを使えば，identifier の宣言部分
を簡単に見つけることができます．以下の例を試してみてください．

$offtext

a = 1;                  # a の上で F7 を押す．
display a;              # a の上で F7 を押す．
u(k) = 1;               # u と k の上で F7 を押す．
p.fx(k) = 10;
display p.l;            # p の上で F7 を押す．

$ontext
例えば、`a' の上で F7 をタイプすると、上に `a' の宣言部分、左にはファイルの構造
が表示されます．

エコーエリアに次のような表示が現れます。

'u' is declared as parameter: [?]help,[d]ecl,[n]ext,[p]rev,[e]copy,[r]escan,[ ]restore,[ENT]jump,[TAB]jump+keep

ここで n (or p) をタイプすると次に (一個前に) a が現れる位置にジャンプします。d
をタイプすると宣言部分に移動します。また、c をタイプすると元々の位置に移動します。

スペースを押すと、元々のウィンドウの状態が回復されます。

詳しくは、? キーを押してください。


さらに、サブルーチンファイル内の宣言部分も表示されます。

試して、以下の "ene", "out", "util", "com", and "sec" の上で F7 を押してください。
"include-sample.gms" ファイル内の宣言部分が表示されます。

$offtext
display ene;            # Type F7 on the identifier ene
display op;             # Type F7 on the identifier out
display util;
display m, n;

ene(com,sec) = 100;
op(sec) = 1000;
display ene, op, sec, com;

$ontext

ユニバーサルアーギュメントを付けた場合 (i.e. C-uC-cC-.)、どの identifier を表示
するか聞かれます。

$offtext
* ---------------------------------------------
$stitle         identifier のリストの表示
* ---------------------------------------------
$ontext

`gams-show-identifier-list' (binded to `C-cC-a' by default) を使えば、現在のファ
イル内で定義されている identifier（sets, parameters, variables and so on）のリス
トを表示します。使い方は、 C-cC-a のあと? をタイプしてください。

この `gams-show-identifier-list' (C-cC-a) ではサブルーチンファイルで定義されてい
る identifier も表示されます．ただし、以下のような表現を使っている場合には、GAMS
mode は %sub_program% の実際の値がわからないので、サブルーチンファイル内を読むこ
とができません。

    $include %sub_program%

このような場合には、$include ファイル命令の前に以下のような命令を書くことで
「./include/include-sample.gms」というサブルーチンファイルを読むことが可能になり
ます。

    * gams-include-file: ./include/include-sample.gms
    $include %sub_program%

%sub_program% の中身は $set（あるいは、$setglobal）命令によって変わりますが、と
りあえずデフォールトで読み込んで欲しいファイルを、この gams-include-file で指定
しおくと良いです。

$offtext
* -----------------------------------
$stitle         ontext-offtext ペアに関するコマンド
* -----------------------------------
$ontext

`gams-insert-on-off-text' (binded to `C-cC-c' by default) は ontext-offtextを挿
入します。C-u を付けると (i.e. `C-uC-cC-c') リージョンを ontext-offtextで囲みま
す。

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
$stitle         ブロックの整形
* ---------------------------------------------------------
$ontext
`gams-align-block' (C-cC-y) によって table やその他のブロックの整形をすることが
できます。

[例1]

以下の table ブロックで Header line から終りまでのリージョンを選択し、C-cC-y ->
t -> 3 -> y とタイプしてみてください。すると数値の桁をそろえることができます。

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

また、以下のコードの `Start' から `End' の部分を選択し、C-cC-y -> o とタイプして
ください。「=」が揃うように整形されます。

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
=== Note === 自動インデントを上手く機能させるには，各ブロック(e.g. parameter,
table, set, display blocks etc.) がセミコロン (;) で終了している必要があります．
ブロックの終了を表すセミコロンは省略できる場合が多いですが，できるだけ省略しない
ようにしてください．

$offtext

* -------------
$stitle         マニュアルの呼出し．
* -------------
$ontext

GAMS Studio (あるいは、GAMSIDE) では HELP から GAMS のマニュアルを見ることができ
ます．GAMS mode でも `gams-view-document (C-cC-m) によって同じことができます．

GAMS modeのバッファーで `C-cC-m' を押してみてください。次のようなメッセージがエ
コーエリアに表示されます。

    Press ENTER key if you use online manual. Press other keys for offline manual.

ここで「エンターキー」を押すと、デフォールトのブラウザが GAMS のオンラインマニュ
アル（GAMS Documentation Center）を表示します。他のキーを押すと、ローカルのマニュ
アルを表示します。

さらに、マニュアルで命令を検索できます。例えば、以下のコードの `uniform' という
命令の上で `C-uC-cC-m' と押してください。すると、GAMS のオンラインマニュアルで
`uniform' という命令を検索した結果が表示されます（命令を直接検索する機能はオンラ
インのマニュアルでのみ使えまず）。

$offtext
loop((i,j),
    parb(i,j) = uniform(0,1); # `uniform' 命令の上で C-uC-cC-m を押してください。
);
$ontext

このコマンドを利用するには変数 `gams-docs-directory', `gams-docs-view-program'
が適切に設定されている必要があります．

$offtext
* ----------------------
$stitle         GAMS モデルライブラリ．
* ----------------------
$ontext

`gams-model-library' (C-cC-z) のよって GAMS モデルライブラリを見ることができます．
このコマンドを利用するには `gams-system-directory' に適切な値が設定されている必
要があります．

この機能は古いバージョンの GAMS 上では使えません（モデルライブラリのフォルダ構造
などが変わってしまったため）。

$offtext
* --------------------------------
$stitle         インライン・行末コメント
* --------------------------------
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

MPSGE ブロックでは "!" が常に end-of-line comment symbol として利用されます．

Try to type M-;, C-cM-;, or C-uC-;, C-uC-cM-; (note that eol and inline comment
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

$stitle        GAMS-OUTLINEモード．
*        ----------------------------------------------------------------------
$ontext

The GAMS-OUTLINE enables you to outline important components in the LST file.

You can learn the basic usage of GAMS-OUTLINE mode by reading a sample file
"outline-sample.gms" which is distributed with this file.

To start the GAMS-OUTLINE mode, type `o' in the LST file buffer.  Try to start
GAMS-OUTLINE mode on this file (run GAMS on this file and switch to the LST file
and type `o').  Or you can directly move to the GAMS-OUTLINE mode by typing
C-cC-i.

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
* fill-column: 80
* mode: gams
* coding: utf-8-dos
* End:

