#!bin/bash 


COMPONENT="mongodb"
echo -e "\e[35m ********_________ $COMPONENT Component Configuration Is Started __________******** \e[0m"

#All the repeted functions are placed here
source components/common.sh

MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

echo -n "Configuring $COMPONENT repo :"

curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO  &>> $LOGFILE
# curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO    ----> We can use any of this curl command 
status $?

echo -n "Installing $COMPONENT : "
dnf install -y mongodb-org   &>> $LOGFILE
status $?

echo -n "Enabling $COMPONENT : " 
systemctl enable mongod      &>> $LOGFILE
status $?

echo -n "Starting $COMPONENT : "
systemctl start mongod      &>> $LOGFILE
status $?

echo -n "Enabling $COMPONENT Visibility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf   
#sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status $?

echo -n "Restarting $COMPONENT : "
systemctl restart mongod      &>> $LOGFILE
status $?

echo -n "Downloading schema file : "
curl -s -L -o /tmp/$COMPONENT.zip $SCHEMA_URL   &>> $LOGFILE
status $?

echo -n "Extracting $COMPONENT Schema : "
cd /tmp
unzip -o ${COMPONENT}.zip   &>> $LOGFILE
status $?

echo -n "Injecting the schema : "
cd /tmp/$COMPONENT-main
mongo < catalogue.js   &>> $LOGFILE
mongo < users.js       &>> $LOGFILE
status $?

echo -e "\e[35m ********__________ $COMPONENT Component Configuration Is Completed __________******** \e[0m"