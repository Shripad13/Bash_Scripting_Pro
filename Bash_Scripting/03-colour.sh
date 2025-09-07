#!/bin/bash

# Print foreground colours

# Colours in Bash Scripting

# Foreground Colours:      Background Colours:
# Black       30           Black       40
# Red         31           Red         41
# Green       32           Green       42
# Yellow      33           Yellow      43
# Blue        34           Blue        44
# Magenta     35           Magenta     45
# Cyan        36           Cyan        46
# White       37           White       47

# Common style attributes (the first number before ;):
# 0 → Reset / Normal text
# 1 → Bold / Bright
# 2 → Dim
# 3 → Italic
# 4 → Underline
# 5 → Blink
# 7 → Reverse (swap foreground/background)
# 8 → Hidden

echo -e "\e[3;31m Hello! \n Welcome Shripad \e[0m"
echo -e "\e[4;31m Hello! \n Welcome to Shripad \e[0m"

echo -e "\e[31m \t ** Show me Red Colour ** \e[0m"
echo -e "\e[32m \t ** Show me Green Colour ** \e[0m"
echo -e "\e[34m \t ** Show me Blue Colour ** \e[0m"
echo -e "\e[33m \t ** Show me Yellow Colour ** \e[0m"

# Print background colours
echo -e "\e[41m \t ** Show me Red Colour ** \e[0m"
echo -e "\e[42m \t ** Show me Green Colour ** \e[0m"
echo -e "\e[44m \t ** Show me Blue Colour ** \e[0m"
echo -e "\e[43m \t ** Show me Yellow Colour ** \e[0m"

 echo -e "\e[32m ** Running step: $STEP ** \e[0m"
 echo -e "\e[31m ❌ Step '$STEP' failed with exit status $STATUS. Exiting script. \e[0m"





