#!/bin/bash

COMPONENT="rabbitmq"
echo -e "\n\e[35m ********__________$COMPONENT Component Configuration Is Started ********__________ \e[0m"
source components/common.sh


echo -n "Downloading Dependency and Repository required for the $COMPONENT : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>>LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>LOGFILE
status $?

echo -n "Installing $COMPONENT Component : "
dnf install rabbitmq-server -y  &>>LOGFILE
status $?

echo -n "Enable and Start $COMPONENT Services : "
systemctl enable rabbitmq-server  &>>LOGFILE
systemctl start rabbitmq-server   &>>LOGFILE
systemctl status rabbitmq-server -l    &>>LOGFILE

rabbitmqctl list_users | grep $APPUSER    &>>LOGFILE
if [ $? -ne 0 ];then
    echo -n "Creating AppUser for $COMPONENT : "
    rabbitmqctl add_user roboshop roboshop123
    status $?
fi

echo -n "SOrting Permission of $COMPONENT : "
rabbitmqctl set_user_tags roboshop administrator   &>>LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>>LOGFILE
status $?


echo -e "\e[35m ********__________$COMPONENT Configuration Is Completed ___________******** \e[0m"
