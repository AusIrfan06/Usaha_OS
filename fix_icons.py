import re

# Fix Tab icons
def replace_in_file(filepath, replacements):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    for old, new in replacements:
        content = content.replace(old, new)
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

replace_in_file('lib/features/expenses/expenses_screen.dart', [
    ("Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedSquare), text: 'Log Perbelanjaan')", 
     "Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedFile02), text: 'Log Perbelanjaan')")
])

replace_in_file('lib/features/inventory/stock_take_screen.dart', [
    ("Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedSquare), text: 'Log Audit & Varians')", 
     "Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedFile02), text: 'Log Audit & Varians')")
])

replace_in_file('lib/features/analytics/advanced_analytics_screen.dart', [
    ("Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedSquare), text: 'Peta Waktu Puncak (Heatmap)')", 
     "Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedClock01), text: 'Peta Waktu Puncak (Heatmap)')"),
    ("Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedSquare), text: 'Prestasi Staf')", 
     "Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedUser), text: 'Prestasi Staf')")
])

# Disable NavigationRail pill indicator
with open('lib/core/router/app_router.dart', 'r', encoding='utf-8') as f:
    router_content = f.read()

router_content = router_content.replace(
    'extended: extended,\n                    selectedIndex: _index,',
    'extended: extended,\n                    useIndicator: false,\n                    selectedIndex: _index,'
)

with open('lib/core/router/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(router_content)
print('Done')
