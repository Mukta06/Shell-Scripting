#!/bin/bash

COMPONENT="redis"
echo -e "\e[35m ********__________ $COMPONENT Component Configuration Is Started __________******** \e[0m"
ID=$(id -u)
REDIS_REPO="https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y"
LOGFILE="/tmp/$COMPONENT.log"

if [ $ID -ne 0 ];then
    echo -e "\e[32m This Script Should Be Executed With SUDO \e[0m"
    exit 1
fi

status(){
    if [ $1 -eq 0 ];then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[31m FAILURE \e[0m"
    fi
}


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

#sed -e 's/127.0.0.1/0.0.0.0' /etc/redis.conf  /etc/redis/redis.conf


# vim /etc/redis.conf
# vim /etc/redis/redis.conf
