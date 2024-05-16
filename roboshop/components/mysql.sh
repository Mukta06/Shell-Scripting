#!/bin/bash

COMPONENT="mysql"
echo -e "\e[35m*******_________$COMPONENT Component Configuration Is Started__________********"

MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mysql.repo"
MYSQL_SCHEMA="https://github.com/stans-robot-project/mysql/archive/main.zip"

source components/common.sh

echo -n "Disable MYSQL Module : "
dnf module disable mysql -y             &>> $LOGFILE
curl -s -L -o /etc/yum.repos.d/mysql.repo $MYSQL_REPO      &>> $LOGFILE
status $?

echo -n "Installing MYSQL : "
dnf install mysql-community-server -y      &>> $LOGFILE
status $?

echo -n "Enable MYSQL Service : "
systemctl enable mysqld     &>> $LOGFILE
systemctl start mysqld       &>> $LOGFILE
status $?    
