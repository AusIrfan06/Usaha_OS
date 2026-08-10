import re

files = [
    'lib/features/suppliers/suppliers_po_screen.dart',
    'lib/features/inventory/stock_take_screen.dart',
    'lib/features/expenses/expenses_screen.dart'
]

def convert_to_light(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Imports
    content = content.replace("import '../../core/theme/app_colors.dart';", "import '../../core/theme/app_theme.dart';\nimport '../../core/theme/app_colors.dart';")

    # Backgrounds and containers
    content = content.replace('AppColors.backgroundDark', 'AppTheme.warmCream')
    content = content.replace('AppColors.surfaceDark', 'Colors.white')
    content = content.replace('AppColors.cardDark', 'Colors.white')
    content = content.replace('AppColors.textMuted', 'AppTheme.mutedText')
    content = content.replace('AppColors.primary', 'AppTheme.primaryCoffee')

    # Text styles (remove hardcoded white so it inherits AppTheme.darkEspresso or ElevatedButton's white)
    content = content.replace('color: Colors.white, ', '')
    content = content.replace('color: Colors.white)', ')')
    content = content.replace('color: Colors.white70, ', 'color: AppTheme.mutedText, ')
    content = content.replace('color: Colors.white70)', 'color: AppTheme.mutedText)')
    content = content.replace('color: Colors.white54, ', 'color: AppTheme.mutedText, ')
    content = content.replace('color: Colors.white54)', 'color: AppTheme.mutedText)')
    content = content.replace('color: Colors.white38, ', 'color: AppTheme.mutedText, ')
    content = content.replace('color: Colors.white38)', 'color: AppTheme.mutedText)')
    content = content.replace('color: Colors.white30, ', 'color: AppTheme.mutedText, ')
    content = content.replace('color: Colors.white30)', 'color: AppTheme.mutedText)')

    # Borders and dividers
    content = content.replace('color: Colors.white10', 'color: AppTheme.mutedText.withOpacity(0.2)')
    content = content.replace('color: Colors.white12', 'color: AppTheme.mutedText.withOpacity(0.2)')

    # Specific icon colors where Colors.white was used outside TextStyle
    content = content.replace('color: Colors.white, size:', 'color: AppTheme.darkEspresso, size:')

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

for f in files:
    convert_to_light(f)

print("Conversion complete.")
