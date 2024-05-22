#!bin/bash

echo -e  "\n \e[34m  ***************Running $0 Script***************  \e[0m \n\n"
export mysql_root_password=$2
if [ "$1" = "mysql" ];then
    if [ -z "$mysql_root_password" ];then
        echo -e "\e[31m Mysql Root Password Is Missing"
        exit 8
    fi
fi

bash components/$1.sh

# IAM -https://891377102653.signin.aws.amazon.com/console
# Password - DevOps321
