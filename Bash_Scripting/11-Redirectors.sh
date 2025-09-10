#!/bin/bash

# Redirectors
# how to take the input , how to give the output, how to handle errors

# Redirectors are of 2 types:
# 1. Input Redirectors (<) we use this to take input from a file       : < (Ex - sudo mysql </tmp/studentapp.sql)
# 2. Output Redirectors (>> or >) (Means routing the output to a file) : > or 1> or >> or &> (>> appends the latest output to the file)

# Outputs
# 1. Standard Output (stdout) - 1> or > or >> 
# 2. Standard Error (stderr) - 2> or 2>> 
# 3. Standard Output and Standard Error (stdout and stderr) - &> or &>> or 2>&1


# ls -lrth  > output.txt # Redirects the outout to output.txt file without appending
# ls -lrth >> output.txt # Redirects and appends the output to the output.txt file
# ls -lrth 2>> output.txt # Redirects the only error to output.txt file
# ls -lrth &> output.txt # Redirects the output and error to output.txt file


## How inputs and outputs are categorized :

# 1. Standard Output     1> or > or >>  (Expected error less output)(Normal Output)
# 2. Standard Error      2> or 2>>  (Expected Output)(Error Output)
# 3. Standard Output and Standard Error   &> or &>> or 2>&1 (Expected output and error)
# 4. Standard Input      < (Input to a command from a file)
ex : mysql -u root -p </tmp/studentapp.sql  # Input redirection


# For single input as a whole from file, that time use input redirector
# For multiple inputs from file, that time use while loop with read command
ex - for i in $(cat /tmp/list.txt); do echo $i; done  # This is not a good practice, because if there are spaces in the file, it will break the input

# Better way is to use while loop with read command
while read line; do
    echo $line
done < /tmp/list.txt  # Here the input is taken from the file /tmp/list.txt
# Here the while loop will read each line from the file and print it
