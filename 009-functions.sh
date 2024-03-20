#!/bin/bash

# There are 4 types of commands
# 1) Binary                   (/bin/sbin)
# 2) Aliases                  (Shortcuts)
# 3) Shell Built-In commands  (cd, pwd, alias, type, exit )
# 4) Functions


Num=$(who|wc -l)
echo $Num

f(){
    echo Hello Welcome
}

start()
{
    f
    echo "Number of opened sessions : $(who|wc -l)"
    echo "Today's date is : $(date + %F)"
    echo "Load average in last 1 min is : $(uptime|awk -F :'{print $NF}'|awk -F ',' '{print $1}')"
}

start