/*
  gamslxi.c	C program for making the LXI file from the LST file.

  Copyright (C) 2009-2018 Shiro Takeda <shiro.takeda@gmail.com>

  Version: 2.0
  $Id: gamslxi.c,v 1.1 2009/06/15 17:13:18 st Exp $
  Time-stamp: <2025-10-21 16:26:54 st>

  Author: Shiro Takeda
  Maintainer: Shiro Takeda
  First Created: Wed Dec 10 2008
  Copyright (C) 2008-2018 Shiro Takeda

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

  This program is used for making LXI file from LST file.
  This is called through `gams-lxi'.

  Compilation etc.:

  The binary file (gamslxi.exe) is compiled with embarcadero C++Builder command
  line tool on MS Windows 10

  % bcc32 -w -O2 gamslxi.c
  

  Embarcadero C++Builder command line tool (bcc32.exe) is included in
  "C++Compiler" downloadable from

  https://www.embarcadero.com/free-tools

  I have tested this program only on Windows 10.  I don't know if the binary
  works on other Windows platforms.

  Usage:
  gamslxi.exe [lst file] [output file]

  You need to give two file name.
  
*/

#include <stdio.h>
#include <stdlib.h>		/* for exit */
#include <string.h>		/* for strncmp */
#include <sys/types.h>
#include "./emacs-regex.h"	/* for regular expression handling */
/* #include <direct.h>		/\* for getcwd *\/ */


#define PAGEW 256

char gamsver[]="1.0";	/* Version number */

/* Prototype */
void usage (void);

/* Main function */
int main(int argc, char *argv[]){

  /* Variable declaration . */
  char line[PAGEW];
  FILE *fin;
  FILE *fout;

  char ma_l[PAGEW];
  int linum_l = 0;
  int len;
  char type_l[6];
  char type_ll[6];

  char i_type[6];
  
  char *regex_str_bar;
  char *regex_str_bar_num;
  char *regex_str_lf;

  char *regex_str_b_col;
  char *regex_str_b_mod;
  char *regex_str_b_sol;
  char *regex_str_b_equ;
  char *regex_str_b_com;
  char *regex_str_b_inc;
  char *regex_str_b_exe;
  char *regex_str_par;
  char *regex_str_var;
  char *regex_str_i_par;
  char *regex_str_i_par_s;
  char *regex_str_i_set;
  char *regex_str_i_set_s;
  char *regex_str_i_vri;
  char *regex_str_i_vri_s;
  char *regex_str_i_equ;
  char *regex_str_i_equ_s;
  char *regex_str_i_mod;
  char *regex_str_i_mod_s;
  char *regex_str_g_var;
  char *regex_str_f_equ;
  char *regex_str_emp;

  regex_t preg_bar;
  regex_t preg_bar_num;
  regex_t preg_lf;
  regex_t preg_b_col;
  regex_t preg_b_mod;
  regex_t preg_b_sol;
  regex_t preg_b_equ;
  regex_t preg_b_com;
  regex_t preg_b_inc;
  regex_t preg_b_exe;
  regex_t preg_par;
  regex_t preg_var;
  regex_t preg_i_par;
  regex_t preg_i_par_s;
  regex_t preg_i_set;
  regex_t preg_i_set_s;
  regex_t preg_i_vri;
  regex_t preg_i_vri_s;
  regex_t preg_i_equ;
  regex_t preg_i_equ_s;
  regex_t preg_i_mod;
  regex_t preg_i_mod_s;
  regex_t preg_f_equ;
  regex_t preg_g_var;
  regex_t preg_emp;

  regmatch_t pmatch[10];

  int linum, flag;

  linum = 0; 			/* Line number */
  flag = 1;

  /*   Regular expressions. */
  regex_str_bar = "^----[ ]+([^ ]+)";
  regex_str_bar_num = "^----[ ]+[0-9]+";
  regex_str_lf = "^\f";

  regex_str_b_col = "^(Column Listing[ ]+[^\n\r]+)";
  regex_str_b_mod = "^(Model Statistics[ ]+[^\n\r]+)";
  regex_str_b_sol = "^(Solution Report[ ]+[^\n\r]+)";
  regex_str_b_equ = "^(Equation Listing[ ]+[^\n\r]+)";
  regex_str_b_com = "^(C o m p i l a t i o n)";
  regex_str_b_inc = "^(Include File Summary)";
  regex_str_b_exe = "^(E x e c u t i o n)";
  regex_str_par = "^----[ ]+[0-9]+ PARAMETER[ ]+([^ \n\r]+)[ ]+([^\n\r]*)";
  regex_str_var = "^----[ ]+VAR[ ]+([^ \n\r]+)[ ]*([^\n\r]*)";
  regex_str_i_par = "^----[ ]+[0-9]+ PARAMETER[ ]+([^ ]+)";
  regex_str_i_par_s = "^[ ]+PARAMETER[ ]+([^ ]+)";
  regex_str_i_set = "^----[ ]+[0-9]+ SET[ ]+([^ ]+)";
  regex_str_i_set_s = "^[ ]+SET[ ]+([^ ]+)";
  regex_str_i_vri = "^----[ ]+[0-9]+ VARIABLE[ ]+([^ .]+)";
  regex_str_i_vri_s = "^[ ]+VARIABLE[ ]+([^ .]+)";
  regex_str_i_equ = "^----[ ]+[0-9]+ EQUATION[ ]+([^ .]+)";
  regex_str_i_equ_s = "^[ ]+EQUATION[ ]+([^ .]+)";
  regex_str_i_mod = "^----[ ]+[0-9]+ MODEL[ ]+([^ .]+)";
  regex_str_i_mod_s = "^[ ]+MODEL[ ]+([^ .]+)";
  regex_str_g_var = "^----[ ]+VAR[ ]+([^ ]+)";
  regex_str_f_equ = "^----[ ]+EQU[ ]+([^ ]+)";
  regex_str_emp = "^[\n\r\f]";

  /* Determin from where to read */
  if (argc!=3 && argc!=2){
    usage();
    exit(1);
  }
  if((fin=fopen(argv[1],"r"))==NULL){
    printf("Cannot open the input file %s.\n", argv[1]);
    exit(1);
  }
  if(argc==3 && (fout=fopen(argv[2],"w"))==NULL){
    printf("Cannot open the output file %s.\n",argv[2]);
    exit(1);
  }
  if (argc == 2) {
    fout=stdout;
  }

  /* Compile regular expression */
  regcomp(&preg_bar, regex_str_bar, REG_EXTENDED);
  regcomp(&preg_bar_num, regex_str_bar_num, REG_EXTENDED);
  regcomp(&preg_lf, regex_str_lf, REG_EXTENDED);
  regcomp(&preg_b_equ, regex_str_b_equ, REG_EXTENDED);
  regcomp(&preg_b_com, regex_str_b_com, REG_EXTENDED);
  regcomp(&preg_b_inc, regex_str_b_inc, REG_EXTENDED);
  regcomp(&preg_b_exe, regex_str_b_exe, REG_EXTENDED);
  regcomp(&preg_b_col, regex_str_b_col, REG_EXTENDED);
  regcomp(&preg_b_mod, regex_str_b_mod, REG_EXTENDED);
  regcomp(&preg_b_sol, regex_str_b_sol, REG_EXTENDED);
  regcomp(&preg_par, regex_str_par, REG_EXTENDED);
  regcomp(&preg_var, regex_str_var, REG_EXTENDED);
  regcomp(&preg_i_par, regex_str_i_par, REG_EXTENDED);
  regcomp(&preg_i_par_s, regex_str_i_par_s, REG_EXTENDED);
  regcomp(&preg_i_set, regex_str_i_set, REG_EXTENDED);
  regcomp(&preg_i_set_s, regex_str_i_set_s, REG_EXTENDED);
  regcomp(&preg_i_vri, regex_str_i_vri, REG_EXTENDED);
  regcomp(&preg_i_vri_s, regex_str_i_vri_s, REG_EXTENDED);
  regcomp(&preg_i_equ, regex_str_i_equ, REG_EXTENDED);
  regcomp(&preg_i_equ_s, regex_str_i_equ_s, REG_EXTENDED);
  regcomp(&preg_i_mod, regex_str_i_mod, REG_EXTENDED);
  regcomp(&preg_i_mod_s, regex_str_i_mod_s, REG_EXTENDED);
  regcomp(&preg_g_var, regex_str_g_var, REG_EXTENDED);
  regcomp(&preg_f_equ, regex_str_f_equ, REG_EXTENDED);
  regcomp(&preg_emp, regex_str_emp, REG_EXTENDED);

  strcpy(type_l,"Z");
  strcpy(type_ll,"Z");
  ma_l[0] = '\0';
  
  while(NULL != fgets(line, PAGEW, fin)){
    linum++;
    if ((0 == regexec(&preg_b_sol, line, 9, pmatch, REG_NOTEOL))
	&& (strcmp(i_type,"b_sol") != 0)) {

      fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      strcpy(type_ll,type_l);

      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';

      strcpy(i_type, "b_sol");

    } else if ((strcmp(i_type,"b_com") != 0)
	       && (0 == regexec(&preg_b_com, line, 9, pmatch, REG_NOTEOL))) {
      if (linum_l != 0) {
        fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      }
      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';

      strcpy(i_type, "b_com");

    } else if ((strcmp(i_type,"b_exe") != 0)
	       && (0 == regexec(&preg_b_exe, line, 9, pmatch, REG_NOTEOL))) {
      fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';

      strcpy(i_type, "b_exe");

    } else if ((strcmp(i_type,"b_inc") != 0)
	       && (0 == regexec(&preg_b_inc, line, 9, pmatch, REG_NOTEOL))) {
      fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';
      strcpy(i_type, "b_inc");

    } else if (0 == regexec(&preg_bar_num, line, 9, pmatch, REG_NOTEOL)){

      if ((0 == regexec(&preg_i_par, line, 9, pmatch, REG_NOTEOL))
	  || (0 == regexec(&preg_i_set, line, 9, pmatch, REG_NOTEOL))
	  || (0 == regexec(&preg_i_vri, line, 9, pmatch, REG_NOTEOL))
	  || (0 == regexec(&preg_i_equ, line, 9, pmatch, REG_NOTEOL))
	  || (0 == regexec(&preg_i_mod, line, 9, pmatch, REG_NOTEOL))) {

	if ((strcmp("I",type_ll) != 0)
	    || (strcmp("B",type_l) != 0)) {
	  fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
	}

	strcpy(type_ll,type_l);
	linum_l = linum;
	strcpy(type_l,"I");
	len = pmatch[1].rm_eo-pmatch[1].rm_so;
	memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
	ma_l[len] = '\0';
	strcpy(i_type, "");
      }
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if ((0 == regexec(&preg_i_par_s, line, 9, pmatch, REG_NOTEOL))
	    || (0 == regexec(&preg_i_set_s, line, 9, pmatch, REG_NOTEOL))
	    || (0 == regexec(&preg_i_vri_s, line, 9, pmatch, REG_NOTEOL))
	    || (0 == regexec(&preg_i_equ_s, line, 9, pmatch, REG_NOTEOL))
	    || (0 == regexec(&preg_i_mod_s, line, 9, pmatch, REG_NOTEOL))) {

	  if ((strcmp("I",type_ll) != 0)
	      || (strcmp("B",type_l) != 0)) {
	    fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
	  }

	  strcpy(type_ll,type_l);
	  linum_l = linum;
	  strcpy(type_l,"I");
	  len = pmatch[1].rm_eo-pmatch[1].rm_so;
	  memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
	  ma_l[len] = '\0';
	  strcpy(i_type, "");
	} else if(0 == regexec(&preg_emp, line, 0, pmatch, 0)) {
	  flag = 0;
	} else {
	  ;
	}
      }
      flag = 1;

    } else if (0 == regexec(&preg_g_var, line, 9, pmatch, REG_NOTEOL)) {

      if ((strcmp("G",type_ll) != 0)
	  || (strcmp("B",type_l) != 0)) {
	fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      }

      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"G");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';
      strcpy(i_type, "");

    } else if (0 == regexec(&preg_f_equ, line, 9, pmatch, REG_NOTEOL)) {
      
      if ((strcmp("F",type_ll) != 0)
	  || (strcmp("B",type_l) != 0)) {
	fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      }

      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"F");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';
      strcpy(i_type, "");

    } else if ((0 == regexec(&preg_b_equ, line, 9, pmatch, REG_NOTEOL))
	       && ((strcmp(i_type,"b_equ") != 0))) {
      fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';
      strcpy(i_type, "b_equ");
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if (0 == regexec(&preg_bar, line, 9, pmatch, REG_NOTEOL)) {

	  if ((strcmp("D",type_ll) != 0)
	      || (strcmp("B",type_l) != 0)) {
	    fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
	  }

	  strcpy(type_ll,type_l);
	  linum_l = linum;
	  strcpy(type_l,"D");
	  len = pmatch[1].rm_eo-pmatch[1].rm_so;
	  memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
	  ma_l[len] = '\0';
	  strcpy(i_type, "");
	  
	} else if (0 == regexec(&preg_lf, line, 9, pmatch, REG_NOTEOL)) {
	  flag = 0;
	} else { ; }
      }
      flag = 1;
    } else if ((0 == regexec(&preg_b_col, line, 9, pmatch, REG_NOTEOL))
	       && ((strcmp(i_type,"b_col") != 0))) {
      fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';
      strcpy(i_type, "b_col");
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if (0 == regexec(&preg_bar, line, 9, pmatch, REG_NOTEOL)) {
	  fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
	  strcpy(type_ll,type_l);
	  linum_l = linum;
	  strcpy(type_l,"E");
	  len = pmatch[1].rm_eo-pmatch[1].rm_so;
	  memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
	  ma_l[len] = '\0';
	  strcpy(i_type, "");
	} else if (0 == regexec(&preg_lf, line, 9, pmatch, REG_NOTEOL)) {
	  flag = 0;
	} else { ; }
      }
      flag = 1;
    } else if ((0 == regexec(&preg_b_mod, line, 9, pmatch, REG_NOTEOL))
	       && ((strcmp(i_type,"b_mod") != 0))) {
      fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
      strcpy(type_ll,type_l);
      linum_l = linum;
      strcpy(type_l,"B");
      len = pmatch[1].rm_eo-pmatch[1].rm_so;
      memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
      ma_l[len] = '\0';
      strcpy(i_type, "b_mod");
      while(flag == 1) {
	fgets(line, PAGEW, fin);
	linum++;
	if (0 == regexec(&preg_bar, line, 9, pmatch, REG_NOTEOL)) {
	  fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
	  strcpy(type_ll,type_l);
	  linum_l = linum;
	  strcpy(type_l,"E");
	  len = pmatch[1].rm_eo-pmatch[1].rm_so;
	  memcpy(ma_l, (&line[pmatch[1].rm_so]), len);
	  ma_l[len] = '\0';
 	  strcpy(i_type, "");
	} else if (0 == regexec(&preg_lf, line, 9, pmatch, REG_NOTEOL)) {
	  flag = 0;
	} else { ; }
      }
      flag = 1;
    }
  }
  fprintf(fout,"%s %i %s\n", type_l, linum_l, ma_l);
  strcpy(type_ll,type_l);
  
  fclose(fin);
  fclose(fout);
  return (0);
}

void usage(void){
  fprintf(stderr,
	  "gamslxi version %s, Shiro Takeda, 2008\n"
	  "Usage: gamslxi LST-file [output-file]\n", gamsver);
  exit(0);
}

