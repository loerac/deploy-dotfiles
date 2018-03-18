#!/usr/bin/bash

#regex="([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})"; ipline=`ip route get 8.8.8.8 | grep 8.8.8.8`; addr=(); for word in $ipline; do if [[ $word =~ $regex ]]; then addr+=("${BASH_REMATCH[1]}"); fi done; echo ${addr[-1]}

## 
# Name: printActiveIP.sh
# Description: Quick and dirty script for grabbing the active IP address
# Author: Brett Holman
# Date: 3/17/18
# Summary: this was intended to be a (complex) one liner in my .tmux.conf,
#          but tmux didn't like it, so I'm making it a short script that is executed from .tmux.conf

regex='([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})'; 

# Greps for the line pinging Google's server
ipline=`ip route get 8.8.8.8 | grep 8.8.8.8`; 
addr=(); 
for word in $ipline; do 

    # Regex match
    if [[ $word =~ $regex ]]; then 
        addr+=(${BASH_REMATCH[1]}); 
    fi 
done; 

# print the last ip in the route
echo ${addr[-1]}
