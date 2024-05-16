#!bin/bash

COMPONENT="catalogue"
echo -e "\e[35m *******__________ $COMPONENT Component Configuration Is Started __________******** \e[0m"
#All the repeted functions are placed here
source components/common.sh
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
CATALOGUE_REPO="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
APPUSER_DIR="/home/$APPUSER/$COMPONENT"

# Calling NODEJS Function From common.sh File 
# Perform Disable,,Enable,,Install NodeJS
# Which alos includes Create user,,Download and extract functions 
NODEJS

echo -n "Configuring Permissions : "
mv /home/roboshop/$COMPONENT-main  $APPUSER_DIR     &>> $LOGFILE
chown -R ${APPUSER}:${APPUSER} $APPUSER_DIR
status $?

echo -n "Generating $COMPONENT Artifacts : "
cd $APPUSER_DIR
npm install                     &>> $LOGFILE
status $?

echo -n "Configuring $COMPONENT Services : "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
mv ${APPUSER_DIR}/systemd.service /etc/systemd/system/${COMPONENT}.service
status $?

echo -n "Starting $COMPONENT Services : "
systemctl daemon-reload
systemctl enable $COMPONENT    &>> $LOGFILE
systemctl restart $COMPONENT   &>> $LOGFILE
status $?

echo -e "\e[35m *******__________ $COMPONENT Component Configuration Is Completed __________******** \e[0m"


