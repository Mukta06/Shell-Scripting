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
    echo -e "\e[33m SKIPPING \e[0m"
    echo -e "\e[35mUser Already Exists :  \e[0m $(id $APPUSER)"
else 
    useradd $APPUSER
fi

echo -n "Downloading $COMPONENT Components : "
curl -s -L -o /tmp/user.zip $USER_REPO      &>> $LOGFILE
status $?

echo -n "Performing Cleanup : "
rm -rf $APPUSER_DIR

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
status $?

echo -n "Configuring $COMPONENT Services : "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' $APPUSER_DIR/systemd.service
cat systemd.service    &>> $LOGFILE
mv $APPUSER_DIR/systemd.service /etc/systemd/system/$COMPONENT.service
status $?
 

echo -n "Stating $COMPONENT Services : "
systemctl enable user
systemctl restart user
status $?


echo -e "\e[35m ********___________$COMPONENT Component Configuration Is Completed __________******* \e[0m"
