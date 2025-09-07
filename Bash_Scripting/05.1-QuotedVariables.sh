#!/bin/bash

#Quoted $@
echo "Using \"\$@\":"
for arg in "$@"; do
  echo "[$arg]"
done

#Quoted $*

echo "**** Quoted ****"

echo "Using \"\$*\":"
for arg in "$*"; do
  echo "[$arg]"
done

#Run as - bash 05.1-QuotedVariables.sh one "two three" four

: << 'COMMENT_BLOCK'
Use Case	                                             Prefer
Preserving each argument (especially with spaces)	     "${@}"
Passing all arguments as a single string	             "$*"


Variable	          Output
$@	                 ["apple", "banana split", "cherry"] (array of words)
$*	                 "apple banana split cherry" (single string)

COMMENT_BLOCK