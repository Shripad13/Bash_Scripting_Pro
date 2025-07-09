# Variables in Python - Strings, Integers, Floats, Booleans.

# Strings - series of characters
# Call variable in {} braces in sentences

first_name = "Shripad"
food = "Vada Pav"
email = "shripad@gmail.com"


print(first_name)                 # It will take as variable name
print("first_name")               # It will not take as variable name because in Double quotes, it acts as string
print(f"{first_name} is a DevOps Engineer")    # f is the format string
print( f"I like {food}" )
print(f"my email is : {email}")

# Integers

age = 25      # Integers should not be enclosed
quantity = 3
students = 30

print(f"You are {age} years old")
print(f"you are buying {quantity} items")
print(f"In your class have {students} number of students")

# Floats - 

price = 10.999
gpa = 3.4
distance = 4.5
print(f"The price is : {price}")
print(f"your GPA is : {gpa}")
print(f"You ran  {distance}")

# Boolean - True/False

is_student = False
for_sale = True
is_online = False

if is_student:
    print("You are a student")
else:
    print("You are Not a student")
    
if for_sale:
    print("That item is discounted")
else:
    print("That item is NOT discounted")
    
if is_online:
    print("You are online")
else:
    print("You are offline")
    
