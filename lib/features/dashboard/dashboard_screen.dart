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
    final posAsync = ref.watch(allPurchaseOrdersProvider);
    final drawerBalanceAsync = ref.watch(todayCashDrawerBalanceProvider);
    final totalExpensesAsync = ref.watch(todayTotalExpensesProvider);
    final sstSettings = ref.watch(sstSettingsProvider);
    final outletsAsync = ref.watch(allOutletsProvider);
    final activeOutlet = ref.watch(activeOutletProvider);
    final deliveryOrdersAsync = ref.watch(allDeliveryOrdersProvider);
    final pnlAsync = ref.watch(pnlSummaryProvider);

    final today = DateFormat('EEEE, d MMMM y').format(DateTime.now());
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: RefreshIndicator(
        color: AppTheme.primaryCoffee,
        onRefresh: () async {
          ref.invalidate(todaySummaryProvider);
          ref.invalidate(hourlySalesProvider);
          ref.invalidate(topItemsProvider);
          ref.invalidate(todayTotalExpensesProvider);
          ref.invalidate(todayCashDrawerBalanceProvider);
          ref.invalidate(itemCogsAnalysisProvider);
          ref.invalidate(pnlSummaryProvider);
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

                  // ── Phase 3 Procurement & Finance Hub ───────────────
                  const SectionHeader(title: 'Pengurusan Inventori & Aliran Tunai (Fasa 3)'),
                  const SizedBox(height: 12),
                  _buildPhase3Hub(
                    context,
                    posAsync: posAsync,
                    drawerBalanceAsync: drawerBalanceAsync,
                    totalExpensesAsync: totalExpensesAsync,
                    sstSettings: sstSettings,
                    isTablet: isTablet,
                  ),
                  const SizedBox(height: 20),

                  // ── Phase 4 Scale & Delivery Hub ────────────────────
                  const SectionHeader(title: 'Multi-Outlet & Platform Delivery (Fasa 4)'),
                  const SizedBox(height: 12),
                  _buildPhase4Hub(
                    context,
                    outletsAsync: outletsAsync,
                    activeOutlet: activeOutlet,
                    deliveryOrdersAsync: deliveryOrdersAsync,
                    pnlAsync: pnlAsync,
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

  // ── Phase 2 Hub ─────────────────────────────────────────────────────────────

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
                      style: const TextStyle(
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

  // ── Phase 3 Hub ─────────────────────────────────────────────────────────────

  Widget _buildPhase3Hub(
    BuildContext context, {
    required AsyncValue<List<PurchaseOrder>> posAsync,
    required AsyncValue<double> drawerBalanceAsync,
    required AsyncValue<double> totalExpensesAsync,
    required SstSettings sstSettings,
    required bool isTablet,
  }) {
    final pendingPOs = posAsync.valueOrNull?.where((p) => p.status == 'ordered').length ?? 0;
    final drawerBal = drawerBalanceAsync.valueOrNull ?? 0.0;
    final expenses = totalExpensesAsync.valueOrNull ?? 0.0;

    final p3Items = [
      (
        title: 'PO Pembekal',
        value: '$pendingPOs Menunggu',
        subtitle: 'Pesanan bekalan aktif',
        icon: Icons.local_shipping_rounded,
        color: const Color(0xFF00897B),
        route: '/suppliers',
      ),
      (
        title: 'Audit Varians Stok',
        value: 'Kiraan Fizikal',
        subtitle: 'Stock Take & Pelarasan',
        icon: Icons.inventory_rounded,
        color: const Color(0xFFD84315),
        route: '/stock-take',
      ),
      (
        title: 'Baki Laci Tunai',
        value: 'RM ${drawerBal.toStringAsFixed(2)}',
        subtitle: 'Cash Drawer Float',
        icon: Icons.point_of_sale_rounded,
        color: const Color(0xFF2E7D32),
        route: '/expenses',
      ),
      (
        title: 'Belanja & Tunai Runcit',
        value: 'RM ${expenses.toStringAsFixed(2)}',
        subtitle: sstSettings.isEnabled ? 'SST 6% Aktif' : 'SST Dinyahaktif',
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFFC2185B),
        route: '/expenses',
      ),
    ];

    return GridView.count(
      crossAxisCount: isTablet ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isTablet ? 1.4 : 1.3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: p3Items.map((item) {
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
                      style: const TextStyle(
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

  // ── Phase 4 Hub ─────────────────────────────────────────────────────────────

  Widget _buildPhase4Hub(
    BuildContext context, {
    required AsyncValue<List<Outlet>> outletsAsync,
    required Outlet? activeOutlet,
    required AsyncValue<List<DeliveryOrder>> deliveryOrdersAsync,
    required AsyncValue<Map<String, dynamic>> pnlAsync,
    required bool isTablet,
  }) {
    final outletsList = outletsAsync.valueOrNull ?? [];
    final currentOutletName = activeOutlet?.name ?? (outletsList.isNotEmpty ? outletsList.first.name : 'HQ Bangsar');
    final activeDeliveries = deliveryOrdersAsync.valueOrNull?.where((d) => d.pickupStatus != 'delivered').length ?? 0;
    final netProfit = pnlAsync.valueOrNull?['netProfit'] as double? ?? 0.0;

    final p4Items = [
      (
        title: 'Cawangan Aktif',
        value: currentOutletName,
        subtitle: '${outletsList.length} Cawangan Berangkai',
        icon: Icons.storefront_rounded,
        color: const Color(0xFF6D4C41),
        route: '/outlets',
      ),
      (
        title: 'Platform Delivery',
        value: '$activeDeliveries Pesanan',
        subtitle: 'Grab, Panda & Shopee',
        icon: Icons.delivery_dining_rounded,
        color: const Color(0xFF00897B),
        route: '/delivery',
      ),
      (
        title: 'Margin COGS',
        value: 'Resipi BOM',
        subtitle: 'Analisis Kos Sebenar',
        icon: Icons.pie_chart_rounded,
        color: const Color(0xFFE65100),
        route: '/analytics',
      ),
      (
        title: 'Untung Bersih (P&L)',
        value: CurrencyFormatter.format(netProfit),
        subtitle: 'Prestasi Untung Rugi',
        icon: Icons.insights_rounded,
        color: const Color(0xFF2E7D32),
        route: '/analytics',
      ),
    ];

    return GridView.count(
      crossAxisCount: isTablet ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isTablet ? 1.4 : 1.3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: p4Items.map((item) {
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
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
          colors: [
            AppTheme.primaryCoffee,
            AppTheme.darkEspresso,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCoffee.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.trending_up, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'JUALAN HARI INI',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '${summary['completedOrders'] ?? 0} pesanan siap',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            CurrencyFormatter.format(summary['totalSales']),
            style: tt.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 36,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _paymentPill(
                'Tunai: ${CurrencyFormatter.format(summary['cashSales'])}',
                Icons.money,
              ),
              const SizedBox(width: 8),
              _paymentPill(
                'QR: ${CurrencyFormatter.format(summary['duitNowSales'])}',
                Icons.qr_code_2,
              ),
              const SizedBox(width: 8),
              _paymentPill(
                'Kad: ${CurrencyFormatter.format(summary['cardSales'])}',
                Icons.credit_card,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentPill(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white70),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _revenueCardShimmer() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppTheme.primaryCoffee.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  // ── Stat Row ───────────────────────────────────────────────────────────────

  Widget _statRow(Map<String, dynamic> summary, bool isTablet) {
    final children = [
      Expanded(
        child: StatCard(
          label: 'Jumlah Pesanan',
          value: '${summary['orderCount'] ?? 0}',
          icon: Icons.receipt_long_outlined,
          iconColor: AppTheme.primaryCoffee,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          label: 'Purata Tiket',
          value: CurrencyFormatter.format(summary['avgOrderValue'] ?? summary['avgTicket']),
          icon: Icons.analytics_outlined,
          iconColor: AppTheme.duitNowBlue,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          label: 'Siap',
          value: '${summary['completedOrders'] ?? 0}',
          icon: Icons.check_circle_outline,
          iconColor: AppTheme.successGreen,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          label: 'Batal (Void)',
          value: '${summary['voidCount'] ?? 0}',
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
      (
        icon: Icons.local_shipping_rounded,
        label: 'Pembekal & PO',
        color: const Color(0xFF00897B),
        route: '/suppliers'
      ),
      (
        icon: Icons.inventory_rounded,
        label: 'Stock Take',
        color: const Color(0xFFD84315),
        route: '/stock-take'
      ),
      (
        icon: Icons.account_balance_wallet_rounded,
        label: 'Perbelanjaan',
        color: const Color(0xFFC2185B),
        route: '/expenses'
      ),
      (
        icon: Icons.bar_chart_rounded,
        label: 'Laporan Jualan',
        color: const Color(0xFF455A64),
        route: '/reports'
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: UCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primaryCoffee.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.receipt_outlined,
                  size: 18, color: AppTheme.primaryCoffee),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        order.orderNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppTheme.darkEspresso,
                        ),
                      ),
                      const SizedBox(width: 8),
                      OrderTypeBadge(orderType: order.orderType),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('hh:mm a').format(order.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.mutedText,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencyFormatter.format(order.totalAmount),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: AppTheme.darkEspresso,
                  ),
                ),
                const SizedBox(height: 2),
                StatusBadge(status: order.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
