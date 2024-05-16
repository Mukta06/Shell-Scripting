#!/bin/bash

COMPONENT="rabbitmq"
echo -e "\n\e[35m ********__________$COMPONENT Component Configuration Is Started ********__________ \e[0m"
source components/common.sh

# curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash

# curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

# dnf install rabbitmq-server -y

# systemctl enable rabbitmq-server 
# systemctl start rabbitmq-server
# systemctl status rabbitmq-server -l

Look for the message: Started RabbitMQ broker


# rabbitmqctl add_user roboshop roboshop123
# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

