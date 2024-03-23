#!/bin/bash


# How to redirect input ,, output and how to handle errors 

# Redirectors are of two types
# 1) Standard input redirector            : (<)
# 2) Standard output redirector           : (>(Override the existing content) / >>(Append to the existing content ) /1>)
# 3) Standard Errors                      : 2> or 2>>
# 4) Standard output and Standard error   : $>(override) or &>>(append)


<< COMMENT
EX FOR OVERRIDEN OUTPUT REDIRECTOR :

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr > output.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr
total 8
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos  125 Mar 23 14:59 output.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat output.txt
total 4
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos    0 Mar 23 14:59 output.txt


44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ echo "Welcome" > output.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr
total 8
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos    8 Mar 23 15:02 output.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat output.txt
Welcome   -------> overriden the previous file content


EX FOR APPEND OUTPUT REDIRECTOR :

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ echo "Redirectors in Shell Scripting are of two types" > Append.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr
total 8
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos   48 Mar 23 15:07 Append.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat Append.txt
Redirectors in Shell Scripting are of two types

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ echo -e " 1) Standard Input Redirector \n 2) Standard Output Redirector \n 3) Standard Error Redirector \n 4) Standard Output and Error Redirector  " >Append.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr
total 8
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos  137 Mar 23 15:09 Append.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat Append.txt
 1) Standard Input Redirector
 2) Standard Output Redirector
 3) Standard Error Redirector
 4) Standard Output and Error Redirector



EX FOR STANDARD ERROR REDIRECTOR : 

 44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ lasdfa -ltr
-bash: lasdfa: command not found

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ lasdfa -ltr 2> error.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr
total 12
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos  137 Mar 23 15:09 Append.txt
-rw-rw-r-- 1 centos centos   33 Mar 23 15:10 error.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat error.txt
-bash: lasdfa: command not found

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ javavaaaa -versionon 2> error.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat error.txt
-bash: javavaaaa: command not found

EX FOR APPENDED ERROR REDIRECTOR :

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ncjdsn -kdncnd 2>> error.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat error.txt
-bash: ncjdsn: command not found

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ javavaa -version 2>> error.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat error.txt
-bash: ncjdsn: command not found
-bash: javavaa: command not found
 

EX FOR STANDARD OUTPUT AND ERROR REDIRECTOR:

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr &>> outanderror.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat outanderror.txt
total 12
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos  137 Mar 23 15:09 Append.txt
-rw-rw-r-- 1 centos centos   67 Mar 23 15:15 error.txt
-rw-rw-r-- 1 centos centos    0 Mar 23 15:16 outanderror.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ javavvaaa -versioqwnd &>> outanderror.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat outanderror.txt
total 12
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos  137 Mar 23 15:09 Append.txt
-rw-rw-r-- 1 centos centos   67 Mar 23 15:15 error.txt
-rw-rw-r-- 1 centos centos    0 Mar 23 15:16 outanderror.txt
-bash: javavvaaa: command not found

TO NULLIFY THE RESULT : /file or dir/null

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ dkjbcjkdbcjb -kdjckbd &>> /dev/null

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ ls -ltr
total 16
drwxrwxr-x 3 centos centos 4096 Mar 23 08:02 Shell-Scripting
-rw-rw-r-- 1 centos centos  137 Mar 23 15:09 Append.txt
-rw-rw-r-- 1 centos centos   67 Mar 23 15:15 error.txt
-rw-rw-r-- 1 centos centos  278 Mar 23 15:16 outanderror.txt

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$ cat /dev/null

44.211.138.186 | 172.31.93.45 | t2.micro | null
[ centos@Workstation ~ ]$

COMMENT