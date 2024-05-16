#!/bin/bash

COMPONENT="cart"
echo -e "\e[35m_________********$COMPONENT Component Configuration Is Started_________******** \e[0m"
ID=$(id -u)
LOGFILE="/tmp/$COMPONENT.log"
CART_REPO="https://github.com/stans-robot-project/cart/archive/main.zip"
APPUSER="roboshop"
APPUSER_DIR="/home/${APPUSER}/${COMPONENT}"

if [ $ID -ne 0 ];then
    echo -e "\e[32mThis Script Should Be Executed Using SUDO \e[0m"
    exit 1
fi
status(){
    if [ $1 -eq 0 ];then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[31m FAILURE \e[0m"
    fi 
}


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
    echo -e "\34m User Already Exists : \e[0m $(id ${APPUSER}) "
else
    useradd $APPUSER
fi 

echo -n "Downloading $COMPONENT Components : "
curl -s -L -o /tmp/${COMPONENT}.zip $CART_REPO     &>> $LOGFILE
status $?

echo -n "Extracting $COMPONENT Components : "
cd /home/$APPUSER
unzip -o /tmp/${COMPONENT}.zip     &>> $LOGFILE
mv /home/roboshop/cart-main $APPUSER_DIR
status $?

echo -n "Install NPM : "
cd $APPUSER_DIR
npm install     &>> $LOGFILE
status $?

echo -n "Configuring $COMPONENT Services : "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e '/s/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' $APPUSER_DIR/systemd.service
mv $APPUSER_DIR/systemd.service  /etc/systemd/system/$COMPONENT.service
status $? 


echo -n "Enable $COMPONENT Service : "
systemctl enable cart
systemctl restart cart
systemctl status cart -l     &>> $LOGFILE
status $?

echo -e "\e[35m********__________$COMPONENT Configuration Is Completed__________******** \e[0m"