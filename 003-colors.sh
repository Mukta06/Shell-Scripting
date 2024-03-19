#!/bin/bash

#Syntax to use color 

# echo -e "\e[COLORCODEm I am Priniting Color \e[0m"  ----> Foreground color syntax---> text color will be changed

echo -e "\e[32mI am printing GREEN COLOR \e[0m"
echo -e "\e[31m I am printing RED COLOR \e[0m"

# echo -e "\e[BG color code;text colorcode m I am printing background and foreground color \e[0m"

echo -e "\e[43;31m I am printing both background and foreground color \e[0m"

echo "color is applied to all"