#!/bin/bash

# There are 4 types of commands
# 1) Binary                   (/bin/sbin)
# 2) Aliases                  (Shortcuts)
# 3) Shell Built-In commands  (cd, pwd, alias, type, exit )
# 4) Functions


Num=$(who|wc -l)
echo $Num