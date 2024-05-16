#!/bin/bash

COMPONENT="user"

#All the repeted functions are placed here
source components/common.sh

echo -e "\e[35m ********___________ ${COMPONENT} Component Configuration Is Started __________******** \e[0m"

# Calling NODEJS Function From common.sh File 
# Perform Disable,,Enable,,Install NodeJS
NODEJS

echo -e "\e[35m ********___________$COMPONENT Component Configuration Is Completed __________******* \e[0m"
