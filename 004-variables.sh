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