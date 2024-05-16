#!bin/bash

echo -e "\n\e[35m ********__________$COMPONENT Component Configuration Is Started ********__________ \e[0m"

#All the repeted functions are placed here
source components/common.sh
COMPONENT="frontend"
LOGFILE="/tmp/$COMPONENT.log"
CONFIG_DIR="/etc/nginx/default.d/roboshop.conf"

# Check whether the user have root access,, if not exit the script


echo -n "Installing Nginx web server :" 
dnf install nginx -y      &>>  $LOGFILE
status $?

echo  -n "Enable Nginx server :"
systemctl enable nginx    &>>  $LOGFILE
status $?

echo -n "start Nginx server :"
systemctl start nginx     &>>  $LOGFILE
status $?

echo -n "Downloading the $COMPONENT Components : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
status $?

echo -n "Performing cleanup : "
cd /usr/share/nginx/html
rm -rf *  &>>  $LOGFILE
status $?

echo -n "Extracting  $COMPONENT : "
unzip /tmp/frontend.zip   &>>  $LOGFILE
status $?

echo -n "Configuring $COMPONENT : "
mv $COMPONENT-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl daemon-reload
status $?

echo -n "Updating the Proxy : "
for i in catalogue user cart ; do
    sed -i -e "/$i/s/localhost/$i.roboshop.internal/"  $CONFIG_DIR
   
done
 status $?

echo -n "Restart Nginx server :"
systemctl restart nginx     &>>  $LOGFILE
status $?

echo -e "\n \e[35m ********__________$COMPONENT Component Configuration Is Completed ********__________ \e[0m"

