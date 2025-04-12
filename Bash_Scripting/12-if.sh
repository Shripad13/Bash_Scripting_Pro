#!/bin/bash

echo -e "Demo on if conditions"

ACTION=$1
REACTION=$2

if [ "$REACTION" == "start" ]; then
    echo "Starting the service"
fi