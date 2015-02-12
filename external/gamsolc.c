/*
  gamsolc.c	C program for making the item alist in GAMS-OUTLINE mode

  Copyright (C) 2002 Shiro Takeda

  Version: 1.8
  $Id: gamsolc.c,v 1.2 2008/03/29 04:35:10 st Exp $
  Time-stamp: <2008-03-29 13:32:50 Shiro Takeda>

  Author: Shiro Takeda
  Maintainer: Shiro Takeda
  First Created: Sun Oct 20 2002 12:48 PM
  Copyright (C) 2001, 2002 Shiro Takeda

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2, or (at your option)
  any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  A copy of the GNU General Public License can be obtained from this
  program's author or from the Free Software Foundation,
  Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


  Description:

  This program is used for making the item alist in GAMS-OUTLINE mode.
  This is called through `gams-ol-make-alist-external'.


  Compilation etc.:

  The binary file (gamsolc.exe) is compiled with Borland C++Builder
  command line tool on MS Windows 2000

  % bcc32 -w -O2 gamsolc.c

  Borland C++Builder command line tool is freely available at the Borland
  web site.  I have tested this program only on Windows Me/2000.  I don't
  know if the binary works on other Windows platforms.

  I also checked that I can compile this source with GNU gcc

  % gcc -O3 gamsolc.c -o gamsolc

  If you compile this file, put this file and emacs-regex.h (which is
  distributed with this file) at the same directory.  emacs-regex.h is the
  same as regex.h that is distributed with GNU Emacs.  I just renamed it.


  Usage:
  gamsolc.exe [lst file] [output file]

  You need to give two file name.
  
*/

#include <stdio.h>
#include <stdlib.h>		/* for exit */
#include <string.h>		/* for strncmp */
#include <sys/types.h>
#include "./emacs-regex.h"	/* for regular expression handling */

#define PAGEW 256

extern char gamsver[]="1.8";	/* Version number */

/* Prototype */
void usage (void);

/* Main function */
int main(int argc, char *argv[]){

  /* Variable declaration . */
  char *regex_str_par;
  char *regex_str_vri;
  char *regex_str_vre;
  char *regex_str_var;
  char *regex_str_set;
  char *regex_str_equ;
  char *regex_str_oth;
  char *regex_str_loo;
  char *regex_str_sum;
  char *regex_str_rep;
  char *regex_str_com;
  char *regex_str_irr;

  char *regex_str_loo_sub;
  char *regex_str_sum_sol;
  char *regex_str_sum_mod;
  char *regex_str_rep_sub;
  char *regex_str_rep_sub2;
  char *regex_str_par_sub;
  char *regex_str_vri_sub;
  char *regex_str_vre_sub;

  char *regex_str_emp;
  char *regex_str_tmp1;
  char *regex_str_tmp2;

  char line[PAGEW];
  FILE *fin;
  FILE *fout;

  regex_t preg_par;
  regex_t preg_vri;
  regex_t preg_vre;
  regex_t preg_var;
  regex_t preg_set;
  regex_t preg_equ;
  regex_t preg_oth;
  regex_t preg_loo;
  regex_t preg_sum;
  regex_t preg_rep;
  regex_t preg_com;
  regex_t preg_irr;

  regex_t preg_loo_sub;
  regex_t preg_sum_sol;
  regex_t preg_sum_mod;
  regex_t preg_rep_sub;
  regex_t preg_rep_sub2;
  regex_t preg_par_sub;
  regex_t preg_vri_sub;
  regex_t preg_vre_sub;

  regex_t preg_emp;
  regex_t preg_tmp1;
  regex_t preg_tmp2;

  regmatch_t pmatch[10];

  int linum, count, flag;

  linum=0;
  count=0;
  flag=1;
  
  /*   Regular expressions. */
  regex_str_par
    = "^----[ ]+[0-9]+ PARAMETER[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_par_sub
    = "^[ ]+PARAMETER[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_vri = "^----[ ]+[0-9]+ VARIABLE[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_vri_sub = "^[ \t]+VARIABLE[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_vre = "^----[ ]+[0-9]+ EQUATION[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_vre_sub = "^[ \t]+EQUATION[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_set = "^----[ ]+[0-9]+ SET[ ]+([^ \n\r]+)[ ]*([^\n\r]*)";
  regex_str_var = "^----[ ]+VAR[ ]+([^ \n\r]+)[ ]*([^\n\r]*)";
  regex_str_equ = "^----[ ]+EQU[ ]+([^ \n\r]+)[ ]*([^\n\r]*)";
  regex_str_oth = "^----[ ]+[0-9]+[ ]+([^\n\r]*)";
  regex_str_loo = "^[ ]+L O O P S[ ]+([^ \n\r]+)[ ]+([^\n\r]+)";
  regex_str_loo_sub = "^[ ]+([^ \n\r]+)[ ]+([^\n\r]+)";
  regex_str_rep = "REPORT SUMMARY :[ ]+([0-9])";
  regex_str_rep_sub = "^[ ]+([0-9]+)[ ]+[^\n\r]+";
  regex_str_rep_sub2 = "^[ ]+([A-Za-z]+)[ ]+";
  regex_str_sum = "^               S O L V E      S U M M A R Y";
  regex_str_sum_sol = " SOLVER STATUS[ ]+([0-9]*)";
  regex_str_sum_mod = " MODEL STATUS[ ]+([0-9]*)";
  regex_str_com = "^----[ ]+[0-9]+[ ]+com:[ ]*([^\n\r]*)";
  regex_str_irr = "^[A-Za-z0-9\n\r\f]+";
  regex_str_emp = "^[\n\r\f\r]";
  regex_str_tmp1 = "^[^ *-]+";
  regex_str_tmp2 = "^----[ ]+";

  /* Determin from where to read */
  if (argc!=3 && argc!=2){
    usage();
    exit(1);
  }
  if((fin=fopen(argv[1],"r"))==NULL){
    printf("Cannot open the input file.\n");
    exit(1);
  }
  if(argc==3 && (fout=fopen(argv[2],"w"))==NULL){
    printf("Cannot open the output file.\n");
    exit(1);
  }
  if (argc == 2) {
    fout=stdout;
  }
  
  /* Compile regular expression */
  regcomp(&preg_par, regex_str_par, REG_EXTENDED);
  regcomp(&preg_vri, regex_str_vri, REG_EXTENDED);
  regcomp(&preg_vre, regex_str_vre, REG_EXTENDED);
  regcomp(&preg_var, regex_str_var, REG_EXTENDED);
  regcomp(&preg_set, regex_str_set, REG_EXTENDED);
  regcomp(&preg_equ, regex_str_equ, REG_EXTENDED);
  regcomp(&preg_oth, regex_str_oth, REG_EXTENDED);
  regcomp(&preg_loo, regex_str_loo, REG_EXTENDED);
  regcomp(&preg_sum, regex_str_sum, REG_EXTENDED);
  regcomp(&preg_rep, regex_str_rep, REG_EXTENDED);
  regcomp(&preg_com, regex_str_com, REG_EXTENDED);
  regcomp(&preg_irr, regex_str_irr, REG_EXTENDED);
  regcomp(&preg_loo_sub, regex_str_loo_sub, REG_EXTENDED);
  regcomp(&preg_sum_sol, regex_str_sum_sol, REG_EXTENDED);
  regcomp(&preg_sum_mod, regex_str_sum_mod, REG_EXTENDED);
  regcomp(&preg_rep_sub, regex_str_rep_sub, REG_EXTENDED);
  regcomp(&preg_rep_sub2, regex_str_rep_sub2, REG_EXTENDED);
  regcomp(&preg_par_sub, regex_str_par_sub, REG_EXTENDED);
  regcomp(&preg_vri_sub, regex_str_vri_sub, REG_EXTENDED);
  regcomp(&preg_vre_sub, regex_str_vre_sub, REG_EXTENDED);
  regcomp(&preg_emp, regex_str_emp, REG_EXTENDED);
  regcomp(&preg_tmp1, regex_str_tmp1, REG_EXTENDED);
  regcomp(&preg_tmp2, regex_str_tmp2, REG_EXTENDED);
  
  fprintf(fout,"(setq gams-ol-alist-temp-alist '(\n");
  
  /* */
  while(NULL != fgets(line, PAGEW, fin)){
    linum++;
    if((0 == regexec(&preg_irr, line, 1, pmatch, 0))
       || (0 == regexec(&preg_tmp1, line, 1, pmatch, 0))) {
      /*       Do nothing */
      ;
    } else if(0 == regexec(&preg_tmp2, line, 9, pmatch, REG_NOTEOL)) {
      /*       Matched ^---- */
      if(0 == regexec(&preg_var, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"VAR\" \"%.*s\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);

      } else if(0 == regexec(&preg_equ, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"EQU\" \"%.*s\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);

      } else if(0 == regexec(&preg_par, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"PAR\" \"%.*s\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	/* sub process */
	while(flag == 1) {
	  fgets(line, PAGEW, fin);
	  linum++;
	  if(0 == regexec(&preg_par_sub, line, 9, pmatch, REG_NOTEOL)){
	    count++;
	    fprintf(fout,"(%i %i \"PAR\" \"%.*s\" \"%.*s\")\n",
		    count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		    pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	  } else if(0 != regexec(&preg_emp, line, 0, pmatch, 0)) {
	    ;
	  } else { flag = 0; }
	}
	flag = 1;

      } else if(0 == regexec(&preg_vri, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"VRI\" \"%.*s\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	/* sub process */
	while(flag == 1) {
	  fgets(line, PAGEW, fin);
	  linum++;
	  if(0 == regexec(&preg_vri_sub, line, 9, pmatch, REG_NOTEOL)){
	    count++;
	    fprintf(fout,"(%i %i \"VRI\" \"%.*s\" \"%.*s\")\n",
		    count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		    pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	  } else if(0 != regexec(&preg_emp, line, 0, pmatch, 0)) {
	    ;
	  } else { flag = 0; }
	}
	flag = 1;

      } else if(0 == regexec(&preg_vre, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"VRI\" \"%.*s\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	/* sub process */
	while(flag == 1) {
	  fgets(line, PAGEW, fin);
	  linum++;
	  if(0 == regexec(&preg_vre_sub, line, 9, pmatch, REG_NOTEOL)){
	    count++;
	    fprintf(fout,"(%i %i \"VRI\" \"%.*s\" \"%.*s\")\n",
		    count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		    pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	  } else if(0 != regexec(&preg_emp, line, 0, pmatch, 0)) {
	    ;
	  } else { flag = 0; }
	}
	flag = 1;

      } else if(0 == regexec(&preg_set, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"SET\" \"%.*s\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);

      } else if(0 == regexec(&preg_com, line, 4, pmatch, 0)){
	count++;
	fprintf(fout,"(%i %i \"COM\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so]);

      } else if(0 == regexec(&preg_oth, line, 9, pmatch, REG_NOTEOL)){
	count++;
	fprintf(fout,"(%i %i \"OTH\" \"\" \"%.*s\")\n",
		count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so]);
      }

    } else if(0 == regexec(&preg_loo, line, 9, pmatch, REG_NOTEOL)){
      count++;
      fprintf(fout,"(%i %i \"LOO\" \"%.*s\" \"%.*s\")\n",
	      count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
	      pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
      /* sub process */
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if(0 == regexec(&preg_loo_sub, line, 9, pmatch, REG_NOTEOL)){
	  count++;
	  fprintf(fout,"(%i %i \"LOO\" \"%.*s\" \"%.*s\")\n",
		  count, linum, pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so],
		  pmatch[2].rm_eo-pmatch[2].rm_so, &line[pmatch[2].rm_so]);
	} else { flag = 0; }
      }
      flag = 1;

    } else if(0 == regexec(&preg_sum, line, 0, pmatch, 0)){
      count++;
      fprintf(fout,"(%i %i ", count, linum);
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if(0 == regexec(&preg_sum_sol, line, 9, pmatch, REG_NOTEOL)){
	  fprintf(fout,"\"SUM\" \"SOLVE SUMMARY\" \"SOLVER STATUS = %.*s, ",
		  pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so]);
	  
	} else if(0 == regexec(&preg_sum_mod, line, 9, pmatch, REG_NOTEOL)){
	  fprintf(fout,"MODEL STATUS = %.*s\")\n",
		  pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so]);
	  flag = 0;
	}
      }
      flag = 1;

    } else if(0 == regexec(&preg_rep, line, 9, pmatch, REG_NOTEOL)){
      count++;
      fprintf(fout,"(%i %i \"SUM\" \"REPORT SUMMARY\" \"[%.*s",
	      count,linum,pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so]);
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if(0 == regexec(&preg_rep_sub, line, 9, pmatch, REG_NOTEOL)){
	  fprintf(fout,", %.*s",
		  pmatch[1].rm_eo-pmatch[1].rm_so, &line[pmatch[1].rm_so]);
	} else if (0 == regexec(&preg_rep_sub2, line, 0, pmatch, REG_NOTEOL)) {
	  ;
	} else {
	  fprintf(fout,"]\")\n");
	  flag = 0;
	}
      }
      flag = 1;
    }
  }
  fprintf(fout,"))\n");
  fclose(fin);
  fclose(fout);
  return (0);
}

void usage(void){
  fprintf(stderr,
	  "gamsolc version %s, Shiro Takeda, 2003\n"
	  "Usage: gamsolc LST-file [output-file]\n",gamsver);
  exit(0);
}
