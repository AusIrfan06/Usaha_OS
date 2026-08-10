import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../shared/widgets/common_widgets.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(todaySummaryProvider);
    final hourlyAsync = ref.watch(hourlySalesProvider);
    final topItemsAsync = ref.watch(topItemsProvider);
    final isTablet = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              label: const Text(
                'Today',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              backgroundColor: AppTheme.primaryCoffee.withOpacity(0.12),
              side: BorderSide.none,
              avatar: HugeIcon(
                icon: HugeIcons.strokeRoundedDashboardSquare01,
                size: 14,
                color: AppTheme.primaryCoffee,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppTheme.primaryCoffee,
        onRefresh: () async {
          ref.invalidate(todaySummaryProvider);
          ref.invalidate(hourlySalesProvider);
          ref.invalidate(topItemsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Summary Cards ───────────────────────────────────
              summaryAsync.when(
                loading: () => const SizedBox(height: 120),
                error: (_, __) => const SizedBox.shrink(),
                data: (s) => isTablet ? _tabletSummary(s) : _phoneSummary(s),
              ),
              const SizedBox(height: 24),

              // ── Hourly Sales Chart ──────────────────────────────
              const SectionHeader(title: 'Hourly Sales'),
              const SizedBox(height: 12),
              UCard(
                padding: const EdgeInsets.all(20),
                child: hourlyAsync.when(
                  loading: () => const SizedBox(
                    height: 180,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, __) => const SizedBox(height: 180),
                  data: (hourly) => hourly.isEmpty
                      ? const SizedBox(
                          height: 180,
                          child: EmptyState(
                            icon: HugeIcons.strokeRoundedFile02,
                            title: 'No sales yet',
                            subtitle:
                                'Hourly chart will appear as orders come in',
                          ),
                        )
                      : _hourlyChart(hourly),
                ),
              ),
              const SizedBox(height: 24),

              // ── Top Items ───────────────────────────────────────
              const SectionHeader(title: 'Top Items Today'),
              const SizedBox(height: 12),
              topItemsAsync.when(
                loading: () => const SizedBox(height: 100),
                error: (_, __) => const SizedBox.shrink(),
                data: (items) => items.isEmpty
                    ? const UCard(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: EmptyState(
                            icon: HugeIcons.strokeRoundedStar,
                            title: 'No data yet',
                            subtitle: 'Complete some orders to see top items',
                          ),
                        ),
                      )
                    : Column(
                        children: items
                            .asMap()
                            .entries
                            .map(
                              (e) =>
                                  _TopItemRow(rank: e.key + 1, data: e.value),
                            )
                            .toList(),
                      ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneSummary(Map<String, dynamic> s) {
    return Column(
      children: [
        // Revenue hero
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFC17F3A), Color(0xFF8D4E1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Revenue",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                CurrencyFormatter.format(s['totalSales'] as double),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'Orders',
                value: '${s['orderCount']}',
                icon: HugeIcons.strokeRoundedInvoice01,
                iconColor: AppTheme.primaryCoffee,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                label: 'Avg Ticket',
                value: CurrencyFormatter.format(s['avgTicket'] as double),
                icon: HugeIcons.strokeRoundedBarChart,
                iconColor: AppTheme.successGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabletSummary(Map<String, dynamic> s) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFC17F3A), Color(0xFF8D4E1C)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Revenue",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  CurrencyFormatter.format(s['totalSales'] as double),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatCard(
            label: 'Orders',
            value: '${s['orderCount']}',
            icon: HugeIcons.strokeRoundedInvoice01,
            iconColor: AppTheme.primaryCoffee,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            label: 'Avg Ticket',
            value: CurrencyFormatter.format(s['avgTicket'] as double),
            icon: HugeIcons.strokeRoundedBarChart,
            iconColor: AppTheme.successGreen,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            label: 'Voids',
            value: '${s['voidCount']}',
            icon: HugeIcons.strokeRoundedRemove01,
            iconColor: AppTheme.dangerRed,
          ),
        ),
      ],
    );
  }

  Widget _hourlyChart(Map<int, double> hourly) {
    final maxY = hourly.values.fold(0.0, (m, v) => v > m ? v : m);
    final effectiveMax = maxY < 1 ? 100.0 : maxY * 1.2;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: effectiveMax,
          barGroups: hourly.entries.map((e) {
            final isCurrent = e.key == DateTime.now().hour;
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value,
                  color: isCurrent
                      ? AppTheme.primaryCoffee
                      : AppTheme.primaryCoffee.withOpacity(0.45),
                  width: 14,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (val, _) => Text(
                  '${val.toInt()}h',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.mutedText,
                  ),
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                getTitlesWidget: (val, _) => Text(
                  val == 0 ? '' : CurrencyFormatter.formatCompact(val),
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppTheme.mutedText,
                  ),
                ),
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: const Color(0xFFEDE3D8), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                CurrencyFormatter.format(rod.toY),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopItemRow extends StatelessWidget {
  final int rank;
  final Map<String, dynamic> data;

  const _TopItemRow({required this.rank, required this.data});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = [
      AppTheme.primaryCoffee,
      const Color(0xFF8D4E1C),
      const Color(0xFFC17F3A),
      AppTheme.mutedText,
      AppTheme.mutedText,
    ];
    final color = colors[(rank - 1).clamp(0, colors.length - 1)];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: UCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                data['name'] as String,
                style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${data['count']} sold',
              style: tt.bodySmall?.copyWith(
                color: AppTheme.mutedText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
