#!/bin/bash 

echo -e "Demo on if conditions"

ACTION=$1 

# Demo on if condition
# if [ "$ACTION" == "start" ]; then         # The below commands will only be exectuted if the condition is true.
#     echo "Starting the service"
# fi 

# echo -e "Script Completed"

# Demo on if else condition
# if [ "$ACTION" == "start" ]; then         # The below commands will only be exectuted if the condition is true.
#     echo "Starting the service"
# else
#     echo "Valid Arguments are start"
#     echo -e "Ex: \n\t \e[31m bash $0 start \e[0m"
# fi 
# echo -e "Script Completed"

# Demo on else if  condition

if [ "$ACTION" == "start" ]; then         # The below commands will only be exectuted if the condition is true.
    echo -e "\e[32m Starting the service \e[0m"

elif [ "$ACTION" == "stop" ]; then
    echo -e "\e[31m Stopping the service \e[0m"

elif [ "$ACTION" == "restart" ]; then
    echo -e "\e[35m Restarting the service \e[0m"
else
    echo "Valid Arguments are start or stop or restart ONLY"
    echo -e "Ex: \n\t \e[33m bash $0 start  \e[0m"
fi 

echo -e "Script Completed"