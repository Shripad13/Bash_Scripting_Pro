#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Printa all arguments used in the script: "$*""
echo "Total arguments: "$@""
echo "Process ID of the current script is $$"
ls -larth
STATUS=$?                                                     #Assign the EXIT status of the last background command to a variable
echo "Exit status of the last background command is $STATUS"  #Prints the EXIT status of the last background command
echo "*************************"
echo "Total arguments: $#"

sleep 2&

echo "PID of background job: $!"

ls -l
echo "Last argument of previous command: $_"
