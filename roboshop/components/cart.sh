#!/bin/bash

COMPONENT="cart"
echo -e "\e[35m_________********$COMPONENT Component Configuration Is Started_________******** \e[0m"

#All the repeted functions are placed here
source components/common.sh

# Calling NODEJS Function From common.sh File 
# Perform Disable,,Enable,,Install NodeJS
NODEJS

echo -e "\e[35m********__________$COMPONENT Configuration Is Completed__________******** \e[0m"