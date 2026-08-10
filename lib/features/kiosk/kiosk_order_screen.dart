import 'dart:math';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/feature_flags.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';
import '../../data/models/cart_item.dart';
import '../../shared/widgets/addon_sheet.dart';
import '../pos/cart_notifier.dart';

/// Kiosk Order Screen — McDonald's / Self-Service style.
/// Left side: category tabs + menu grid.
/// Right side: live cart panel with totals.
///
/// Uses the SAME cartProvider / categoriesProvider / menuItemsProvider from POS,
/// so all data stays in sync.
class KioskOrderScreen extends ConsumerStatefulWidget {
  const KioskOrderScreen({super.key});

  @override
  ConsumerState<KioskOrderScreen> createState() => _KioskOrderScreenState();
}

class _KioskOrderScreenState extends ConsumerState<KioskOrderScreen> {
  void _resetInactivity() {
    // Reserved for future inactivity timeout
  }

  @override
  void initState() {
    super.initState();
    // Clear cart when entering kiosk (fresh order)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartProvider.notifier).clear();
      ref.read(orderTypeProvider.notifier).state = 'takeaway';
    });
  }

  void _cancelOrder() {
    ref.read(cartProvider.notifier).clear();
    context.go('/kiosk');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _resetInactivity(),
      child: Scaffold(
        backgroundColor: AppTheme.warmCream,
        body: Column(
          children: [
            // ── Top Bar ──
            _KioskTopBar(onCancel: _cancelOrder),

            // ── Main Content (menu + cart) ──
            Expanded(
              child: Row(
                children: [
                  // Left: Menu area (65%)
                  const Expanded(flex: 65, child: _KioskMenuArea()),
                  // Divider
                  Container(width: 1, color: const Color(0xFFEDE3D8)),
                  // Right: Cart panel (35%)
                  Expanded(
                    flex: 35,
                    child: _KioskCartPanel(onCancel: _cancelOrder),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Kiosk Top Bar
// ─────────────────────────────────────────────────────────────────────────────

class _KioskTopBar extends StatelessWidget {
  final VoidCallback onCancel;

  const _KioskTopBar({required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Cancel / Back
            TextButton.icon(
              onPressed: onCancel,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppTheme.dangerRed,
                size: 20,
              ),
              label: const Text(
                'Batal',
                style: TextStyle(
                  color: AppTheme.dangerRed,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            const Spacer(),
            // Title
            Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedTouchInteraction01,
                  color: AppTheme.primaryCoffee,
                  size: 22,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Kiosk Layan Diri',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkEspresso,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Order type selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.successGreen.withOpacity(0.3),
                ),
              ),
              child: const Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                    color: AppTheme.successGreen,
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Kiosk Aktif',
                    style: TextStyle(
                      color: AppTheme.successGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Kiosk Menu Area — Categories + Grid
// ─────────────────────────────────────────────────────────────────────────────

class _KioskMenuArea extends ConsumerWidget {
  const _KioskMenuArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final menuItemsAsync = ref.watch(menuItemsProvider);
    final selectedCat = ref.watch(selectedCategoryProvider);

    return Column(
      children: [
        // Category tabs
        categoriesAsync.when(
          loading: () => const SizedBox(height: 60),
          error: (_, __) => const SizedBox.shrink(),
          data: (cats) => _KioskCategoryTabs(
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
            error: (_, __) => const Center(child: Text('Ralat memuatkan menu')),
            data: (items) {
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedShoppingCart01,
                        color: AppTheme.mutedText.withOpacity(0.4),
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tiada item dalam kategori ini',
                        style: TextStyle(
                          color: AppTheme.mutedText,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _KioskMenuGrid(items: items);
            },
          ),
        ),
      ],
    );
  }
}

class _KioskCategoryTabs extends StatelessWidget {
  final List<Category> categories;
  final int? selectedId;
  final void Function(int?) onSelect;

  const _KioskCategoryTabs({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // "Semua" chip
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _KioskCategoryChip(
              label: 'Semua',
              selected: selectedId == null,
              onTap: () => onSelect(null),
            ),
          ),
          ...categories.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _KioskCategoryChip(
                label: cat.name,
                selected: selectedId == cat.id,
                onTap: () => onSelect(selectedId == cat.id ? null : cat.id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KioskCategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _KioskCategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryCoffee : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryCoffee.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppTheme.darkEspresso,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Kiosk Menu Grid — Bigger cards for touch
// ─────────────────────────────────────────────────────────────────────────────

class _KioskMenuGrid extends ConsumerWidget {
  final List<MenuItem> items;

  const _KioskMenuGrid({required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        return _KioskMenuCard(item: items[i]);
      },
    );
  }
}

class _KioskMenuCard extends ConsumerWidget {
  final MenuItem item;

  const _KioskMenuCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(
      cartProvider.select((cart) {
        final idx = cart.indexWhere((i) => i.menuItem.id == item.id);
        return idx >= 0 ? cart[idx].quantity : 0;
      }),
    );
    final cartNotifier = ref.read(cartProvider.notifier);

    return GestureDetector(
      onTap: item.isAvailable ? () => showAddonSheet(context, ref, item) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: qty > 0
              ? Border.all(color: AppTheme.primaryCoffee, width: 2.5)
              : Border.all(color: Colors.transparent, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: qty > 0
                  ? AppTheme.primaryCoffee.withOpacity(0.12)
                  : const Color(0x0A3E2004),
              blurRadius: qty > 0 ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main card content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food icon placeholder
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryCoffee.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedRestaurant01,
                          color: AppTheme.primaryCoffee.withOpacity(0.6),
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Item name
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkEspresso,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.mutedText.withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Price + Add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CurrencyFormatter.format(item.basePrice),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryCoffee,
                        ),
                      ),
                      if (qty > 0)
                        _KioskQtyControl(
                          qty: qty,
                          onAdd: () => cartNotifier.addItem(item),
                          onRemove: () => cartNotifier.decrementItemById(item.id),
                        )
                      else
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryCoffee,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedAdd01,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Quantity badge (top-right)
            if (qty > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryCoffee,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$qty',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            if (!item.isAvailable)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'HABIS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _KioskQtyControl extends StatelessWidget {
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _KioskQtyControl({
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onRemove,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.primaryCoffee.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedRemove01,
                size: 16,
                color: AppTheme.primaryCoffee,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$qty',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: AppTheme.primaryCoffee,
            ),
          ),
        ),
        GestureDetector(
          onTap: onAdd,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.primaryCoffee,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAdd01,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Kiosk Cart Panel (right side)
// ─────────────────────────────────────────────────────────────────────────────

class _KioskCartPanel extends ConsumerStatefulWidget {
  final VoidCallback onCancel;

  const _KioskCartPanel({required this.onCancel});

  @override
  ConsumerState<_KioskCartPanel> createState() => _KioskCartPanelState();
}

class _KioskCartPanelState extends ConsumerState<_KioskCartPanel> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final subtotal = cartNotifier.subtotal;
    final tax = FeatureFlags.sstEnabled ? subtotal * FeatureFlags.sstRate : 0.0;
    final total = subtotal + tax;
    final itemCount = cartNotifier.totalItemCount;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // ── Cart Header ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFEDE3D8))),
            ),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedShoppingCart01,
                  color: AppTheme.darkEspresso,
                  size: 22,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Pesanan Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkEspresso,
                  ),
                ),
                const Spacer(),
                if (cart.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCoffee.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$itemCount item',
                      style: const TextStyle(
                        color: AppTheme.primaryCoffee,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Order Type ──
          _KioskOrderTypeSelector(),

          // ── Phone Input ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Nombor Telefon (WhatsApp)',
                hintStyle: const TextStyle(fontSize: 13, color: AppTheme.mutedText),
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSmartPhone01,
                  size: 16,
                  color: AppTheme.primaryCoffee,
                ),
                filled: true,
                fillColor: AppTheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),

          // ── Cart Items ──
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedShoppingCart01,
                          color: AppTheme.mutedText.withOpacity(0.3),
                          size: 56,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Troli kosong',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.mutedText,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Sentuh item menu untuk menambah',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.mutedText.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: cart.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    itemBuilder: (context, i) =>
                        _KioskCartItemRow(item: cart[i]),
                  ),
          ),

          // ── Totals + Checkout ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(color: Color(0xFFEDE3D8))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Subtotal
                _KioskTotalRow(
                  label: 'Subtotal',
                  amount: CurrencyFormatter.format(subtotal),
                ),
                const SizedBox(height: 6),
                // Tax
                if (FeatureFlags.sstEnabled)
                  _KioskTotalRow(
                    label: 'SST (6%)',
                    amount: CurrencyFormatter.format(tax),
                  ),
                const Divider(height: 20),
                // Grand total
                Row(
                  children: [
                    const Text(
                      'Jumlah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkEspresso,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      CurrencyFormatter.format(total),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryCoffee,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Checkout button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: cart.isEmpty
                        ? null
                        : () => _checkout(context, ref, total),
                    icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                      size: 22,
                    ),
                    label: Text(
                      cart.isEmpty
                          ? 'Pilih Item Untuk Meneruskan'
                          : 'Teruskan ke Pembayaran — ${CurrencyFormatter.format(total)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.primaryCoffee,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: AppTheme.mutedText.withOpacity(
                        0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkout(
    BuildContext context,
    WidgetRef ref,
    double totalAmount,
  ) async {
    final db = ref.read(databaseProvider);
    final cart = ref.read(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final orderType = ref.read(orderTypeProvider);

    if (cart.isEmpty) return;

    final subtotal = cartNotifier.subtotal;
    final tax = FeatureFlags.sstEnabled ? subtotal * FeatureFlags.sstRate : 0.0;
    final now = DateTime.now();
    final rnd = Random().nextInt(9000) + 1000;
    final orderNumber =
        'KSK${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}-$rnd';

    final orderId = await db.createOrder(
      OrdersCompanion.insert(
        orderNumber: orderNumber,
        orderType: Value(orderType),
        subtotal: Value(subtotal),
        taxAmount: Value(tax),
        totalAmount: Value(totalAmount),
        notes: const Value('Kiosk Order'),
        customerPhone: Value(_phoneController.text.trim().isEmpty ? null : _phoneController.text.trim()),
      ),
    );

    for (final cartItem in cart) {
      await db.addOrderItem(
        OrderItemsCompanion.insert(
          orderId: orderId,
          menuItemId: cartItem.menuItem.id,
          itemName: cartItem.menuItem.name,
          quantity: cartItem.quantity,
          unitPrice: cartItem.unitPrice,
          subtotal: cartItem.subtotal,
          modifiers: Value(CartNotifier.buildModifiersJson(cartItem)),
        ),
      );
    }

    if (context.mounted) {
      context.go('/kiosk/checkout/$orderId');
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Order Type Selector (Kiosk version)
// ─────────────────────────────────────────────────────────────────────────────

class _KioskOrderTypeSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderType = ref.watch(orderTypeProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEDE3D8))),
      ),
      child: Row(
        children: [
          Expanded(
            child: _KioskTypeButton(
              label: 'Bungkus',
              icon: HugeIcons.strokeRoundedShoppingBag01,
              selected: orderType == 'takeaway',
              onTap: () =>
                  ref.read(orderTypeProvider.notifier).state = 'takeaway',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _KioskTypeButton(
              label: 'Makan Sini',
              icon: HugeIcons.strokeRoundedRestaurant01,
              selected: orderType == 'dine_in',
              onTap: () =>
                  ref.read(orderTypeProvider.notifier).state = 'dine_in',
            ),
          ),
        ],
      ),
    );
  }
}

class _KioskTypeButton extends StatelessWidget {
  final String label;
  final dynamic icon;
  final bool selected;
  final VoidCallback onTap;

  const _KioskTypeButton({
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
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primaryCoffee.withOpacity(0.12)
              : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: selected
              ? Border.all(color: AppTheme.primaryCoffee, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: icon,
              size: 18,
              color: selected ? AppTheme.primaryCoffee : AppTheme.mutedText,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: selected ? AppTheme.primaryCoffee : AppTheme.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Kiosk Cart Item Row
// ─────────────────────────────────────────────────────────────────────────────

class _KioskCartItemRow extends ConsumerWidget {
  final CartItem item;

  const _KioskCartItemRow({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Qty controls
          Row(
            children: [
              GestureDetector(
                onTap: () => notifier.decrementItem(item.cartKey),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedRemove01,
                      size: 16,
                      color: AppTheme.primaryCoffee,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => notifier.addItem(item.menuItem),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryCoffee,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedAdd01,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Name
          Expanded(
            child: Text(
              item.menuItem.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Price
          Text(
            CurrencyFormatter.format(item.subtotal),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppTheme.darkEspresso,
            ),
          ),
        ],
      ),
    );
  }
}

class _KioskTotalRow extends StatelessWidget {
  final String label;
  final String amount;

  const _KioskTotalRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppTheme.mutedText),
        ),
        const Spacer(),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkEspresso,
          ),
        ),
      ],
    );
  }
}
