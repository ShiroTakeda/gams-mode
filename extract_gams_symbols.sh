#! /bin/bash

# This file extracts all GAMS commands to a text file from the file
# "syntaxdata.h" available in GAMS installation folder. To work, it requires a
# GAMSDIR environment variable that points to GAMS installation folder.

# Get GAMS location from GAMSDIR environment variable
export SYNTAXDATA=$(echo $GAMSDIR | awk -F ";" '{print $1"/apifiles/C++/api/syntaxdata.h"}')

# Get all GAMS commands:
grep -oE '\"[^\"]*\"' $SYNTAXDATA | awk 'NR % 2 == 1' > temp.txt

# Keep only dollar control options
awk '/save/{print; exit} 1' temp.txt | sed 's/"\([^"]*\)"/"$\1"/g' > temp2.txt

# Other commands
awk '/save/{flag=1; next} flag' temp.txt >> temp2.txt

# Remove duplicates
sort temp2.txt | uniq > gams_commands.txt

rm temp*.txt
