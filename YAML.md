1. What are the basic rules of writing YAML syntax?

Use indentation with spaces (not tabs)
Key-value pairs separated by :
Lists start with -
Strings don’t require quotes unless needed

# A map stores data as a set of key-value pairs.
person:
  name: Alice
  age: 30
  city: New York

A list stores an ordered collection of values.
fruits:
  - Apple
  - Banana
  - Mango

# what are the common pitfalls of YAML 
 Using Tabs Instead of Spaces
 YAML is indentation-sensitive. Mixed or uneven indentation causes parsing errors.
 Lists must be consistently defined. Mixing styles leads to errors.
 Don’t overuse or misuse quotes.
 Duplicated Keys not allowed.
 Multi-line Strings Confusion -
 | keeps newlines
 > folds lines into a single line

Always validate use linters or yamllint.