#!/bin/bash
############################################
#            Create Variables              #
############################################
#Local Variable && Command Substitution
Bash_Name=$(echo "env")
echo "Variable Name : Bash_Name -> $Bash_Name"
#Environment Variable
export Environment_Variable="Hello World !"
############################################
#       Receive Data From Terminal         #
############################################
echo -e "First Paramiter:$1 \nSecond Paramiter:$2"
############################################
#           Condition Structure            #
#####################a######################
#Test if a given variable is equal to a given string
test "$Environment_Variable" == "Hello World !";Result=$?;echo The Test Result = $Result
#If Condition
if [ $Result -eq 0 ];
then
echo "Condition Is True"
else
echo "Condition Is False"
fi
############################################
#                   Loops                  #
#####################a######################
#For Loop
# for Counter in {1..3};
Counter=0
for File in $(ls);
do
     echo Files = $File
     ((Counter++))
done
# While Loop
echo $Counter
while [ $Counter -ne 0 ];
do
     echo Counter = $Counter
     ((Counter--))
done
############################################
#            Regular Expressions           #
#####################a######################
for File in $(ls);
do
     # if [[ "$File" == M??? ]];
     if [[ "$File" == M?i* ]];
     then
     echo "I'Ve Found : $File";
     fi
done
############################################
#                   Arrays                 #
#####################a######################
Array=('File_1' 'File_2')
for File in ${Array[@]};
do
     echo "Array : $File";
done
############################################
#           Arthematic Operations          #
#####################a######################
Number_1=5
Number_2=5
#Using Terminal
echo $(($Number_1 * $Number_2))
#using Basic Calculator
echo "$Number_1 * $Number_2"| bc 