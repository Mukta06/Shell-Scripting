#!/bin/bash

COMPONENT="mysql"
echo -e "\e[35m*******_________$COMPONENT Component Configuration Is Started__________******** \e[0m"

MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mysql.repo"
SCHEMA_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

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


echo -n "Featching $COMPONENT Default Password  : "
DEFAULT_ROOT_PASS=$(grep "temporary password" /var/log/mysqld.log |awk -F " " '{print $NF}')   &>> $LOGFILE
status $?

echo "show databases;" | mysql -uroot -pRoboShop@1   &>> $LOGFILE
if [ $? -ne 0 ];then
    echo -n "Changing Default Root Password : "
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASS     &>> $LOGFILE
    status $?
fi

echo -n "Download and Extracting $COMPONENT Schema : "
curl -s -L -o /tmp/$COMPONENT.zip  $MYSQL_SCHEMA   &>> $LOGFILE
cd /tmp
unzip -o mysql.zip
status $?

echo -n "Injecting Schema : "
cd /tmp/$COMPONENT-main
mysql -u root -pRoboShop@1 <shipping.sql
status $?
