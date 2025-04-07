#!/bin/bash

#Special varibales
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



# echo $0   # Prints the ScriptName
# echo "*************************"
# echo "Exit status of the Previous command is $?"  #Prints the EXIT status of the previous command
# echo "*************************"
# echo "Arguments in the script are: $*"            #Prints ALL the arguments used in the script
# echo "*************************"
# 

