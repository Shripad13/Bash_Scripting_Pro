
#!/bin/bash 

<<COMMENT
```
### Expressions are categorized in to three types and based on the expression, we need to use operators
```
    1. Numbers
    2. Strings
    3. Files
```

Operators on numbers:
```
    -eq , -ne , -gt, -ge, -lt, -le

    [ 1 -eq 1 ] 
    [ 1 -ne 1 ]
```

Operators on Strings: ( a=10, abc == abc, a != b) 

    = , == , !=

    [ abc = abc ]


    -z , -n 

    [ -z "$var" ] -> This is true if var is not having any data
    [ -n "$var" ] _> This is true if var is having any data

    -z and -n are inverse proportional options


Operators on files:
    Lot of operators are available and you can check them using man pages of bash 

    [ -f file ] -> True of file exists and file is a regular file 

    [ -d xyz ]  -> True if file exists and it is a directory
    [ -w file ] -> True if file exists and it is writable
    [ -x file ] -> True if file exists and it is executable
    [ -s file ] -> True if file exists and it is not empty
    [ -L file ] -> True if file exists and it is a symbolic link

    ### Explore the file types, There are 7 types on files in Linux.
COMMENT


1. Regular File (-f):

This checks if a file is a regular file (i.e., not a directory or special file).

Example: -f filename

if [ -f "file.txt" ]; then
  echo "This is a regular file"
fi

2. Directory (-d):

This checks if the file is a directory.

Example: -d filename

if [ -d "mydir" ]; then
  echo "This is a directory"
fi

3. Executable File (-x):

This checks if the file is executable.

Example: -x filename

if [ -x "script.sh" ]; then
  echo "This file is executable"
fi

4. Readable File (-r):

This checks if the file is readable.

Example: -r filename

if [ -r "file.txt" ]; then
  echo "This file is readable"
fi

5. Writable File (-w):

This checks if the file is writable.

Example: -w filename

if [ -w "file.txt" ]; then
  echo "This file is writable"
fi

6. Empty File (-s):

This checks if the file exists and has a size greater than zero (i.e., it's not empty).

Example: -s filename

if [ -s "file.txt" ]; then
  echo "This file is not empty"
fi

7. Symbolic Link (-L):
Not so required

## combined usage:

You can also combine these tests with logical operators like && (AND) and || (OR) for more complex conditions:

if [ -f "file.txt" ] && [ -r "file.txt" ]; then
  echo "The file is a regular file and readable"
fi