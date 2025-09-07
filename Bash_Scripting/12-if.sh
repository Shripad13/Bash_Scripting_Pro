#!/bin/bash

echo -e "Demo on if conditions"

ACTION=$1
REACTION=$2

if [ "$ACTION" == "start" ]; then  
    echo -e "\e[32m Starting the service \e[0m"
    exit 0
fi

# Demo on  if else 
if [ "$ACTION" == "start" ]; then  
    echo -e "\e[32m Backend is Starting \e[0m"
    exit 0
else
    echo -e "\e[31m start is valid opiton \e[0m"
    exit 3
fi

# Demo on elif

if [ "$ACTION" == "start" ]; then  
    echo -e "\e[32m Backend is Starting \e[0m"
    exit 0
elif [ "$ACTION" == "stop" ]; then
    echo -e "\e[31m Backend is stopping \e[0m"
    exit 1

elif [ "$ACTION" == "restart" ]; then
    echo -e "\e[31m Backend is restarting \e[0m"
    exit 2
else 
    echo -e "\e[32m Entered options are invalid \n Correct options are start/stop/restart \e[0m"
    exit 3
fi

