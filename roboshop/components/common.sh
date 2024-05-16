#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31m This script is expected to run with sudo \e[0m \n\e[33m EX : sudo bash Scriptname\e[0m"
    exit 1
fi
status(){
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[31m FAILURE \e[0m"
    fi
}
