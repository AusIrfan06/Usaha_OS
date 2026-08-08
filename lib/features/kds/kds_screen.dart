import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class KdsScreen extends ConsumerStatefulWidget {
  const KdsScreen({super.key});

  @override
  ConsumerState<KdsScreen> createState() => _KdsScreenState();
}

class _KdsScreenState extends ConsumerState<KdsScreen> {
  String _selectedStation = 'all'; // all | kitchen | bar | pastry
  Timer? _tickerTimer;

  @override
  void initState() {
    super.initState();
    // Update aging timers every 5 seconds
    _tickerTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF140E07) : const Color(0xFFF7F2EB),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryCoffee.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.soup_kitchen_rounded,
                  color: AppTheme.primaryCoffee, size: 22),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kitchen Display System (KDS)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Paparan Dapur & Stesen Pesanan Masa Nyata',
                  style: TextStyle(fontSize: 11, color: AppTheme.mutedText),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Station Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStationFilter('all', 'Semua (All)', Icons.dashboard_customize_outlined),
                const SizedBox(width: 6),
                _buildStationFilter('bar', 'Barista / Minuman', Icons.local_cafe_outlined),
                const SizedBox(width: 6),
                _buildStationFilter('kitchen', 'Dapur / Makanan', Icons.restaurant_outlined),
                const SizedBox(width: 6),
                _buildStationFilter('pastry', 'Pastri', Icons.bakery_dining_outlined),
                const SizedBox(width: 12),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Pesanan Selesai (Recall)',
            onPressed: () => _showRecallModal(context, db),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<List<Order>>(
        stream: db.watchActiveKdsOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ralat memuat pesanan: ${snapshot.error}'));
          }
          final allOrders = snapshot.data ?? [];

          if (allOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCoffee.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_outline_rounded,
                        size: 64, color: AppTheme.primaryCoffee),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tiada Pesanan Aktif di Dapur',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Semua pesanan telah siap atau tiada pesanan baharu.',
                    style: TextStyle(color: AppTheme.mutedText),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Header Summary Metrics
              _buildMetricsHeader(allOrders),
              // Orders Grid
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final crossAxisCount = width > 1300
                        ? 4
                        : width > 900
                            ? 3
                            : width > 600
                                ? 2
                                : 1;

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: width > 600 ? 0.82 : 1.1,
                      ),
                      itemCount: allOrders.length,
                      itemBuilder: (context, index) {
                        final order = allOrders[index];
                        return _KdsTicketCard(
                          order: order,
                          stationFilter: _selectedStation,
                          db: db,
                          onStatusChanged: () {
                            setState(() {});
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStationFilter(String key, String label, IconData icon) {
    final isSelected = _selectedStation == key;
    return ChoiceChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : AppTheme.darkEspresso),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selectedColor: AppTheme.primaryCoffee,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.darkEspresso,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        fontSize: 12,
      ),
      onSelected: (_) {
        setState(() => _selectedStation = key);
      },
    );
  }

  Widget _buildMetricsHeader(List<Order> orders) {
    final pendingCount = orders.where((o) => o.status == 'pending').length;
    final inProgCount = orders.where((o) => o.status == 'in_progress').length;
    final readyCount = orders.where((o) => o.status == 'ready').length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFEDE3D8)),
        ),
      ),
      child: Row(
        children: [
          _buildMetricPill(
            label: 'Menunggu (Pending)',
            count: pendingCount,
            color: const Color(0xFFE65100),
            icon: Icons.hourglass_top_rounded,
          ),
          const SizedBox(width: 12),
          _buildMetricPill(
            label: 'Sedang Disediakan',
            count: inProgCount,
            color: const Color(0xFF1565C0),
            icon: Icons.soup_kitchen_rounded,
          ),
          const SizedBox(width: 12),
          _buildMetricPill(
            label: 'Sedia Dihidang',
            count: readyCount,
            color: AppTheme.successGreen,
            icon: Icons.room_service_rounded,
          ),
          const Spacer(),
          Text(
            'Jumlah Aktif: ${orders.length}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricPill({
    required String label,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showRecallModal(BuildContext context, AppDatabase db) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.4,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.history_rounded, color: AppTheme.primaryCoffee),
                        SizedBox(width: 8),
                        Text(
                          'Pesanan Selesai / Dihidang (Recall)',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: FutureBuilder<List<Order>>(
                    future: (db.select(db.orders)
                          ..where((o) => o.status.equals('completed'))
                          ..orderBy([(o) => drift.OrderingTerm.desc(o.createdAt)])
                          ..limit(15))
                        .get(),
                    builder: (context, snap) {
                      final doneOrders = snap.data ?? [];
                      if (doneOrders.isEmpty) {
                        return const Center(child: Text('Tiada pesanan selesai hari ini.'));
                      }
                      return ListView.separated(
                        controller: scrollController,
                        itemCount: doneOrders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, i) {
                          final o = doneOrders[i];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.check_circle, color: AppTheme.successGreen),
                              title: Text(
                                '${o.orderNumber} • ${o.orderType.toUpperCase()}',
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                'Masa: ${DateFormat('hh:mm a').format(o.createdAt)} • Jumlah: RM ${o.totalAmount.toStringAsFixed(2)}',
                              ),
                              trailing: OutlinedButton.icon(
                                icon: const Icon(Icons.undo_rounded, size: 16),
                                label: const Text('Recall ke KDS'),
                                onPressed: () async {
                                  await db.updateOrderStatus(o.id, 'in_progress');
                                  if (ctx.mounted) Navigator.pop(ctx);
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KDS Ticket Card
// ─────────────────────────────────────────────────────────────────────────────

class _KdsTicketCard extends StatelessWidget {
  final Order order;
  final String stationFilter;
  final AppDatabase db;
  final VoidCallback onStatusChanged;

  const _KdsTicketCard({
    required this.order,
    required this.stationFilter,
    required this.db,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final elapsedMinutes = now.difference(order.createdAt).inMinutes;
    final elapsedSeconds = now.difference(order.createdAt).inSeconds % 60;
    final timerString =
        '${elapsedMinutes.toString().padLeft(2, '0')}:${elapsedSeconds.toString().padLeft(2, '0')}';

    // Color code aging: <5 min (Green), 5-15 min (Amber), >15 min (Red)
    Color timerColor;
    Color timerBg;
    if (elapsedMinutes < 5) {
      timerColor = AppTheme.successGreen;
      timerBg = const Color(0xFFE8F5E9);
    } else if (elapsedMinutes < 15) {
      timerColor = AppTheme.warningAmber;
      timerBg = const Color(0xFFFFF8E1);
    } else {
      timerColor = AppTheme.dangerRed;
      timerBg = const Color(0xFFFFEBEE);
    }

    final isReady = order.status == 'ready';
    final isInProgress = order.status == 'in_progress';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isReady
              ? AppTheme.successGreen
              : isInProgress
                  ? const Color(0xFF1976D2)
                  : const Color(0xFFE0D5C7),
          width: isReady || isInProgress ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isReady
                  ? AppTheme.successGreen.withOpacity(0.12)
                  : isInProgress
                      ? const Color(0xFF1976D2).withOpacity(0.1)
                      : const Color(0xFFF5EDE3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkEspresso,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          order.orderType == 'dine_in'
                              ? Icons.table_restaurant_outlined
                              : Icons.takeout_dining_outlined,
                          size: 14,
                          color: AppTheme.primaryCoffee,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order.orderType == 'dine_in'
                              ? 'Meja ${order.tableNumber ?? '-'}'
                              : 'Bungkus / Takeaway',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkEspresso,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Aging Timer Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: timerBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: timerColor.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer_outlined, size: 14, color: timerColor),
                      const SizedBox(width: 4),
                      Text(
                        timerString,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: timerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Items List
          Expanded(
            child: FutureBuilder<List<OrderItem>>(
              future: (db.select(db.orderItems)..where((i) => i.orderId.equals(order.id))).get(),
              builder: (context, snapshot) {
                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 12),
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quantity Badge
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryCoffee.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${item.quantity}x',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: AppTheme.primaryCoffee,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Item Name & Modifiers
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (item.modifiers.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3E0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item.modifiers,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFE65100),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          // Order Notes
          if (order.notes.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDE7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFF59D)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.note_alt_outlined, size: 14, color: Color(0xFFF57F17)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Nota: ${order.notes}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(10),
            child: _buildActionButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (order.status == 'pending') {
      return FilledButton.icon(
        icon: const Icon(Icons.play_arrow_rounded, size: 18),
        label: const Text('MULA SEDIAKAN (START)'),
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () async {
          await db.updateOrderStatus(order.id, 'in_progress');
          onStatusChanged();
        },
      );
    } else if (order.status == 'in_progress') {
      return FilledButton.icon(
        icon: const Icon(Icons.done_all_rounded, size: 18),
        label: const Text('TANDAKAN SIAP (READY)'),
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.successGreen,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () async {
          await db.updateOrderStatus(order.id, 'ready');
          onStatusChanged();
        },
      );
    } else {
      // ready
      return FilledButton.icon(
        icon: const Icon(Icons.check_circle_rounded, size: 18),
        label: const Text('SELESAI / HIDANG (BUMP)'),
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.darkEspresso,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () async {
          await db.updateOrderStatus(order.id, 'completed');
          onStatusChanged();
        },
      );
    }
  }
}
