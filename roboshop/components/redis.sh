#!/bin/bash

COMPONENT="redis"
echo -e "\e[35m ********__________ $COMPONENT Component Configuration Is Started __________******** \e[0m"
#All the repeted functions are placed here
source components/common.sh
REDIS_REPO="https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y"
LOGFILE="/tmp/$COMPONENT.log"


echo -n "Downloading $COMPONENT  components :"
dnf install $REDIS_REPO    &>> $LOGFILE
status $?

echo -n "Enabling $COMPONENT Module : "
dnf module enable redis:remi-6.2 -y   &>> $LOGFILE
status $? 

echo -n "Installing $COMPONENT : "
dnf install redis -y      &>> $LOGFILE
status $?

echo -n "Congfiguring $COMPONENT Services : "

sed -i -e 's/127.0.0.1/0.0.0.0/'  /etc/redis.conf  
sed -i -e 's/127.0.0.1/0.0.0.0/'  /etc/redis/redis.conf
status $?

echo -n "Enabling $COMPONENT Services : "
systemctl enable $COMPONENT     &>> $LOGFILE
systemctl restart $COMPONENT    &>> $LOGFILE
status $?

echo -e "\e[35m *******__________$COMPONENT Component Configuration Is  Completed __________******** "
