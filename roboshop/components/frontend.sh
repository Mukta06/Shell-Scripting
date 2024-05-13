#!bin/bash

echo  -e "\e[32m I am cart frontend \e[0m"

echo "Installing Nginx web server" 
dnf install nginx -y 
echo "Enabling the Nginx server"
systemctl enable nginx
echo "starting the Nginx server"
systemctl start nginx