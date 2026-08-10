import os
import re

replacements = {
    'lib/features/kds/kds_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCoffee01", 1), # bar
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedRestaurant01", 1), # kitchen
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedPieceOfCake", 1), # pastry
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedHistory", 1), # recall
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedRestaurant01", 1), # dine in
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedShoppingBag01", 1), # takeaway
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedDeliveryBox01", 1), # delivery
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedClock01", 1), # time 
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedRestaurant01", 1), # order type
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedShoppingBag01", 1), # order type
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedTimeQuarterPast", 1), # wait time
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedPlay", 1), # start
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCheckmarkBadge01", 1), # ready
    ],
    'lib/features/orders/orders_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedClock01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedWallet01", 1),
    ],
    'lib/features/loyalty/loyalty_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedGift", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedSearch01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedStar", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedUser", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCoffee01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedTicket01", 1),
    ],
    'lib/features/outlets/outlets_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedStore01", 1), # list
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedPackage", 1), # transfer
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedPackage", 1), # icon tab 2
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedStore01", 1), # outlet icon
    ],
    'lib/features/payment/payment_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedQrCode", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedDelete02", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCheckmarkBadge01", 1),
    ],
    'lib/features/payment/receipt_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedShare01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedPrinter", 1),
    ],
    'lib/features/pos/pos_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedShoppingCart01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedShoppingBag01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedRestaurant01", 1),
    ],
    'lib/features/reports/reports_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedDashboardSquare01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedFile02", 1),
    ],
    'lib/features/settings/settings_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedStore01", 1), # section
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedStore01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedLocation01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCall", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedPrinter", 1), # section
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedBluetooth", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedSearch01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCloudServer", 1), # section
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCloudUpload", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedDatabase", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedSettings02", 1),
    ],
    'lib/features/tasks/tasks_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedTask01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedUserSwitch", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedTask01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCheckmarkBadge01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCircle", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCheckmarkBadge01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedCircle", 1),
    ],
    'lib/features/suppliers/suppliers_po_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedAddressBook", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedInvoice01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedBuilding04", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedStore01", 1),
    ],
    'lib/features/staff/staff_screen.dart': [
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedUserGroup", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedUser", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedUserAdd01", 1),
        (r"HugeIcons\.strokeRoundedCircle", r"HugeIcons.strokeRoundedUser", 1),
    ]
}

for file_path, reps in replacements.items():
    if not os.path.exists(file_path):
        continue
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for pattern, repl, count in reps:
        content = re.sub(pattern, repl, content, count=count)
        
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

print("Replacement complete.")
