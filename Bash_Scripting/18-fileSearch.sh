#!/bin/bash

# Configuration
SEARCH_DIR="/opt/application"
FILE_NAME="application.log"
EMAIL="admin@example.com"

# Search for the file
FILE_PATH=$(find "$SEARCH_DIR" -type f -name "$FILE_NAME" 2>/dev/null)

# Check whether file exists
if [ -n "$FILE_PATH" ]; then

    echo "File found!"

    # Prepare email body
    SUBJECT="File Found: $FILE_NAME"

    BODY="Hello Team,

The requested file has been found.

File Name: $FILE_NAME

File Path:
$FILE_PATH

Regards,
Automation Script"

    # Send email
    echo "$BODY" | mail -s "$SUBJECT" "$EMAIL"

    echo "Email notification sent to $EMAIL"

else
    echo "File not found in $SEARCH_DIR"
fi