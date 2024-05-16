#!/bin/bash

COMPONENT="user"
echo -e "\e[35m ********___________ ${COMPONENT} Component Configuration Is Started __________******** \e[0m"
LOGFILE="/tmp/$COMPONENT.log"
USER_REPO="https://github.com/stans-robot-project/user/archive/main.zip"
APPUSER="roboshop"
APPUSER_DIR="/home/$APPUSER/$COMPONENT"

# Calling NODEJS Function From common.sh File 
# Perform Disable,,Enable,,Install NodeJS
NODEJS

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
