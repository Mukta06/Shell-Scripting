#!/bin/bash

COMPONENT="user"
echo -e "\e[35m ********___________ ${COMPONENT} Component Configuration Is Started __________******** \e[0m"
ID=$(id -u)
LOGFILE="/tmp/$COMPONENT.log"
USER_REPO="https://github.com/stans-robot-project/user/archive/main.zip"
APPUSER="roboshop"
APPUSER_DIR="/home/$APPUSER/$COMPONENT"

if [ $ID -ne 0 ];then
    echo -e "\e[31m This Script Should Be Executed With SUDO \e[0m"
    exit 1
fi

status(){
    if [ $1 -eq 0 ];then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[32m FAILURE \e[0m"
    fi 
}


echo -n "Disable NodeJS Modules : "
dnf module disable nodejs -y    &>> $LOGFILE
status $?

echo -n "Enable NodeJS : "
dnf module enable nodejs:18 -y   &>> $LOGFILE
status $?

echo -n "Install NodeJS : "
dnf install nodejs -y       &>> $LOGFILE
status $?

echo -n "Adding User : "
id $APPUSER            &>> $LOGFILE
if [ $? -eq 0 ];then
    echo -n "\e[33m SKIPPING \e[0m"
    echo -e "\e[35m User Already Exists : id ${APPUSER} \e[0m"
else 
    useradd $APPUSER
fi

echo -n "Downloading $COMPONENT Components : "
curl -s -L -o /tmp/user.zip $USER_REPO      &>> $LOGFILE
status $?

echo -n "Extracting $COMPONENT Components : "
cd /home/$APPUSER
unzip /tmp/user.zip          &>> $LOGFILE

echo -n "Configuring Permissions : "
mv /home/${APPUSER}/user-main  $APPUSER_DIR    &>> $LOGFILE
chown -R ${APPUSER}:${APPUSER} $APPUSER_DIR    &>> $LOGFILE
status $?

echo -n "Install NPM : "
cd $APPUSER_DIR
npm install     &>> $LOGFILE

#echo -n "Configuring $COMPONENT Services : "
#sed -i -e 's/'
#$ vim /home/roboshop/user/systemd.service

#Update `REDIS_ENDPOINT` with Redis Server IP
#Update `MONGO_ENDPOINT` with MongoDB Server IP
# mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
# systemctl daemon-reload
# systemctl start user
# systemctl enable user