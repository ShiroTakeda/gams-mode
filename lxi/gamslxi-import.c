/*
  gamslxi-import.c	C program for importing the content of the LXI file.

  Copyright (C) 2009 Shiro Takeda <shiro.takeda@gmail.com>

  Version: 1.0
  $Id: gamslxi-import.c,v 1.1 2009/06/15 17:13:18 st Exp $
  Time-stamp: <2009-06-15 23:45:59 Shiro Takeda>

  Author: Shiro Takeda
  Maintainer: Shiro Takeda
  First Created: Wed Dec 10 2008
  Copyright (C) 2008-2009 Shiro Takeda

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2, or (at your option)
  any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  A copy of the GNU General Public License can be obtained from this
  program's author (send electronic mail to
  shiro.takeda@gmail.com) or from the Free Software Foundation,
  Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


  Description:

  This program is used for importing the content of the LST file.

  Compilation etc.:

  The binary file (gamslxi-import.exe) is compiled with Borland C++Builder
  command line tool on MS Windows XP

  % bcc32 -w -O2 gamslxi-import.c

  Borland C++Builder command line tool is freely available at the Borland
  web site.  I have tested this program only on Windows XP.  I don't
  know if the binary works on other Windows platforms.

  Usage:

  gamslxi-import.exe beg end input_file

  beg:
  end:
  input_file:

*/

#include <stdio.h>
#include <string.h>		/* For strlen */
#include <stdlib.h>		/* atoi */

#define PAGEW 256

int main(int argc, char *argv[]){

  char line[PAGEW];
  FILE *fin;
  FILE *fout;
  int linum = 0;
  int beg;
  int end;

  fin = fopen(argv[3],"r");
  fout = stdout;

  beg = atoi(argv[1]);
  end = atoi(argv[2]);

  while (NULL != fgets(line, PAGEW, fin)) {
    linum++;
    if ((linum >= beg) && (linum <= end)) {
      fprintf(fout,"%s", line);
    } else if (linum > end) {
      break;
    }
  }
  fclose(fin);
  fclose(fout);
  return (0);
}

