#!/bin/bash

# There are 4 types of Commands available :

# 1. Binary                    (bin, /sbin, /usr/bin,  Check by ex- "type df, type sudo)
# 2. Aliases                   (aliases are shortcuts alias net="netstat -tulpn")
# 3. Shell Built-in Commands   (echo, cd, pwd, exit, check by ex- "type echo, type cd")
# 4. Functions                 (user defined functions, when u have a common pattern of code which is used in multiple scripts, u can create a function and call it in all the scripts)

# $ type df
# df is /usr/bin/df
# $ type alias
# alias is a shell builtin
# $ type cd
# cd is a shell builtin


# By adding the aliases in .bash_profile, you can make them permanent for your user profile.
# Each & every user profile have thrie own .bash_profile.



# Declare a function & call it
# function_name() {
#     echo "This is a function"
# }
# function_name


set -x                  # THis is to enabel DEBUG mode, it will print each command before executing it
# set +x                  # This is to disable the debug mode
# set -e                  # This is to exit the script if any command fails
# set -u                  # This is to exit the script if any variable is not defined
# set -o pipefail        # This is to exit the script if any command in a pipeline fails
# set -o noclobber       # This is to prevent overwriting files with redirection
# set -o errexit        # This is to exit the script if any command fails
# set -o nounset        # This is to exit the script if any variable is not defined
# set -o xtrace        # This is to enable debug mode
# set -o posix        # This is to enable POSIX mode
# set -o vi          # This is to enable vi mode in the shell

stat() {
    echo "Today is $(date +%A)"            # whenever we want to print system defined variables, we use that in parenthesis
    echo "The current time is $(date +%T)"
    echo "Load on the system is $(uptime | awk '{print $10}')"
}

stat
