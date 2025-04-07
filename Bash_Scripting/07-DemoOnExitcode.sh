#!/bin/bash

echo "Demo on Exit Codes "
# sleep 3
# echo "Demo"
echo $?

echo "Status Code of the previous command is: $? and Previous Command being executed is a Failed One" 
sleep 3
echo "Status Code of the previous command is: $? and Previous Command being executed is SUCCESS One" 

