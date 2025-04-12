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


# ls -lrth  > output.txt # Redirects the outout to output.txt file
# ls -lrth >> output.txt # Redirects and appends the output to the output.txt file
# ls -lrth 2> output.txt # Redirects the only error to output.txt file
# ls -lrth &> output.txt # Redirects the output and error to output.txt file


## How inputs and outputs are categorized :

# 1. Standard Output       (Expected error less output)
# 2. Standard Error        (Expected Output)