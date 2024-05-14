#!bin/bash

COMPONENT="catalogue"
echo -e "\e[35m *******__________ $COMPONENT Component Configuration Is Started __________******** \e[0m"
ID=$(id -u)
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

if [ $ID -ne 0 ]; then
    echo -e "\e[31m This Script Should Be Executed With SUDO \e[0m"
    exit 1
fi

status(){
    if [$1 -eq 0];then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[31m FAILURE \e[0m"

    fi
}

echo -n "Disable NodeJS : "
dnf module disable nodejs -y  &>> $LOGFILE
status $?

echo -n "Enable NodeJS : "
dnf module enable nodejs:18 -y  &>> $LOGFILE
status $?

echo -n "Installing NodeJS : "
dnf install nodejs -y         &>> $LOGFILE
status $?

echo -n "Creating $APPUSER user account: "
useradd $APPUSER
status $?