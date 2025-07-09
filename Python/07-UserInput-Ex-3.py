# Shopping Cart

item = input("What item would you like to buy?: ")
price = float(input("What is the price?:"))
quantity = int(input("How many would like you like?:"))

Total = price * quantity

print(f"You have bought {quantity} x {item}/s")
print(f"Your total is : ${Total}")
print(f"Your total is : ${round(Total, 2)}")