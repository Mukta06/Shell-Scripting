#!/bin/bash

# This Script Creates EC2 Instance 

AMI_ID="ami-072983368f2a6eab5"
SGID="sg-083812cca5abcd144"


aws ec2 run-instances \
--image-id $AMI_ID \
--instance-type t2.micro \
--security-group-ids $SGID \
--tag-specifications

aws ec2 run-instances \
--image-id $AMI_ID \
--instance-type t3.micro \
--security-group-ids $SGID \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}]"