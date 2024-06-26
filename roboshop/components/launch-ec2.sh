#!/bin/bash

# This Script Creates EC2 Instance and associated DNS Record as well
COMPONENT=launchec2
#source components/common.sh
#LOGFILE="/tmp/$COMPONENT.log"
AMI_ID="ami-072983368f2a6eab5"
SGID="sg-083812cca5abcd144"
SERVER=$1
ENV=$2
HOSTEDZONE_ID=Z05591432KMS3R83DW3F0
COLOR="\e[34m"
NOCOLOR="\e[0m"


# If the arg is empty ,,, execution exits from if condition
if [ -z $1 ] || [ -z $2 ]; then
    echo -e "\e[31m COMPONENT NAME AND ENVIRONMENT ARE NEEDED : \e[0m"
    exit 1
fi

create_ec2() {
    PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$SERVER}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')

    echo -e "$COLOR $1 Server is Created and the  IP ADDRESS is : $NOCOLOR $PRIVATE_IP"

    echo "$COLOR ______Creating R53 json file with component name and IP address ______$NOCOLOR "
    sed -e "s/COMPONENT/${SERVER}/g" -e "s/IPADDRESS/${PRIVATE_IP}/g" rout53.json > /tmp/dns.json


    echo  -e "$COLOR ______Creating DNS Record for $SERVER : ______$NOCOLOR"
    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONE_ID --change-batch file:///tmp/dns.json 

}

if [ "$1" == "all"]; then
    for comp in frontend mongodb catalogue user redis cart mysql shipping rabbitmq payment; do
    COMPONENT=$comp
    create_ec2
    done
else
    create_ec2
fi
