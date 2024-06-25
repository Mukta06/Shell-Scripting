#!/bin/bash

# This Script Creates EC2 Instance and associated DNS Record as well
COMPONENT=launchec2
#source components/common.sh
#LOGFILE="/tmp/$COMPONENT.log"
AMI_ID="ami-072983368f2a6eab5"
SGID="sg-083812cca5abcd144"
SERVER=$1
HOSTEDZONE_ID=Z05591432KMS3R83DW3F0


# If the arg is empty ,,, execution exits from if condition
if [ -z $1 ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED : \e[0m"
    exit 1
fi
PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$SERVER}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')

echo -e "\e[33m $1 Server is Created and the  IP ADDRESS is : \e[0m $PRIVATE_IP "

echo "Creating R53 json file with component name and IP address "
sed -e "s/COMPONENT/${SERVER}/g" -e "s/IPADDRESS/${PRIVATE_IP}/g" rout53.json > /tmp/dns.json


echo  -n "Creating DNS Record for $SERVER : "
aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONE_ID --change-batch file://tmp/dns.json
