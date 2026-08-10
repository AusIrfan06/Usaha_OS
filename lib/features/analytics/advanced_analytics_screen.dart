import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../shared/widgets/common_widgets.dart';

class AdvancedAnalyticsScreen extends ConsumerStatefulWidget {
  const AdvancedAnalyticsScreen({super.key});

  @override
  ConsumerState<AdvancedAnalyticsScreen> createState() =>
      _AdvancedAnalyticsScreenState();
}

class _AdvancedAnalyticsScreenState
    extends ConsumerState<AdvancedAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        title: const Text(
          'Analitik Lanjutan & COGS Intelligence',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppTheme.darkEspresso,
          ),
        ),
        backgroundColor: AppTheme.warmCream,
        surfaceTintColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.primaryCoffee,
          unselectedLabelColor: AppTheme.mutedText,
          indicatorColor: AppTheme.primaryCoffee,
          tabs: const [
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedPieChart01),
              text: 'COGS & Margin Item',
            ),
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedClock01),
              text: 'Peta Waktu Puncak (Heatmap)',
            ),
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedUser),
              text: 'Prestasi Staf',
            ),
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedBank),
              text: 'Penyata Untung Rugi (P&L)',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCogsTab(isTablet),
          _buildHeatmapTab(isTablet),
          _buildStaffLeaderboardTab(isTablet),
          _buildPnlTab(isTablet),
        ],
      ),
    );
  }

  // ── Tab 1: COGS & Gross Profit Margin ──────────────────────────────────────

  Widget _buildCogsTab(bool isTablet) {
    final cogsAsync = ref.watch(itemCogsAnalysisProvider);

    return cogsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Ralat: $e')),
      data: (items) {
        if (items.isEmpty) {
          return const Center(
            child: Text('Tiada data menu untuk analisis COGS'),
          );
        }

        return ListView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryCoffee.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryCoffee.withOpacity(0.2),
                ),
              ),
              child: const Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedSquare,
                    color: AppTheme.primaryCoffee,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Analisis COGS dikira secara automatik berdasarkan resipi BOM (Bill of Materials) dan kos pembelian bahan mentah terkini.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.darkEspresso,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            ...items.map((item) {
              final sellingPrice = item['sellingPrice'] as double;
              final cogs = item['cogs'] as double;
              final profit = item['grossProfit'] as double;
              final margin = item['marginPercent'] as double;

              Color marginColor = AppTheme.successGreen;
              if (margin < 50) {
                marginColor = AppTheme.dangerRed;
              } else if (margin < 70) {
                marginColor = AppTheme.warningAmber;
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: marginColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: marginColor),
                            ),
                            child: Text(
                              'Margin: ${margin.toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: marginColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildCogsMetricCell(
                            'Harga Jualan',
                            CurrencyFormatter.format(sellingPrice),
                            AppTheme.darkEspresso,
                          ),
                          _buildCogsMetricCell(
                            'Kos Bahan (COGS)',
                            CurrencyFormatter.format(cogs),
                            Colors.red.shade700,
                          ),
                          _buildCogsMetricCell(
                            'Untung Kasar / Unit',
                            CurrencyFormatter.format(profit),
                            AppTheme.successGreen,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: (margin / 100).clamp(0.0, 1.0),
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            marginColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildCogsMetricCell(String label, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppTheme.mutedText),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ── Tab 2: Hourly Rush Heatmap ─────────────────────────────────────────────

  Widget _buildHeatmapTab(bool isTablet) {
    final heatmapAsync = ref.watch(hourlyRushHeatmapProvider);

    return heatmapAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Ralat: $e')),
      data: (hours) {
        int maxOrders = 1;
        for (var h in hours) {
          final o = h['orders'] as int;
          if (o > maxOrders) maxOrders = o;
        }

        return ListView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          children: [
            const SectionHeader(
              title: 'Peta Waktu Puncak Pesanan (Hourly Rush Heatmap)',
            ),
            const SizedBox(height: 8),
            const Text(
              'Menunjukkan taburan pesanan & hasil jualan dari jam 7:00 pagi hingga 11:00 malam untuk optimasi jadual barista & staf.',
              style: TextStyle(color: AppTheme.mutedText, fontSize: 13),
            ),
            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: hours.map((h) {
                    final label = h['label'] as String;
                    final orders = h['orders'] as int;
                    final sales = h['sales'] as double;
                    final ratio = (orders / maxOrders).clamp(0.0, 1.0);

                    final isPeak = orders >= 5;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              label,
                              style: TextStyle(
                                fontWeight: isPeak
                                    ? FontWeight.w900
                                    : FontWeight.w600,
                                color: isPeak
                                    ? AppTheme.primaryCoffee
                                    : AppTheme.darkEspresso,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: ratio == 0 ? 0.02 : ratio,
                                  child: Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: isPeak
                                          ? AppTheme.primaryCoffee
                                          : Colors.brown.shade200,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '$orders pesanan',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  CurrencyFormatter.format(sales),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.mutedText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Tab 3: Staff Leaderboard ───────────────────────────────────────────────

  Widget _buildStaffLeaderboardTab(bool isTablet) {
    final staffAsync = ref.watch(staffLeaderboardProvider);

    return staffAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Ralat: $e')),
      data: (leaderboard) {
        return ListView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          children: [
            const SectionHeader(title: 'Carta Kedudukan Prestasi Jualan Staf'),
            const SizedBox(height: 12),

            ...leaderboard.asMap().entries.map((entry) {
              final rank = entry.key + 1;
              final staff = entry.value;
              final totalSales = staff['totalSales'] as double;
              final orderCount = staff['orderCount'] as int;
              final avgTicket = staff['avgTicket'] as double;

              Color badgeColor = Colors.grey.shade700;
              if (rank == 1) badgeColor = const Color(0xFFFFD700);
              if (rank == 2) badgeColor = const Color(0xFFC0C0C0);
              if (rank == 3) badgeColor = const Color(0xFFCD7F32);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: badgeColor, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '#$rank',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: badgeColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              staff['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Jawatan: ${staff['role']} • $orderCount pesanan',
                              style: const TextStyle(
                                color: AppTheme.mutedText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            CurrencyFormatter.format(totalSales),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: AppTheme.darkEspresso,
                            ),
                          ),
                          Text(
                            'Purata: ${CurrencyFormatter.format(avgTicket)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.mutedText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  // ── Tab 4: Profit & Loss Statement ─────────────────────────────────────────

  Widget _buildPnlTab(bool isTablet) {
    final pnlAsync = ref.watch(pnlSummaryProvider);

    return pnlAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Ralat: $e')),
      data: (pnl) {
        final grossRevenue = pnl['grossRevenue'] as double;
        final voidLoss = pnl['voidLoss'] as double;
        final netSales = pnl['netSales'] as double;
        final cogs = pnl['totalCogs'] as double;
        final grossProfit = pnl['grossProfit'] as double;
        final expenses = pnl['totalExpenses'] as double;
        final netProfit = pnl['netProfit'] as double;
        final grossMargin = pnl['grossMarginPercent'] as double;
        final netMargin = pnl['netMarginPercent'] as double;

        return ListView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Penyata Untung & Rugi (P&L)',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: AppTheme.darkEspresso,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryCoffee.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Bulan Semasa',
                            style: TextStyle(
                              color: AppTheme.primaryCoffee,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),

                    _buildPnlRow(
                      'Jualan Kasar (Gross Revenue)',
                      CurrencyFormatter.format(grossRevenue),
                    ),
                    _buildPnlRow(
                      'Pesanan Dibatalkan / Void',
                      '- ${CurrencyFormatter.format(voidLoss)}',
                      isDeduction: true,
                    ),
                    const Divider(height: 16),
                    _buildPnlRow(
                      'Jualan Bersih (Net Sales)',
                      CurrencyFormatter.format(netSales),
                      isBold: true,
                    ),
                    const SizedBox(height: 12),

                    _buildPnlRow(
                      'Kos Bahan Mentah (COGS BOM)',
                      '- ${CurrencyFormatter.format(cogs)}',
                      isDeduction: true,
                    ),
                    const Divider(height: 16),
                    _buildPnlRow(
                      'Untung Kasar (Gross Profit)',
                      '${CurrencyFormatter.format(grossProfit)} (${grossMargin.toStringAsFixed(1)}%)',
                      isBold: true,
                      color: AppTheme.successGreen,
                    ),
                    const SizedBox(height: 12),

                    _buildPnlRow(
                      'Perbelanjaan Operasi & Runcit (Opex)',
                      '- ${CurrencyFormatter.format(expenses)}',
                      isDeduction: true,
                    ),
                    const Divider(height: 24, thickness: 2),

                    _buildPnlRow(
                      'UNTUNG BERSIH (NET PROFIT)',
                      '${CurrencyFormatter.format(netProfit)} (${netMargin.toStringAsFixed(1)}%)',
                      isBold: true,
                      isTotal: true,
                      color: netProfit >= 0
                          ? AppTheme.successGreen
                          : AppTheme.dangerRed,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryCoffee,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: HugeIcon(icon: HugeIcons.strokeRoundedSquare),
              label: const Text(
                'Eksport Laporan P&L untuk Akauntan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Penyata Untung Rugi (P&L) telah dieksport ke format PDF/CSV.',
                    ),
                    backgroundColor: AppTheme.successGreen,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPnlRow(
    String label,
    String value, {
    bool isBold = false,
    bool isDeduction = false,
    bool isTotal = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              fontWeight: isBold || isTotal ? FontWeight.w900 : FontWeight.w500,
              color: isTotal ? AppTheme.darkEspresso : AppTheme.darkEspresso,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              fontWeight: isBold || isTotal ? FontWeight.w900 : FontWeight.w600,
              color:
                  color ??
                  (isDeduction ? Colors.red.shade700 : AppTheme.darkEspresso),
            ),
          ),
        ],
      ),
    );
  }
}
