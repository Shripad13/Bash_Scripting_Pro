#!/bin/bash 

# Loops : When you want to run something for some number of times continuously, then we use LOOPS 

# There are 2 variaties of loops : 
#     1) For Loop        ( When you known how many times to be executed, we use for loop )
#     2) While Loop      ( when you don't know how many time to be executed, we use this and while only runs if the condition is trye )

# for var in a b c d ; do 
#     echo "Value is $var" 
# done 


for i in 1 2 3 4 5 6 7 8 9 10 ; do 
    echo "Value is i is $i" 
done 


echo "Demo on while loop"
count=1

while [ $count -le 15 ]
do
  echo "Count is: $count"
  ((count++))  # Increment count
done

echo "While Loop finished!"