import datetime

# Product Data
product_ids = [41, 42, 43, 44, 46, 31, 32, 33, 34, 35, 36]
product_names = [
    "Snickers", "S'lai o lai", "Sando cheese", "Sando chocolate", "Cheese biscuit",
    "Fuze tea peach", "Coca cola", "0.5L Water Bottle", "Mirinda vanilla", "Mirinda strawberry", "Coca cola Zero"
]
product_prices = [30, 25, 20, 20, 15, 25, 30, 10, 20, 20, 30]
product_qty = [10, 8, 6, 6, 5, 10, 12, 15, 9, 7, 5]

# Log file
log_file = "vending_log_table.txt"

# Function to log purchases in table format
def log_table(purchases):
    now = datetime.datetime.now()
    date = now.strftime("%Y-%m-%d")
    time = now.strftime("%H:%M:%S")

    with open(log_file, "a") as f:
        f.write("\n")
        f.write("=" * 60 + "\n")
        f.write(f"DATE: {date}    TIME: {time}\n")
        f.write("=" * 60 + "\n")
        f.write(f"{'ID':<6}{'Product Name':<25}{'Qty Left':<12}{'Purchased':<10}\n")
        f.write("=" * 60 + "\n")
        for index, qty_purchased in purchases:
            f.write(f"{product_ids[index]:<6}{product_names[index]:<25}{product_qty[index]:<12}{qty_purchased:<10}\n")
        f.write("=" * 60 + "\n")

# Show products
def show_products():
    print("\n========= Snacks =========")
    for i in range(5):
        print(f"[{product_ids[i]}] {product_names[i]} - Rs{product_prices[i]} (Qty: {product_qty[i]})")
    print("\n========= Drinks =========")
    for i in range(5, len(product_ids)):
        print(f"[{product_ids[i]}] {product_names[i]} - Rs{product_prices[i]} (Qty: {product_qty[i]})")
    print()

# Main vending machine
def vending_machine():
    total_cost = 0
    purchased_items = []

    while True:
        show_products()
        try:
            pid = int(input("Enter product ID: "))
        except:
            print("Invalid input.\n")
            continue

        if pid not in product_ids:
            print("❌ Product ID not found.\n")
            continue

        index = product_ids.index(pid)
        name = product_names[index]
        stock = product_qty[index]
        price = product_prices[index]

        try:
            qty = int(input(f"Enter quantity for {name}: "))
        except:
            print("Invalid quantity.\n")
            continue

        if qty <= 0:
            print("❌ Quantity must be more than 0.\n")
            continue
        if qty > stock:
            print(f"⚠️ Only {stock} left.\n")
            continue

        cost = qty * price
        total_cost += cost
        product_qty[index] -= qty
        purchased_items.append((index, qty))

        print(f"✅ {qty} x {name} added. Subtotal = Rs{cost}\n")

        cont = input("Add more items? (y/n): ").lower()
        if cont != 'y':
            break

    print(f"\n🧾 Total amount to pay: Rs{total_cost}")
    inserted = 0

    while inserted < total_cost:
        try:
            amt = int(input(f"Insert money (Remaining: Rs{total_cost - inserted}): "))
        except:
            print("Invalid amount.\n")
            continue
        if amt not in [5, 10, 20, 25, 50, 100, 200, 500, 1000]:
            print("❌ Invalid denomination.\n")
            continue
        inserted += amt
        print(f"Accepted Rs{amt}. Total inserted: Rs{inserted}")

    change = inserted - total_cost
    print(f"\nChange to return: Rs{change}")
    print("🎉 Purchase complete!\n")

    print("🛍️ Summary:")
    for item in purchased_items:
        index, qty = item
        name = product_names[index]
        price = product_prices[index]
        print(f"{qty} x {name} = Rs{qty * price}")

    # Log to table
    log_table(purchased_items)

    print("\n📄 Purchase logged in:", log_file)

# Run it
vending_machine()
