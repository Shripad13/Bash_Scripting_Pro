# Typecasting - The process of converting one data type to another is called typecasting.
# TO know DataTypes in Python, we can use the type() function.
# The type() function returns the type of the object passed to it.


######## Explicit Typecasting ########

name = "Shripad"     # String
age =  25             # Integer
gpa = 9.2            # Float
student = True       # Boolean


print(type(name))
print(type(age))
print(type(gpa))
print(type(student))

age = float(age) # Converting Integer to Float
print(age)

gpa = int(gpa)   # Converting Float to Integer
print(gpa)

student = str(student)  # Converting Boolean to String
print(student)

age = bool(age)  # Converting Integer to Boolean
print(age)

name = bool(name)  # Converting String to Boolean
print(name)

######## Implicit Typecasting ########
#Implicit typecasting is done automatically by Python during an operation, without the programmer needing to specify it.


x = 2 
y = 2.0

x = x / y  # Implicitly converts Integer to Float
print(x)