#!/bin/bash


# Create IAM User and User Groups to provide certain access to the particular user
# IAM -https://891377102653.signin.aws.amazon.com/console
# Password - DevOps321
# In this case User can talk to AWS Service 
# User outside AWS can access service using Access key and Secrete Key
# In case If AWS Service wants to talk to another Service ????

yum command will not work in the instances we create on AWS 
So run below command before using yum 

Go to /etc/yum.repos.d/

cd /etc/yum.repos.d/
Run

sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
sudo yum update -y