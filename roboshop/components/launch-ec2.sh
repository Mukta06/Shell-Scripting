#!/bin/bash

# This Script Creates EC2 Instance 
COMPONENT=launchec2
LOGFILE="/tmp/$COMPONENT.log"
AMI_ID="ami-072983368f2a6eab5"
SGID="sg-083812cca5abcd144"
SERVER=$1


if[ -z $1 ];then
    echo -e "\e[31m COMPONENT NAME IS NEEDED : \e[0m"
    exit 1
fi
aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$SERVER}]"    &>>$LOGFILE