#!/bin/bash

COMPONENT="cart"
echo -e "\e[35m_________********$COMPONENT Component Configuration Is Started_________******** \e[0m"
#All the repeted functions are placed here
source components/common.sh
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
APPUSER_DIR="/home/${APPUSER}/${COMPONENT}"


# Calling NODEJS Function From common.sh File 
# Perform Disable,,Enable,,Install NodeJS
NODEJS

echo -n "Configuring $COMPONENT Permissions : "
mv /home/${APPUSER}/cart-main  $APPUSER_DIR
chown -R ${APPUSER}:${APPUSER} $APPUSER_DIR
status $?

echo -n "Install NPM : "
cd $APPUSER_DIR
npm install     &>> $LOGFILE
status $?

echo -n "Configuring $COMPONENT Services : "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' $APPUSER_DIR/systemd.service
mv $APPUSER_DIR/systemd.service  /etc/systemd/system/$COMPONENT.service     &>> $LOGFILE
status $? 


echo -n "Enable $COMPONENT Service : "
systemctl enable cart
systemctl restart cart
systemctl status cart -l     &>> $LOGFILE
status $?

echo -e "\e[35m********__________$COMPONENT Configuration Is Completed__________******** \e[0m"