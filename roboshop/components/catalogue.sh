#!bin/bash

COMPONENT="catalogue"
echo -e "\e[35m *******__________ $COMPONENT Component Configuration Is Started __________******** \e[0m"
ID=$(id -u)
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
CATALOGUE_REPO="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
APPUSER_DIR="/home/$APPUSER/$COMPONENT"

if [ $ID -ne 0 ]; then
    echo -e "\e[31m This Script Should Be Executed With SUDO \e[0m"
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
dnf module disable nodejs -y  &>> $LOGFILE
status $?

echo -n "Enable NodeJS : "
dnf module enable nodejs:18 -y  &>> $LOGFILE
status $?

echo -n "Installing NodeJS : "
dnf install nodejs -y         &>> $LOGFILE
status $?

echo -n "Creating $APPUSER user account : "
id  $APPUSER     &>> $LOGFILE
if [ $? -ne 0 ];then
    useradd $APPUSER
    status $?
else 
    echo -e "\e[33m SKIPPING \e[0m"
    echo -e "\e[36m User already exists : \e[0m "  $(id $APPUSER)
    

fi

echo -n "Downloading $COMPONENT Repo : "
curl -s -L -o /tmp/$COMPONENT.zip  $CATALOGUE_REPO    &>> $LOGFILE
status $?

echo -n "Performing CleanUp : "
rm -rf $APPUSER_DIR
status $?

echo -n "Extracting $COMPONENT Components : " 
cd /home/roboshop
unzip -o /tmp/$COMPONENT.zip        &>> $LOGFILE
status $?

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


