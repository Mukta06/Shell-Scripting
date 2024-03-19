#!/bin/bash

#Declaring variable

a=10
b=def


# echo a --> will not print the value of the variable a,,,, to print it use $
# $--> is the special variable which will print the value of the variable

#Printing the value of the variable

echo $a
# echo $a OR echo ${a}--> both are same if in some versions of bash 

echo "The value of the variable b is $b"

# If we try to print the value of the variable which is not declared it will print null
# Same in case deleting dir or file which is not present will delect the entire parent dir 
# rm -rf /data/prod/${APPDATA}---> incase APPDATA is not present then entire prod dir will be deleted.


# Print the value in different colors 

echo -e " Printing the values in color \e[31m ${b} \e[0m"