import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';
import '../../shared/widgets/common_widgets.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(todayOrdersProvider);
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Orders'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ordersAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (orders) {
                final completed =
                    orders.where((o) => o.status == 'completed');
                final total = completed.fold(
                    0.0, (s, o) => s + o.totalAmount);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(CurrencyFormatter.format(total),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primaryCoffee)),
                    Text('${completed.length} orders',
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.mutedText)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 52,
            color: AppTheme.cardBg,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              children: [
                _filterChip('all', 'All'),
                _filterChip('pending', 'Pending'),
                _filterChip('completed', 'Completed'),
                _filterChip('voided', 'Voided'),
              ],
            ),
          ),
          // Orders list
          Expanded(
            child: ordersAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, __) =>
                  Center(child: Text('Error: $err')),
              data: (orders) {
                final filtered = _filter == 'all'
                    ? orders
                    : orders
                        .where((o) => o.status == _filter)
                        .toList();

                if (filtered.isEmpty) {
                  return const EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: 'No orders',
                    subtitle: 'No orders match the selected filter',
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(isTablet ? 24 : 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 10),
                  itemBuilder: (ctx, i) =>
                      _OrderCard(order: filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String value, String label) {
    final selected = _filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => _filter = value),
        selectedColor: AppTheme.primaryCoffee.withOpacity(0.15),
        checkmarkColor: AppTheme.primaryCoffee,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: selected ? AppTheme.primaryCoffee : AppTheme.mutedText,
        ),
      ),
    );
  }
}

class _OrderCard extends ConsumerWidget {
  final Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = Theme.of(context).textTheme;
    final timeStr = DateFormat('HH:mm').format(order.createdAt);
    final payLabel = switch (order.paymentMethod) {
      'cash' => '💵 Cash',
      'duitnow_qr' => '📱 DuitNow QR',
      'card' => '💳 Card',
      _ => '—',
    };

    return UCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(order.orderNumber,
                        style: tt.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(width: 10),
                    OrderTypeBadge(orderType: order.orderType),
                  ],
                ),
              ),
              StatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: 8),
          // Meta row
          Row(
            children: [
              const Icon(Icons.schedule_outlined,
                  size: 14, color: AppTheme.mutedText),
              const SizedBox(width: 4),
              Text(timeStr,
                  style: tt.bodySmall
                      ?.copyWith(color: AppTheme.mutedText)),
              if (order.status == 'completed') ...[
                const SizedBox(width: 16),
                const Icon(Icons.payments_outlined,
                    size: 14, color: AppTheme.mutedText),
                const SizedBox(width: 4),
                Text(payLabel,
                    style: tt.bodySmall
                        ?.copyWith(color: AppTheme.mutedText)),
              ],
              const Spacer(),
              Text(
                CurrencyFormatter.format(order.totalAmount),
                style: tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: order.status == 'voided'
                        ? AppTheme.mutedText
                        : AppTheme.primaryCoffee),
              ),
            ],
          ),
          if (order.status == 'completed' &&
              order.paymentMethod == 'cash' &&
              (order.tenderedAmount ?? 0) > 0) ...[
            const SizedBox(height: 6),
            Text(
              'Tendered: ${CurrencyFormatter.format(order.tenderedAmount ?? 0)} · '
              'Change: ${CurrencyFormatter.format((order.tenderedAmount ?? 0) - order.totalAmount)}',
              style: tt.bodySmall
                  ?.copyWith(color: AppTheme.mutedText),
            ),
          ],
          // Void action for pending orders
          if (order.status == 'pending') ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () async {
                  final db = ref.read(databaseProvider);
                  await db.voidOrder(order.id);
                },
                icon: const Icon(Icons.remove_circle_outline,
                    size: 16, color: AppTheme.dangerRed),
                label: const Text('Void Order',
                    style: TextStyle(
                        color: AppTheme.dangerRed,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
