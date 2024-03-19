#!/bin/bash

#Escape sequence characters
#\n : New line
#\t : Tab space

echo "Use \n to print in new line"
echo "Use \t to give tab space"

echo "Line3\nLine4---> In this \n will not be considered as escape character"
echo "To enable escape characters use echo -e then printing statement"

echo -e "Line3\nLine4\tUsed new line and Tab"

