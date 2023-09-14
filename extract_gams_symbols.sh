#! /bin/bash

# This file extracts all GAMS commands to a text file from the file
# "syntaxdata.h" available in GAMS installation folder. To work, it requires a
# GAMSDIR environment variable that points to GAMS installation folder.

# Get GAMS location from GAMSDIR environment variable
export SYNTAXDATA=$(echo $GAMSDIR | awk -F ";" '{print $1"/apifiles/C++/api/syntaxdata.h"}')

# Remove commented lines
sed '/^\/\//d' $SYNTAXDATA > temp_syntax.txt

# Extract lines between keywords
sed -n '/directives()/,/systemAttributes()/p' temp_syntax.txt > temp_dollar.txt
sed -n '/systemAttributes()/,/systemData()/p' temp_syntax.txt > temp_sys_attr.txt
sed -n '/systemData()/,/systemCTConstText()/p' temp_syntax.txt > temp_sys_data.txt
sed -n '/systemCTConstText()/,/systemCTConstants()/p' temp_syntax.txt > temp_sys_ct_text.txt
sed -n '/systemCTConstants()/,/modelTypes()/p' temp_syntax.txt > temp_sys_ct_constants.txt
sed -n '/modelTypes()/,/options()/p' temp_syntax.txt > temp_model.txt
sed -n '/options()/,/execute()/p' temp_syntax.txt > temp_options.txt
sed -n '/execute()/,/keyExecute()/p' temp_syntax.txt > temp_execute.txt
sed -n '/keyExecute()/,/keyOption()/p' temp_syntax.txt > temp_key_execute.txt
sed -n '/keyOption()/,/keyPut()/p' temp_syntax.txt > temp_key_options.txt
sed -n '/keyPut()/,/keySolve()/p' temp_syntax.txt > temp_key_put.txt
sed -n '/keySolve()/,/reserved()/p' temp_syntax.txt > temp_key_solve.txt
sed -n '/reserved()/,/embedded()/p' temp_syntax.txt > temp_functions.txt
sed -n '/embedded()/,/declaration4Set()/p' temp_syntax.txt > temp_embedded.txt
sed -n '/declaration4Set()/,/declaration4Var()/p' temp_syntax.txt > temp_declaration_set.txt
sed -n '/declaration4Var()/,/declaration()/p' temp_syntax.txt > temp_declaration_var.txt
sed -n '/declaration()/,/extendableKey()/p' temp_syntax.txt > temp_declaration.txt
sed -n '/extendableKey()/,/return list/p' temp_syntax.txt > temp_extendable.txt

# Get all GAMS commands:
get_gams_commands () {
    # grep extracts the commands and comments
    # awk keeps the commands
    grep -oE '\"[^\"]*\"' $1 | awk 'NR % 2 == 1'
}

rm temp_syntax.txt 

for tempfile in temp*.txt
do
  get_gams_commands ${tempfile} > ${tempfile/temp_/commands_}
done

# Add dollar sign for dollar control options
sed -i 's/"\([^"]*\)"/"$\1"/g' commands_dollar.txt 

# Add combined declations
sed 's/"\([^"]*\)"/"\1 Variable"/g' commands_declaration_var.txt > commands_declaration2.txt
sed 's/"\([^"]*\)"/"\1 Variables"/g' commands_declaration_var.txt >> commands_declaration2.txt
sed 's/"\([^"]*\)"/"\1 Set"/g' commands_declaration_set.txt >> commands_declaration2.txt
sed 's/"\([^"]*\)"/"\1 Sets"/g' commands_declaration_set.txt >> commands_declaration2.txt

# Combine all commands
for commandsfile in commands*.txt
do
  cat ${commandsfile} >> temp.txt
done

# Add missing commands
echo -e "\"maximizing\"\\n\"minimizing\"" >> temp.txt

# Remove duplicates
sort temp.txt | uniq > gams_commands.txt

rm temp*.txt
