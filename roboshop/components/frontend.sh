#!bin/bash

# Check whether the user have root access,, if not exit the script
ID=$(id -u)
COMPONENT="frontend"
LOGFILE="/tmp/$COMPONENT"

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

echo -n "Installing Nginx web server :" 
dnf install nginx -y      &>>  $LOGFILE
status $?

echo  -n "Enabling the Nginx server :"
systemctl enable nginx    &>>  $LOGFILE
status $?

echo -n "starting the Nginx server :"
systemctl start nginx     &>>  $LOGFILE
status $?

echo -n "Downloading the $COMPONENT Components : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
status $?

echo -n "Performing cleanup : "
cd /usr/share/nginx/html
rm -rf *  &>>  $LOGFILE
status $?

echo -n "Extracting  $COMPONENT : "
unzip /tmp/frontend.zip   &>>  $LOGFILE
status $?

echo -n "Configuring $COMPONENT : "
mv $COMPONENT-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
status $?

