import 'package:hugeicons/hugeicons.dart';
import 'dart:math';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/feature_flags.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';
import '../../data/models/cart_item.dart';
import '../../shared/widgets/common_widgets.dart';

class PosScreen extends ConsumerWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.of(context).size.width >= 700;
    if (isTablet) {
      return const _PosTabletLayout();
    }
    return const _PosPhoneLayout();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tablet: side-by-side menu + cart
// ─────────────────────────────────────────────────────────────────────────────

class _PosTabletLayout extends ConsumerWidget {
  const _PosTabletLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _PosAppBar(),
      body: Row(
        children: [
          // Menu area (flex 3)
          const Expanded(flex: 3, child: _MenuArea()),
          // Divider
          Container(width: 1, color: const Color(0xFFEDE3D8)),
          // Cart panel (flex 2)
          const SizedBox(
            width: 360,
            child: _CartPanel(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Phone: full screen menu + FAB for cart
// ─────────────────────────────────────────────────────────────────────────────

class _PosPhoneLayout extends ConsumerWidget {
  const _PosPhoneLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final itemCount = cartNotifier.totalItemCount;

    return Scaffold(
      appBar: _PosAppBar(),
      body: const _MenuArea(),
      floatingActionButton: cart.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _showCartSheet(context, ref),
              backgroundColor: AppTheme.primaryCoffee,
              foregroundColor: Colors.white,
              icon: HugeIcon(icon: HugeIcons.strokeRoundedShoppingCart01),
              label: Text(
                '$itemCount item${itemCount == 1 ? '' : 's'} — '
                '${CurrencyFormatter.format(cartNotifier.subtotal)}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          : null,
    );
  }

  void _showCartSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: const _CartPanel(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared POS App Bar
// ─────────────────────────────────────────────────────────────────────────────

class _PosAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('POS'),
      actions: [
        // Sync dot
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              const SyncDot(isOnline: true),
              const SizedBox(width: 6),
              Text('Usaha OS',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.mutedText,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Menu Area: Category tabs + item grid
// ─────────────────────────────────────────────────────────────────────────────

class _MenuArea extends ConsumerWidget {
  const _MenuArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final menuItemsAsync = ref.watch(menuItemsProvider);
    final selectedCat = ref.watch(selectedCategoryProvider);
    final isTablet = MediaQuery.of(context).size.width >= 700;

    return Column(
      children: [
        // Category tabs
        categoriesAsync.when(
          loading: () => const SizedBox(height: 60),
          error: (_, __) => const SizedBox.shrink(),
          data: (cats) => _CategoryTabs(
            categories: cats,
            selectedId: selectedCat,
            onSelect: (id) =>
                ref.read(selectedCategoryProvider.notifier).state = id,
          ),
        ),
        // Menu grid
        Expanded(
          child: menuItemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) =>
                const Center(child: Text('Error loading menu')),
            data: (items) {
              if (items.isEmpty) {
                return const EmptyState(
                  icon: HugeIcons.strokeRoundedCircle,
                  title: 'No items',
                  subtitle: 'Select another category',
                );
              }
              return _MenuGrid(items: items, isTablet: isTablet);
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  final List<Category> categories;
  final int? selectedId;
  final void Function(int?) onSelect;

  const _CategoryTabs({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppTheme.cardBg,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('All'),
              selected: selectedId == null,
              onSelected: (_) => onSelect(null),
              selectedColor: AppTheme.primaryCoffee.withOpacity(0.15),
              checkmarkColor: AppTheme.primaryCoffee,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: selectedId == null
                    ? AppTheme.primaryCoffee
                    : AppTheme.mutedText,
              ),
            ),
          ),
          ...categories.map((cat) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat.name),
                  selected: selectedId == cat.id,
                  onSelected: (_) =>
                      onSelect(selectedId == cat.id ? null : cat.id),
                  selectedColor: AppTheme.primaryCoffee.withOpacity(0.15),
                  checkmarkColor: AppTheme.primaryCoffee,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: selectedId == cat.id
                        ? AppTheme.primaryCoffee
                        : AppTheme.mutedText,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _MenuGrid extends ConsumerWidget {
  final List<MenuItem> items;
  final bool isTablet;

  const _MenuGrid({required this.items, required this.isTablet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);

    return GridView.builder(
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 4 : 2,
        childAspectRatio: isTablet ? 0.85 : 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        return _MenuItemCard(
          item: item,
          onAdd: () => cartNotifier.addItem(item),
        );
      },
    );
  }
}

class _MenuItemCard extends ConsumerWidget {
  final MenuItem item;
  final VoidCallback onAdd;

  const _MenuItemCard({required this.item, required this.onAdd});

  Color get _stationColor {
    return switch (item.preparationStation) {
      'bar' => AppTheme.duitNowBlue,
      'pastry' => AppTheme.primaryCoffee,
      _ => AppTheme.successGreen,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(
      cartProvider.select((cart) {
        final idx = cart.indexWhere((i) => i.menuItem.id == item.id);
        return idx >= 0 ? cart[idx].quantity : 0;
      }),
    );
    final cartNotifier = ref.read(cartProvider.notifier);
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onAdd,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: qty > 0
              ? Border.all(color: AppTheme.primaryCoffee, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A3E2004),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Station color strip
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: _stationColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: tt.titleSmall?.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          if (item.description.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(item.description,
                                style: tt.bodySmall?.copyWith(
                                    fontSize: 11,
                                    color: AppTheme.mutedText),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          CurrencyFormatter.format(item.basePrice),
                          style: tt.titleSmall?.copyWith(
                              color: AppTheme.primaryCoffee,
                              fontWeight: FontWeight.w800,
                              fontSize: 13),
                        ),
                        if (qty > 0)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    cartNotifier.decrementItem(item.id),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryCoffee
                                        .withOpacity(0.12),
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  child: HugeIcon(icon: HugeIcons.strokeRoundedRemove01,
                                      size: 14,
                                      color: AppTheme.primaryCoffee),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6),
                                child: Text('$qty',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                        color: AppTheme.primaryCoffee)),
                              ),
                              GestureDetector(
                                onTap: onAdd,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryCoffee,
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  child: HugeIcon(icon: HugeIcons.strokeRoundedAdd01,
                                      size: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        else
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryCoffee,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: HugeIcon(icon: HugeIcons.strokeRoundedAdd01,
                                size: 16, color: Colors.white),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cart Panel (used in tablet right pane + phone bottom sheet)
// ─────────────────────────────────────────────────────────────────────────────

class _CartPanel extends ConsumerStatefulWidget {
  const _CartPanel();

  @override
  ConsumerState<_CartPanel> createState() => _CartPanelState();
}

class _CartPanelState extends ConsumerState<_CartPanel> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final orderType = ref.watch(orderTypeProvider);
    final tt = Theme.of(context).textTheme;

    final subtotal = cartNotifier.subtotal;
    final tax = FeatureFlags.sstEnabled
        ? subtotal * FeatureFlags.sstRate
        : 0.0;
    final total = subtotal + tax;

    return Column(
      children: [
        // ── Header ────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xFFEDE3D8))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Order',
                      style: tt.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const Spacer(),
                  if (cart.isNotEmpty)
                    TextButton.icon(
                      onPressed: () =>
                          ref.read(cartProvider.notifier).clear(),
                      icon: HugeIcon(icon: HugeIcons.strokeRoundedDelete01,
                          size: 16, color: AppTheme.dangerRed),
                      label: const Text('Clear',
                          style: TextStyle(
                              color: AppTheme.dangerRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // Order type
              Row(
                children: [
                  _TypeChip(
                    label: 'Takeaway',
                    icon: HugeIcons.strokeRoundedCircle,
                    selected: orderType == AppConstants.takeaway,
                    onTap: () => ref
                        .read(orderTypeProvider.notifier)
                        .state = AppConstants.takeaway,
                  ),
                  const SizedBox(width: 8),
                  _TypeChip(
                    label: 'Dine-in',
                    icon: HugeIcons.strokeRoundedCircle,
                    selected: orderType == AppConstants.dineIn,
                    onTap: () => ref
                        .read(orderTypeProvider.notifier)
                        .state = AppConstants.dineIn,
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Cart Items ────────────────────────────────────────────
        Expanded(
          child: cart.isEmpty
              ? const EmptyState(
                  icon: HugeIcons.strokeRoundedShoppingCart01,
                  title: 'Cart is empty',
                  subtitle: 'Tap menu items to add them here',
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: cart.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1),
                  itemBuilder: (context, i) =>
                      _CartItemRow(item: cart[i]),
                ),
        ),

        // ── Totals + Charge ───────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppTheme.cardBg,
            border: Border(
                top: BorderSide(color: Color(0xFFEDE3D8))),
          ),
          child: Column(
            children: [
              _TotalRow(
                  label: 'Subtotal',
                  amount: CurrencyFormatter.format(subtotal)),
              if (FeatureFlags.sstEnabled) ...[
                const SizedBox(height: 4),
                _TotalRow(
                    label: 'SST (6%)',
                    amount: CurrencyFormatter.format(tax)),
              ] else ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('SST',
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.mutedText)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.mutedText.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('OFF',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.mutedText)),
                    ),
                    const Spacer(),
                    const Text('RM 0.00',
                        style: TextStyle(
                            fontSize: 14, color: AppTheme.mutedText)),
                  ],
                ),
              ],
              const Divider(height: 20),
              Row(
                children: [
                  Text('Total',
                      style: tt.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  const Spacer(),
                  Text(
                    CurrencyFormatter.format(total),
                    style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppTheme.primaryCoffee),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: cart.isEmpty
                      ? null
                      : () => _charge(context, ref, total),
                  icon: HugeIcon(icon: HugeIcons.strokeRoundedRegister,
                      size: 20),
                  label: Text(
                    'Charge ${CurrencyFormatter.format(total)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _charge(
      BuildContext context, WidgetRef ref, double total) async {
    final db = ref.read(databaseProvider);
    final cart = ref.read(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final orderType = ref.read(orderTypeProvider);
    final tableNumber = ref.read(tableNumberProvider);

    if (cart.isEmpty) return;

    final subtotal = cartNotifier.subtotal;
    final tax = FeatureFlags.sstEnabled
        ? subtotal * FeatureFlags.sstRate
        : 0.0;
    final now = DateTime.now();
    final rnd = Random().nextInt(9000) + 1000;
    final orderNumber =
        'ORD${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}-$rnd';

    final orderId = await db.createOrder(
      OrdersCompanion.insert(
        orderNumber: orderNumber,
        orderType: Value(orderType),
        tableNumber: Value(tableNumber),
        subtotal: Value(subtotal),
        taxAmount: Value(tax),
        totalAmount: Value(total),
        notes: const Value(''),
      ),
    );

    for (final cartItem in cart) {
      await db.addOrderItem(
        OrderItemsCompanion.insert(
          orderId: orderId,
          menuItemId: cartItem.menuItem.id,
          itemName: cartItem.menuItem.name,
          quantity: cartItem.quantity,
          unitPrice: cartItem.menuItem.basePrice,
          subtotal: cartItem.subtotal,
        ),
      );
    }

    if (context.mounted) {
      context.push('/payment/$orderId');
    }
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final dynamic icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primaryCoffee.withOpacity(0.15)
              : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: selected
              ? Border.all(
                  color: AppTheme.primaryCoffee, width: 1.5)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(icon: icon,
                size: 14,
                color: selected
                    ? AppTheme.primaryCoffee
                    : AppTheme.mutedText),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? AppTheme.primaryCoffee
                        : AppTheme.mutedText)),
          ],
        ),
      ),
    );
  }
}

class _CartItemRow extends ConsumerWidget {
  final CartItem item;
  const _CartItemRow({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Qty controls
          Row(
            children: [
              GestureDetector(
                onTap: () => notifier.decrementItem(item.menuItem.id),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: HugeIcon(icon: HugeIcons.strokeRoundedRemove01,
                      size: 14, color: AppTheme.primaryCoffee),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                child: Text('${item.quantity}',
                    style: tt.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
              ),
              GestureDetector(
                onTap: () => notifier.addItem(item.menuItem),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryCoffee,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: HugeIcon(icon: HugeIcons.strokeRoundedAdd01,
                      size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Name
          Expanded(
            child: Text(item.menuItem.name,
                style: tt.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          // Price
          Text(CurrencyFormatter.format(item.subtotal),
              style: tt.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkEspresso)),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String amount;

  const _TotalRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14, color: AppTheme.mutedText)),
        const Spacer(),
        Text(amount,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkEspresso)),
      ],
    );
  }
}
