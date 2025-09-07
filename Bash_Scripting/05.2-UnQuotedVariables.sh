#!/bin/bash
echo "Unquoted \$@:"
for arg in $@; do
  echo "[$arg]"
done

echo "Unquoted \$*:"
for arg in $*; do
  echo "[$arg]"
done



#Run as - bash 05.2-UnQuotedVariables.sh one "two three" four five