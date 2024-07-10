#!/bin/bash 
PATH="/home/centos/workstation/mirror.op"
echo -n "Removing Mirror error :"
status(){
if [ $1 -eq 0  ]; then
    echo "SUCCESS"
else
    echo "FAILURE" 
fi
}

cd /etc/yum.repos.d/  &> $PATH

sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*    &> $PATH
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*   &> $PATH

echo -n "Update is Completed : "
sudo yum update -y    &> $PATH
status $?