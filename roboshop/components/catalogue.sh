#!bin/bash

COMPONENT="catalogue"
echo -e "\e[35m *******__________ $COMPONENT Component Configuration Is Started __________******** \e[0m"

#All the repeted functions are placed here
source components/common.sh

# Calling NODEJS Function From common.sh File 
# Perform Disable,,Enable,,Install NodeJS
# Which alos includes Create user,,Download and extract functions 
NODEJS

echo -e "\e[35m *******__________ $COMPONENT Component Configuration Is Completed __________******** \e[0m"


