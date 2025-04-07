#!/bin/bash

# Variables are used to store the data
# In Bash, there is no concpet like Data Types
# How do you define a variable? a=100, a=abc, c=1.2
# When you attempt to print the value of undefined variable, it will print blank (null value)

a=100
echo "Print the value of a = $a"
echo "Print the value of b = $b"


echo "Print the value of a = $a"     # Double quotes will expand the variable
echo Print the value of a = $a       # Same as above
echo Print the value of a = ${a}     # Same as above
echo 'Print the value of a = $a'     # Single quotes will not expand the variable ,it will print variable as it is


# As per NFR, Variable always should be in lowercase & Uppercase
# Better to stick on UPPERCASE VARIABLE only

# VARNAME: Upper case
# varname: Lower case
# varName: Camel Case
# var_name: Snake Case
# var-name: Hyphen Case
# varName: Pascal Case


#TODAYS_DATE=$(date +%Y-%m-%d)       # As per ISO format - YYYY-MM-DD
#TODAYS_DATE=$(date +%F)             # Above variable is also same
#TODAYS_DATE=$(date +%d-%m-%Y)        # As per Indian format - DD-MM-YYYY 
#echo "Today's date is: $TODAYS_DATE"
echo "Today's date is: $(date +%d-%m-%Y)"  #Using Dynamic variable


# Number of users logged in to server
echo "Number logged in Users on server = $(who |wc -l)"