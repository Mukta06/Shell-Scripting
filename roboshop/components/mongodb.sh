#!bin/bash 

echo -e "\e[35m ********_________ Component Configuration Is Started__________******** \e[0m"

ID=$(id -u)
COMPONENT="mongodb"
LOGFILE="/tmp/$COMPONENT.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

if [ $ID -ne 0 ]; then
    echo -e "\e[31m This Script is expected to run with SUDO \n EX: sudo bash Scriptname \e[0m"
    exit 1
fi

status(){
    if [ $1 -eq 0 ];then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[31m FAILURE \e[0m"

    fi

}

echo -n "Configuring $COMPONENT repo :"

curl  $MONGO_REPO > /etc/yum.repos.d/mongodb.repo &>> $LOGFILE
# curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO    ----> We can use any of this curl command 
status $?

echo -n "Installing $COMPONENT : "
dnf install -y mongodb-org   &>> $LOGFILE
status $?

echo -n "Enabling $COMPONENT service : " 
systemctl enable mongod      &>> $LOGFILE
status $?

echo -n "Starting $COMPONENT : "
systemctl start mongod      &>> $LOGFILE
status $?