#!/bin/bash

# Special variabes are pre defined variables with specific pre defined powers.
# We cannot create special pre defined variables we can just use it 

a=3000
Team=$1
Project=$2

echo "The value of a is : $a"

echo "The value of special variable 0 is SCRIPT NAME: $0"

# 0-9 are the no of arguments we can use to give command line arg 

echo -e "Team name is : \e[33m $Team \e[0m"
echo -e "Project name is : \e[33m $Project \e[0m"

# $0 ---> Prints script name 
# $#----> Prints no of arguments used in the script ex: in this script 2
# $?----> exit code --if it is zero then previous command is successful
# $*/$@ --> prints all the arguments used in the script

echo  -e "Number of arguments used in the Script $0 is : $#"

echo $0
echo $#
echo $?
echo $*
echo $@


