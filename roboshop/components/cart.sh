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
        echo -e "\e[31m SUCCESS \e[0m"
    else
        echo -e "\e[32m FAILURE \e[0m"
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
npm install
status $?

#Update REDIS_ENDPOINT with REDIS server IP Address
#Update CATALOGUE_ENDPOINT with Catalogue server IP address
#$ vim systemd.service
# mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
# systemctl daemon-reload
# systemctl start cart
# systemctl enable cart
# systemctl status cart -l

# vim /etc/nginx/default.d/roboshop.conf
# systemctl restart nginx 