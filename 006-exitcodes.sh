#!/bin/bash

# $?----> exit code --if it is zero then previous command is successful
# if the exit code is between 1-125---> some failures from the command 
# If the exit code is 125+ --> then its system failure

echo $?