# Perl script for making the item alist in GAMS-OUTLINE mode.
#
# Author: Shiro Takeda
# Maintainer: Shiro Takeda
# First Created: Sat Sep 14 2002 12:48 PM
# Copyright (C) 2001, 2002 Shiro Takeda
# $id:$

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# A copy of the GNU General Public License can be obtained from this
# program's author or from the Free Software Foundation,
# Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#
# Description:
#
# Perl script for making the item alist in GAMS-OUTLINE mode.  This script
# is called through `gams-ol-make-alist-external'.
#
#
# Configurations:
#
# You need to set the proper values to the following two variables in your
# "~/.emacs.el".
#
# The place of this perl script, for example:
# (setq gams-ol-external-program-name "c:/home/gams/gamsolperl.pl")
#
# The full path to perl program, for example:
# (setq gams-perl-command "c:/Perl/bin/perl.exe")
#
#
# Usage:
# perl gamsolperl.pl [lst file] [output file]
# 

$flag=1;
$count=0;
$index=0;
$name=0;
$cont=0;

$argn = ($fin, $fout) = @ARGV;
($argn == 2) or &bye("Arguments must be two\n");

open(IN, "$fin");
open(OUT, ">$fout");
select(OUT);

print "(setq gams-ol-alist-temp-alist '(\n";

while (<IN>) {
  chomp;
  s/[\r\n]*$//;
  if ((/^[^ *-]+/) or ($_ eq "")) {
    # Do nothing.
  } elsif (/^----[ \t]+/) {
    if (/^----[ \t]+[0-9]+ PARAMETER[ ]+([^ ]*)[ ]+[=]?[ ]*[+0-9.E-]*[ ]*(.*)/) {
      ++$count;
      $name=$1;
      $index="PAR";
      $cont=$2;
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
      while ($flag == 1) {
	$_=<IN>;
	chomp $_;
	$_=~ s/[\r\n]*$//;
 	if ($_ and (/[ \t]+PARAMETER[ ]+([^ ]*)[ ]+[=]?[ ]*[+0-9.E-]*[ ]*(.*)/)) {
	  ++$count;
	  $name=$1;
	  $index="PAR";
	  $cont=$2;
	  print "($count $.";
	  print " \"$index\"";
	  print " \"$name\"";
	  print " \"$cont\"";
	  print ")\n";
	} elsif ($_) {
	  # do nothing.
	} else {
	  $flag = 0;
	}
      }
      $flag = 1;
    } elsif (/^----[ \t]+[0-9]+ SET[ ]+([^ ]+)[ ]+(.*)/) {
      ++$count;
      $name=$1;
      $index="SET";
      $cont=$2;
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
      
    } elsif (/^----[ \t]+[0-9]+[ ]+VARIABLE[ ]+([^ ]+)[ ]+(.*)/) {
      ++$count;
      $name=$1;
      $index="VRI";
      $cont=$2;
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
      while ($flag == 1) {
	$_=<IN>;
	chomp $_;
	$_=~ s/[\r\n]*$//;
 	if ($_ and (/^[ \t]+VARIABLE[ ]+([^ ]+)[ ]+(.*)/)) {
	  ++$count;
	  $name=$1;
	  $index="VRI";
	  $cont=$2;
	  print "($count $.";
	  print " \"$index\"";
	  print " \"$name\"";
	  print " \"$cont\"";
	  print ")\n";
	} else {
	  $flag = 0;
	}
      }
      $flag = 1;
      
    } elsif (/^----[ \t]+[0-9]+ com:[ ]+(.*)/) {
      ++$count;
      $name=$1;
      $index="COM";
      $cont="";
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
    } elsif (/^----[ \t]+VAR[ ]+([^ ]+)[ ]+(.*)/) {
      ++$count;
      $name=$1;
      $index="VAR";
      $cont=$2;
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
    } elsif (/^----[ \t]+EQU[ ]+([^ ]+)[ ]+(.*)/) {
      ++$count;
      $name=$1;
      $index="EQU";
      $cont=$2;
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
    } elsif (/^----[ \t]+[0-9]+ (.*)/) {
      ++$count;
      $name="";
      $index="OTH";
      $cont=$1;
      print "($count $.";
      print " \"$index\"";
      print " \"$name\"";
      print " \"$cont\"";
      print ")\n";
    }
  } elsif (/\\*\\*\\* REPORT SUMMARY :[ ]+([0-9])/) {
    ++$count;
    $index="SUM";
    $name=$1;
    print "($count $.";
    print " \"$index\" ";
    print "\"REPORT SUMMARY\"";
    print " \"[$name";
    while ($flag == 1) {
      $_=<IN>;
      chomp $_;
      $_=~ s/^[\r\n\f]*$//;
      if (/^[ ]+([0-9]+)[ ]+[^ ]+/) {
	$name=$1;
	print ", $name";
      } elsif (/^[ ]+([a-zA-Z]+)/) {
	;
      } else {
	$name=$1;
	print "]\")\n";
	$flag = 0;
      }
    }
    $flag = 1;
  } elsif (/^               S O L V E      S U M M A R Y/) {
    $test4=$.;
    while ($flag == 1) {
      $_=<IN>;
      chomp $_;
      $_=~ s/[\r\n]*$//;
      if (/\\*\\*\\*\\* SOLVER STATUS[ ]+([0-9]*)/) {
	++$count;
	$index="SUM";
	$name=$1;
	print "($count $test4";
	print " \"$index\"";
	print " \"SOLVE SUMMARY\"";
      } elsif (/\\*\\*\\*\\* MODEL STATUS[ ]+([0-9]*)/) {
	$cont=$1;
	print " \"SOLVER STATUS = $name, MODEL STATUS = $cont\"";
	print ")\n";
	$flag = 0;
      }
    }
    $flag = 1;
  } elsif (/^               L O O P S[ ]+([^ ]+)[ ]+([^ ]+)/) {
    ++$count;
    $name=$1;
    $index="LOO";
    $cont=$2;
    print "($count $.";
    print " \"$index\"";
    print " \"$name\"";
    print " \"$cont\"";
    print ")\n";
      
    while ($flag == 1) {
      $_=<IN>;
      chomp $_;
      $_=~ s/[\r\n]*$//;
      if (/^[ ]+([^ ]+)[ ]+([^ ]+)/) {
	++$count;
	$name=$1;
	$index="LOO";
	$cont=$2;
	print "($count $.";
	print " \"$index\"";
	print " \"$name\"";
	print " \"$cont\"";
	print ")\n";
      } else {
	$flag = 0;
      }
    }
    $flag = 1;
  }
}

print "))\n";

close IN;
close OUT;
