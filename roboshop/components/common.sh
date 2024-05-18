#!/bin/bash


LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
APPUSER_DIR="/home/$APPUSER/$COMPONENT"
ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31m This script is expected to run with sudo \e[0m \n\e[33m EX : sudo bash Scriptname\e[0m"
    exit 1
fi
status(){
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m SUCCESS \e[0m"
    else
        echo -e "\e[31m FAILURE \e[0m"
    fi
}

# Downloading and Extract 

DOWNLOAD_AND_EXTRACT(){
    echo -n "Downloading $COMPONENT Repo : "
    curl -s -L -o /tmp/$COMPONENT.zip  "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"    &>> $LOGFILE
    status $?

    echo -n "Performing CleanUp : "
    rm -rf $APPUSER_DIR
    status $?

    echo -n "Extracting $COMPONENT Components : " 
    cd /home/$APPUSER
    unzip -o /tmp/$COMPONENT.zip        &>> $LOGFILE
    status $?
}

# Declaring Creat User Function
CREATE_USER(){
    echo -n "Creating $APPUSER user account : "
    id  $APPUSER     &>> $LOGFILE
    if [ $? -ne 0 ];then
        useradd $APPUSER
        status $?
    else 
        echo -e "\e[33m SKIPPING \e[0m"
        echo -e "\e[36m User already exists : \e[0m "  $(id $APPUSER) 
    fi
}

CONFIG_SERVICE(){

    echo -n "Configuring Permissions : "
    mv /home/$APPUSER/$COMPONENT-main  /home/$APPUSER/$COMPONENT     &>> $LOGFILE
    chown -R ${APPUSER}:${APPUSER} $APPUSER_DIR
    status $?

    echo -n "Configuring $COMPONENT Services : "
    sed -i -e 's/AMQPHOST/rabbitmq.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
    mv ${APPUSER_DIR}/systemd.service /etc/systemd/system/${COMPONENT}.service
    status $?

}

START_SERVICE(){
    echo -n "Starting $COMPONENT Services : "
    systemctl daemon-reload
    systemctl enable $COMPONENT    &>> $LOGFILE
    systemctl restart $COMPONENT   &>> $LOGFILE
    status $?
}

# Declaring NodeJS Function

NODEJS(){
    echo -n "Disable NodeJS : "
    dnf module disable nodejs -y  &>> $LOGFILE
    status $?

    echo -n "Enable NodeJS : "
    dnf module enable nodejs:18 -y  &>> $LOGFILE
    status $?

    echo -n "Installing NodeJS : "
    dnf install nodejs -y         &>> $LOGFILE
    status $?

    CREATE_USER  # Calling Function fron another Function
    DOWNLOAD_AND_EXTRACT 
    CONFIG_SERVICE

    echo -n "Generating $COMPONENT Artifacts : "
    cd $APPUSER_DIR
    npm install                     &>> $LOGFILE
    status $?

    START_SERVICE
    
}

MAVEN(){

    echo -n "Installing Maven : "
    dnf install maven -y   &>> $LOGFILE
    status $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    echo -n "Generating $COMPONENT Artifacts : "
    mv shipping-main $COMPONENT    &>> $LOGFILE
    cd $APPUSER_DIR 
    mvn clean package     &>> $LOGFILE
    mv target/${COMPONENT}-1.0.jar $COMPONENT.jar     &>> $LOGFILE
    status $?

    CONFIG_SERVICE

    START_SERVICE

}

PYTHON(){

    echo -n "Installing $COMPONENT  packages : "
    dnf install python36 gcc python3-devel -y    &>> $LOGFILE
    status $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    CONFIG_SERVICE

    echo -n "Installing $COMPONENT Dependencies : "
    cd /home/$APPUSER/$COMPONENT 
    pip3.6 install -r requirements.txt     &>> $LOGFILE
    status $?
    
    START_SERVICE


}


