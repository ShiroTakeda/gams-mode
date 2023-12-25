$onDollar offDotL

  $$onDollar

Positive Variables
  a My text
  b "My text with quotes"
;

  
$if %system.fileSys% == UNIX $abort This code works only on Windows.

$ifThen.one x == y
display "it1";
$elseIf.one a == a
display "it2";
$ifThen.two c == c
display "it3";
$endIf.two
$elseIf.one b == b
display "it4";
$endIf.one

$ifThen not %gams.logOption% == 3
$  ifI %system.fileSys% == UNIX  $set nullFile > /dev/null
$  ifI %system.fileSys% == MSNT  $set nullFile > nul
$  if not set nullFile $abort %system.fileSys% not recognized
$else
$  set nullFile
$endIf
