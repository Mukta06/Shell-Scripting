#!/bin/bash

# display time date and no of sessions opended by hardcoding the value 

DATE="19/03/2024"
No_of_sessions=4

echo "Todays date is $DATE"
echo "No of sessions opened is ${No_of_sessions}"

#How to display time date and no of sessions opended without hardcoding the value 

Date="$(date +%F)"
tab= "$(who|wc -l)"

echo "Todays date using dynamic date is : ${Date}"
echo -e "No of opened sessions by dynamic computing is : ${tab}"