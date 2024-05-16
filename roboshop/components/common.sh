#!/bin/bash

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
    
}


