import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';
import '../../data/models/cart_item.dart';

void showAddonSheet(BuildContext context, WidgetRef ref, MenuItem item) {
  final db = ref.read(databaseProvider);
  final cartNotifier = ref.read(cartProvider.notifier);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => FutureBuilder<List<MenuAddon>>(
      future: db.getAddonsForItem(item.id),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        }
        final addons = snap.data ?? [];
        if (addons.isEmpty) {
          // No add-ons — add directly and close
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cartNotifier.addItem(item);
            Navigator.pop(ctx);
          });
          return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
        }
        return _AddonSheetContent(item: item, addons: addons);
      },
    ),
  );
}

class _AddonSheetContent extends ConsumerStatefulWidget {
  final MenuItem item;
  final List<MenuAddon> addons;
  const _AddonSheetContent({required this.item, required this.addons});

  @override
  ConsumerState<_AddonSheetContent> createState() => _AddonSheetContentState();
}

class _AddonSheetContentState extends ConsumerState<_AddonSheetContent> {
  final Set<int> _selectedAddonIds = {};

  double get _totalPrice {
    double addonsPrice = 0;
    for (final addon in widget.addons) {
      if (_selectedAddonIds.contains(addon.id)) addonsPrice += addon.price;
    }
    return widget.item.basePrice + addonsPrice;
  }

  /// Group addons by category for display
  Map<String, List<MenuAddon>> get _groupedAddons {
    final map = <String, List<MenuAddon>>{};
    for (final a in widget.addons) {
      map.putIfAbsent(a.category, () => []).add(a);
    }
    return map;
  }

  String _categoryLabel(String cat) => switch (cat) {
    'size_upgrade' => 'Saiz',
    'ice_level' => 'Tahap Ais',
    'sugar_level' => 'Tahap Gula',
    'extra' => 'Tambahan',
    'topping' => 'Topping',
    'sauce' => 'Sos',
    'milk_type' => 'Jenis Susu',
    _ => cat,
  };

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final groups = _groupedAddons;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      expand: false,
      builder: (ctx, scrollController) => Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: AppTheme.mutedText.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Item header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.name, style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                      if (widget.item.description.isNotEmpty)
                        Text(widget.item.description, style: tt.bodySmall?.copyWith(color: AppTheme.mutedText)),
                    ],
                  ),
                ),
                Text(
                  CurrencyFormatter.format(_totalPrice),
                  style: tt.titleMedium?.copyWith(
                    color: AppTheme.primaryCoffee,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Add-on groups
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: groups.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _categoryLabel(entry.key),
                      style: tt.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.mutedText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: entry.value.map((addon) {
                        final selected = _selectedAddonIds.contains(addon.id);
                        return FilterChip(
                          label: Text(
                            addon.price > 0
                                ? '${addon.name} (+${CurrencyFormatter.format(addon.price)})'
                                : addon.name,
                          ),
                          selected: selected,
                          onSelected: (val) => setState(() {
                            if (val) {
                              _selectedAddonIds.add(addon.id);
                            } else {
                              _selectedAddonIds.remove(addon.id);
                            }
                          }),
                          selectedColor: AppTheme.primaryCoffee.withOpacity(0.15),
                          checkmarkColor: AppTheme.primaryCoffee,
                          labelStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected ? AppTheme.primaryCoffee : AppTheme.darkEspresso,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
          // Add to cart button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: () {
                    final selectedAddons = widget.addons
                        .where((a) => _selectedAddonIds.contains(a.id))
                        .map((a) => SelectedAddon(id: a.id, name: a.name, price: a.price))
                        .toList();
                    ref.read(cartProvider.notifier).addItem(widget.item, addons: selectedAddons);
                    Navigator.pop(context);
                  },
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedShoppingCart01, color: Colors.white, size: 20),
                  label: Text(
                    'Tambah ke Troli — ${CurrencyFormatter.format(_totalPrice)}',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.primaryCoffee,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
