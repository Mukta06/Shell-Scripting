#!/bin/bash

COMPONENT="cart"
echo -e "\e[35m_________********$COMPONENT Component Configuration Is Started_________******** \e[0m"
#All the repeted functions are placed here
source components/common.sh
LOGFILE="/tmp/$COMPONENT.log"
CART_REPO="https://github.com/stans-robot-project/cart/archive/main.zip"
APPUSER="roboshop"
APPUSER_DIR="/home/${APPUSER}/${COMPONENT}"


echo -n "Disable NodeJS : "
dnf module disable nodejs -y   &>> $LOGFILE
status $?

echo -n "Enable NodeJS : "
dnf module enable nodejs:18 -y   &>> $LOGFILE
status $?

echo -n "Installing NodeJS : "
dnf install nodejs -y    &>> $LOGFILE
status $?

echo -n "Adding User : "
id $APPUSER       &>> $LOGFILE
if [ $? -eq 0 ];then
    echo -e "\e[33m SKIPPING \e[0m"
    echo -e "\34m User Already Exists : \e[0m $(id ${APPUSER}) "
else
    useradd $APPUSER
fi 

echo -n "Downloading $COMPONENT Components : "
curl -s -L -o /tmp/cart.zip $CART_REPO     &>> $LOGFILE
status $?

echo -n "Performing Cleanup : "
rm -rf $APPUSER_DIR
status $?

echo -n "Extracting $COMPONENT Components : "
cd /home/${APPUSER}
unzip -o /tmp/cart.zip     &>> $LOGFILE
status $?

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