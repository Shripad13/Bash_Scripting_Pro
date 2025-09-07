#!/bin/bash

#Special varibales are the predefined variables in bash which have special meaning
# $0 - Prints the name of the script yo are running
# $1 - Prints the first argument you supply to the script
# $2 - Prints the second argument you supply to the script
# Note- Like this you can use $1, $2, $3, $4, $5, $6, $7, $8, $9 till here 9 Arguments

# bash abc.sh arg1 arg2 arg3 .....arg9

a=1000
TEAM=$1
PROJECT=$2
echo "The value of a is: $a"
echo "*************************"
echo "The script name is: '$0'" 
echo "*************************"
echo "Name of the Team is - $TEAM "
echo "Name of the Script - $PROJECT "
echo "*************************"
echo "Number of Arguments in the script are $#"     #Prints the NUMBER of arguments used in the script
echo "*************************"
echo "Arguments in the script are: $@"              #Prints ALL the arguments used in the script



# echo $0                                           # Prints the ScriptName which you are running
# echo "*************************"
# echo "Exit status of the Previous command is $?"  #Prints the EXIT status of the previous command
# echo "*************************"
# echo "Arguments in the script are: $*"            #Prints ALL the arguments used in the script
# echo "*************************"


# $@ & $* are same but there is a difference when you use it inside the double quotes
#$@	Treats each argument as a separate word (individually quoted)
#$*	Treats all arguments as a single word (as a single string)

#$_Last argument of the previous command


# echo "Arguments in the script are: $@"            #Prints ALL the arguments used in the script as individual strings
# echo "Arguments in the script are: $*"            #Prints ALL the arguments used in the script as a single string

#Variable	          Output
#$@	                 ["apple", "banana split", "cherry"] (array of words)
#$*	                 "apple banana split cherry" (single string)

# echo "*************************"
# echo "Process ID of the current script is $$"     #Prints the Process ID of the current script
# echo "*************************"

# sleep 1000 &                     #Run this command in background
# echo "Process ID of the last background command is $!"  #Prints the Process ID of the last background command
# echo "*************************"

# sleep 1000 &                     #Run this command in background
# PID=$!                           #Assign the Process ID of the last background command to a variable
# echo "Process ID of the last background command is $PID"  #Prints the Process ID of the last background command
# echo "*************************"

# sleep 1000 &                     #Run this command in background

STATUS=$?                        #Assign the EXIT status of the last background command to a variable
echo "Exit status of the last background command is $STATUS"  #Prints the EXIT status of the last background command
 echo "*************************"

# STEP="Sample Step"
# echo -e "\e[32m ** Running step: $STEP ** \e[0m"
# STATUS=0
# if [ $STATUS -ne 0 ]; then
#   echo -e "\e[31m ❌ Step '$STEP' failed with exit status $STATUS. Exiting script. \e[0m"
#   exit 1
# fi
# echo -e "\e[32m ✅ Step '$STEP' completed successfully. \e[0m"
# echo "*************************"
# sleep 500 &                     #Run this command in background
# STATUS=$?                        #Assign the EXIT status of the last background command to a variable
# echo "Exit status of the last background command is $STATUS"  #Prints the EXIT status of the last background command
# echo "*************************"
# STEP="Sample Step"
# echo -e "\e[32m ** Running step: $STEP ** \e[0m"
# STATUS=1
# if [ $STATUS -ne 0 ]; then
#   echo -e "\e[31m ❌ Step '$STEP' failed with exit status $STATUS. Exiting script. \e[0m"
#   exit 1
# fi
# echo -e "\e[32m ✅ Step '$STEP' completed successfully. \e[0m"
# echo "*************************"     

