#!/bin/bash

echo "This script will proceed to read the input from the user interactively on the terminal"

read -p "Please enter your name: " NAME

read -p "Enter a value of A:" A
read -p "Enter a value of B:" B
echo "Value of A is $A"
echo "Value of B is $B"

echo "Hello $NAME, welcome to the world of Bash Scripting"
echo "Sum of A & B is : $((A+B))"    #Expression that are arithematic in nature should be enclosed within double parenthesis