import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';
import '../../shared/widgets/common_widgets.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Selamat pagi ☕';
    if (h < 17) return 'Selamat tengah hari ☀️';
    return 'Selamat petang & malam 🌙';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(todaySummaryProvider);
    final ordersAsync = ref.watch(todayOrdersProvider);
    final ingredientsAsync = ref.watch(ingredientsProvider);
    final kdsAsync = ref.watch(activeKdsOrdersProvider);
    final tasksAsync = ref.watch(allTasksProvider);
    final staffAttAsync = ref.watch(todayAttendanceProvider);
    final customersAsync = ref.watch(allCustomersProvider);

    final today = DateFormat('EEEE, d MMMM y').format(DateTime.now());
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: RefreshIndicator(
        color: AppTheme.primaryCoffee,
        onRefresh: () async {
          ref.invalidate(todaySummaryProvider);
          ref.invalidate(hourlySalesProvider);
          ref.invalidate(topItemsProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ── App Bar ──────────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              backgroundColor: AppTheme.warmCream,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkEspresso,
                      ),
                    ),
                    Text(
                      today,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    color: AppTheme.darkEspresso,
                    onPressed: () => context.go('/settings'),
                    tooltip: 'Tetapan',
                  ),
                ),
              ],
            ),

            SliverPadding(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ── Revenue Hero Card ───────────────────────────────
                  summaryAsync.when(
                    loading: () => _revenueCardShimmer(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (summary) => _revenueCard(context, summary),
                  ),
                  const SizedBox(height: 16),

                  // ── Stat Row ────────────────────────────────────────
                  summaryAsync.when(
                    loading: () => const SizedBox(height: 80),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (summary) => _statRow(summary, isTablet),
                  ),
                  const SizedBox(height: 20),

                  // ── Phase 2 Operations Snapshot Row ─────────────────
                  const SectionHeader(title: 'Status Operasi Semasa (Live Hub)'),
                  const SizedBox(height: 12),
                  _buildPhase2Hub(
                    context,
                    kdsAsync: kdsAsync,
                    tasksAsync: tasksAsync,
                    staffAttAsync: staffAttAsync,
                    customersAsync: customersAsync,
                    isTablet: isTablet,
                  ),
                  const SizedBox(height: 20),

                  // ── Low Stock Alert ─────────────────────────────────
                  ingredientsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (ingredients) {
                      final low = ingredients
                          .where((i) => i.currentStock <= i.reorderPoint)
                          .toList();
                      if (low.isEmpty) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _lowStockBanner(context, low),
                      );
                    },
                  ),

                  // ── Quick Actions ───────────────────────────────────
                  const SectionHeader(title: 'Tindakan Pantas'),
                  const SizedBox(height: 12),
                  _quickActions(context, isTablet),
                  const SizedBox(height: 24),

                  // ── Recent Orders ───────────────────────────────────
                  SectionHeader(
                    title: 'Pesanan Terkini',
                    action: TextButton(
                      onPressed: () => context.go('/orders'),
                      child: const Text('Lihat semua'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ordersAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (orders) {
                      if (orders.isEmpty) {
                        return const EmptyState(
                          icon: Icons.receipt_long_outlined,
                          title: 'Belum ada pesanan hari ini',
                          subtitle: 'Buka skrin POS untuk mula terima pesanan',
                        );
                      }
                      return Column(
                        children: orders
                            .take(5)
                            .map((o) => _recentOrderTile(context, o))
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhase2Hub(
    BuildContext context, {
    required AsyncValue<List<Order>> kdsAsync,
    required AsyncValue<List<Task>> tasksAsync,
    required AsyncValue<List<StaffAttendance>> staffAttAsync,
    required AsyncValue<List<Customer>> customersAsync,
    required bool isTablet,
  }) {
    final kdsCount = kdsAsync.valueOrNull?.length ?? 0;
    final pendingTasks = tasksAsync.valueOrNull?.where((t) => t.status != 'completed').length ?? 0;
    final onDutyStaff = staffAttAsync.valueOrNull?.where((a) => a.clockOutTime == null).length ?? 0;
    final totalMembers = customersAsync.valueOrNull?.length ?? 0;

    final hubItems = [
      (
        title: 'Dapur KDS',
        value: '$kdsCount Pesanan',
        subtitle: kdsCount > 0 ? 'Sedang diproses' : 'Semua siap',
        icon: Icons.soup_kitchen_rounded,
        color: const Color(0xFF1565C0),
        route: '/kds',
      ),
      (
        title: 'Tugasan Syif',
        value: '$pendingTasks Belum Siap',
        subtitle: 'Checklist buka/tutup',
        icon: Icons.assignment_turned_in_rounded,
        color: const Color(0xFFE65100),
        route: '/tasks',
      ),
      (
        title: 'Staf Bertugas',
        value: '$onDutyStaff Aktif',
        subtitle: 'Clock-in hari ini',
        icon: Icons.badge_rounded,
        color: AppTheme.successGreen,
        route: '/staff',
      ),
      (
        title: 'Ahli Kesetiaan',
        value: '$totalMembers Ahli',
        subtitle: 'Program CRM & Cop',
        icon: Icons.card_membership_rounded,
        color: const Color(0xFF6A1B9A),
        route: '/loyalty',
      ),
    ];

    return GridView.count(
      crossAxisCount: isTablet ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isTablet ? 1.4 : 1.3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: hubItems.map((item) {
        return InkWell(
          onTap: () => context.go(item.route),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEDE3D8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.icon, size: 18, color: item.color),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.mutedText),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkEspresso,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.title,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.mutedText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Revenue Hero Card ──────────────────────────────────────────────────────

  Widget _revenueCard(
      BuildContext context, Map<String, dynamic> summary) {
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC17F3A), Color(0xFF8D4E1C)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCoffee.withOpacity(0.30),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.attach_money_rounded,
                  color: Colors.white70, size: 18),
              SizedBox(width: 6),
              Text("Jumlah Jualan Hari Ini",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            CurrencyFormatter.format(
                summary['totalSales'] as double),
            style: tt.displayLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 40),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _revenueStat(
                  '${summary['orderCount']} pesanan',
                  Icons.receipt_long_outlined),
              const SizedBox(width: 24),
              _revenueStat(
                  '${summary['voidCount']} batal (void)',
                  Icons.remove_circle_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _revenueStat(String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white60, size: 14),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _revenueCardShimmer() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  // ── Stat Row ───────────────────────────────────────────────────────────────

  Widget _statRow(Map<String, dynamic> summary, bool isTablet) {
    final children = [
      Expanded(
        child: StatCard(
          label: 'Pesanan',
          value: '${summary['orderCount']}',
          icon: Icons.shopping_bag_outlined,
          iconColor: AppTheme.primaryCoffee,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          label: 'Purata Resit',
          value: CurrencyFormatter.format(
              summary['avgTicket'] as double),
          icon: Icons.bar_chart_rounded,
          iconColor: AppTheme.successGreen,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          label: 'Batal (Void)',
          value: '${summary['voidCount']}',
          icon: Icons.remove_circle_outline,
          iconColor: AppTheme.dangerRed,
        ),
      ),
    ];

    return Row(children: children);
  }

  // ── Low Stock Banner ───────────────────────────────────────────────────────

  Widget _lowStockBanner(BuildContext context, List<Ingredient> low) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.warningAmber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppTheme.warningAmber.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppTheme.warningAmber, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${low.length} ramuan stok rendah',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.warningAmber,
                        fontSize: 14)),
                Text(
                  low.take(3).map((i) => i.name).join(', '),
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.mutedText),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.go('/inventory'),
            child: const Text('Semak',
                style: TextStyle(
                    color: AppTheme.warningAmber,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Quick Actions ──────────────────────────────────────────────────────────

  Widget _quickActions(BuildContext context, bool isTablet) {
    final actions = [
      (
        icon: Icons.point_of_sale_rounded,
        label: 'Pesanan POS',
        color: AppTheme.primaryCoffee,
        route: '/pos'
      ),
      (
        icon: Icons.soup_kitchen_rounded,
        label: 'Dapur KDS',
        color: const Color(0xFF1565C0),
        route: '/kds'
      ),
      (
        icon: Icons.assignment_turned_in_rounded,
        label: 'Tugasan & Syif',
        color: const Color(0xFFE65100),
        route: '/tasks'
      ),
      (
        icon: Icons.card_membership_rounded,
        label: 'CRM & Loyalty',
        color: const Color(0xFF6A1B9A),
        route: '/loyalty'
      ),
    ];

    return GridView.count(
      crossAxisCount: isTablet ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isTablet ? 1.4 : 1.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: actions
          .map((a) => UCard(
                padding: const EdgeInsets.all(16),
                onTap: () => context.go(a.route),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: a.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(a.icon, color: a.color, size: 20),
                    ),
                    Text(a.label,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppTheme.darkEspresso)),
                  ],
                ),
              ))
          .toList(),
    );
  }

  // ── Recent Order Tile ──────────────────────────────────────────────────────

  Widget _recentOrderTile(BuildContext context, Order order) {
    final timeStr = DateFormat('HH:mm').format(order.createdAt);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: UCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        onTap: () => context.go('/orders'),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.receipt_outlined,
                  color: AppTheme.primaryCoffee, size: 18),
            ),
            const SizedBox(width: 12),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.orderNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppTheme.darkEspresso)),
                  Row(
                    children: [
                      OrderTypeBadge(orderType: order.orderType),
                      const SizedBox(width: 8),
                      Text(timeStr,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.mutedText)),
                    ],
                  ),
                ],
              ),
            ),
            // Status + Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencyFormatter.format(order.totalAmount),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppTheme.darkEspresso),
                ),
                const SizedBox(height: 4),
                StatusBadge(status: order.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
