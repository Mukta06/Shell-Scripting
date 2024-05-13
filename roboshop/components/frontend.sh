#!bin/bash

echo  -e "\e[32m I am cart frontend \e[0m"

# Check whether the user have root access,, if not exit the script

ID = $(id -u)


if [ $ID -ne 0 ]; then
    echo -e "\e[31m This script is expected to run with sudo \e[0m \n\e[33m EX : sudo bash Scriptname\e[0m"
    exit 1
fi

echo -n "Installing Nginx web server :" 
dnf install nginx -y      &>>  /tmp/frontend.log
if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
else
    echo -e "\e[31m FAILURE \e[0m"
fi

echo  -n "Enabling the Nginx server :"
systemctl enable nginx    &>>  /tmp/frontend.log
if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
else
    echo -e "\e[31m FAILURE \e[0m"
fi

echo -n "starting the Nginx server :"
systemctl start nginx     &>>  /tmp/frontend.log
if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
else
    echo -e "\e[31m FAILURE \e[0m"
fi