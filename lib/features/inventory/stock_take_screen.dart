import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_colors.dart';
import '../../data/database/app_database.dart';

class StockTakeScreen extends ConsumerStatefulWidget {
  const StockTakeScreen({super.key});

  @override
  ConsumerState<StockTakeScreen> createState() => _StockTakeScreenState();
}

class _StockTakeScreenState extends ConsumerState<StockTakeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<int, double> _physicalCounts = {};
  final Map<int, String> _varianceReasons = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        title: const Row(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedPackage,
              color: AppTheme.primaryCoffee,
            ),
            SizedBox(width: 10),
            Text(
              'Audit Stok Fizikal & Varians (Stock Take)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryCoffee,
          labelColor: AppTheme.primaryCoffee,
          unselectedLabelColor: AppTheme.mutedText,
          tabs: const [
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedEdit01),
              text: 'Kiraan Stok Semasa',
            ),
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedFile02),
              text: 'Log Audit & Varians',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildStockTakeEntryTab(), _buildAuditHistoryTab()],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 1: Stock Take Entry Form
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildStockTakeEntryTab() {
    final ingredientsAsync = ref.watch(ingredientsProvider);

    return ingredientsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryCoffee),
      ),
      error: (err, _) => Center(
        child: Text('Ralat: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (ingredients) {
        if (ingredients.isEmpty) {
          return const Center(
            child: Text(
              'Tiada ramuan dalam pangkalan data',
              style: TextStyle(color: AppTheme.mutedText),
            ),
          );
        }

        // Initialize physical counts default to currentStock if not set
        for (final ing in ingredients) {
          _physicalCounts.putIfAbsent(ing.id, () => ing.currentStock);
          _varianceReasons.putIfAbsent(ing.id, () => 'Pemeriksaan Rutin');
        }

        // Calculate overall variance
        double totalVarianceValue = 0.0;
        int itemsWithVariance = 0;

        for (final ing in ingredients) {
          final count = _physicalCounts[ing.id] ?? ing.currentStock;
          final diff = count - ing.currentStock;
          if (diff.abs() > 0.001) {
            itemsWithVariance++;
            totalVarianceValue += diff * ing.costPerUnit;
          }
        }

        return Column(
          children: [
            // KPI Summary Banner
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  _buildKpiCard(
                    title: 'Jumlah Item',
                    value: '${ingredients.length}',
                    color: Colors.blue,
                    icon: HugeIcons.strokeRoundedSquare,
                  ),
                  const SizedBox(width: 12),
                  _buildKpiCard(
                    title: 'Item Ada Varians',
                    value: '$itemsWithVariance',
                    color: itemsWithVariance > 0 ? Colors.orange : Colors.green,
                    icon: HugeIcons.strokeRoundedSquare,
                  ),
                  const SizedBox(width: 12),
                  _buildKpiCard(
                    title: 'Nilai Varians Bersih',
                    value: 'RM ${totalVarianceValue.toStringAsFixed(2)}',
                    color: totalVarianceValue < 0
                        ? Colors.red
                        : (totalVarianceValue > 0
                              ? Colors.green
                              : Colors.white),
                    icon: HugeIcons.strokeRoundedSquare,
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCoffee,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                    ),
                    label: const Text(
                      'Selaraskan Semua Stok',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _commitAllAudits(ingredients),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Ingredients Stock Take Table
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  final ing = ingredients[index];
                  final physical = _physicalCounts[ing.id] ?? ing.currentStock;
                  final varianceQty = physical - ing.currentStock;
                  final varianceCost = varianceQty * ing.costPerUnit;
                  final hasVariance = varianceQty.abs() > 0.001;

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: hasVariance
                            ? (varianceQty < 0
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.orange.withOpacity(0.5))
                            : Colors.white10,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Ingredient info
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ing.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Kos/Unit: RM ${ing.costPerUnit.toStringAsFixed(3)} / ${ing.unit}',
                                  style: const TextStyle(
                                    color: AppTheme.mutedText,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Stok Sistem: ${ing.currentStock.toStringAsFixed(1)} ${ing.unit}',
                                  style: const TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Physical count input
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedRemove01,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      final current =
                                          _physicalCounts[ing.id] ??
                                          ing.currentStock;
                                      _physicalCounts[ing.id] = (current - 1)
                                          .clamp(0.0, 99999.0);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    key: ValueKey('ing_${ing.id}_$physical'),
                                    initialValue: physical.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      suffixText: ing.unit,
                                      suffixStyle: const TextStyle(
                                        color: AppTheme.mutedText,
                                        fontSize: 11,
                                      ),
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                    ),
                                    onChanged: (v) {
                                      final parsed = double.tryParse(v);
                                      if (parsed != null) {
                                        _physicalCounts[ing.id] = parsed;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedAdd01,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      final current =
                                          _physicalCounts[ing.id] ??
                                          ing.currentStock;
                                      _physicalCounts[ing.id] = current + 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Variance indicators
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Varians: ${varianceQty >= 0 ? '+' : ''}${varianceQty.toStringAsFixed(1)} ${ing.unit}',
                                      style: TextStyle(
                                        color: varianceQty == 0
                                            ? Colors.green
                                            : (varianceQty < 0
                                                  ? Colors.red
                                                  : Colors.orange),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Impak RM: ${varianceCost >= 0 ? '+' : ''}RM ${varianceCost.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: varianceCost < 0
                                        ? Colors.redAccent
                                        : Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Variance Reason
                          if (hasVariance)
                            Expanded(
                              flex: 3,
                              child: DropdownButtonFormField<String>(
                                value:
                                    _varianceReasons[ing.id] ??
                                    'Pemeriksaan Rutin',
                                dropdownColor: Colors.white,
                                style: const TextStyle(fontSize: 12),
                                decoration: const InputDecoration(
                                  labelText: 'Sebab Varians',
                                  labelStyle: TextStyle(
                                    color: AppTheme.mutedText,
                                    fontSize: 11,
                                  ),
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Pemeriksaan Rutin',
                                    child: Text('Pemeriksaan Rutin'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Pembaziran (Wastage)',
                                    child: Text('Pembaziran (Wastage)'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Tarikh Luput (Expired)',
                                    child: Text('Tarikh Luput (Expired)'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Tumpahan (Spillage)',
                                    child: Text('Tumpahan (Spillage)'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Makanan Staf (Staff Meal)',
                                    child: Text('Makanan Staf'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Ralat Kiraan / Lain-lain',
                                    child: Text('Ralat Kiraan'),
                                  ),
                                ],
                                onChanged: (val) {
                                  if (val != null)
                                    setState(
                                      () => _varianceReasons[ing.id] = val,
                                    );
                                },
                              ),
                            ),

                          const SizedBox(width: 12),

                          // Individual commit button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hasVariance
                                  ? Colors.orange.shade800
                                  : Colors.white,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () => _commitSingleAudit(
                              ing,
                              physical,
                              varianceQty,
                              varianceCost,
                            ),
                            child: const Text(
                              'Selaras',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required Color color,
    required dynamic icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          HugeIcon(icon: icon, color: color, size: 24),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppTheme.mutedText, fontSize: 11),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _commitSingleAudit(
    Ingredient ing,
    double physical,
    double varianceQty,
    double varianceCost,
  ) async {
    final reason = _varianceReasons[ing.id] ?? 'Pemeriksaan Rutin';

    await ref
        .read(databaseProvider)
        .insertStockAudit(
          StockAuditsCompanion.insert(
            ingredientId: ing.id,
            ingredientName: ing.name,
            unit: drift.Value(ing.unit),
            expectedStock: drift.Value(ing.currentStock),
            actualStock: drift.Value(physical),
            varianceQuantity: drift.Value(varianceQty),
            varianceValue: drift.Value(varianceCost),
            reason: drift.Value(reason),
            auditedBy: const drift.Value('Pengurus Syif'),
          ),
          adjustInventory: true,
        );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Stok ${ing.name} berjaya diselaraskan kepada $physical ${ing.unit}!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _commitAllAudits(List<Ingredient> ingredients) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Sahkan Sesi Stock Take', style: TextStyle()),
        content: const Text(
          'Semua baki stok inventori akan diselaraskan mengikut kiraan fizikal yang dimasukkan.\n\nLog audit lengkap akan disimpan untuk semakan varians.',
          style: TextStyle(color: AppTheme.mutedText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Batal',
              style: TextStyle(color: AppTheme.mutedText),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryCoffee,
            ),
            onPressed: () async {
              for (final ing in ingredients) {
                final physical = _physicalCounts[ing.id] ?? ing.currentStock;
                final varianceQty = physical - ing.currentStock;
                final varianceCost = varianceQty * ing.costPerUnit;
                final reason = _varianceReasons[ing.id] ?? 'Pemeriksaan Rutin';

                await ref
                    .read(databaseProvider)
                    .insertStockAudit(
                      StockAuditsCompanion.insert(
                        ingredientId: ing.id,
                        ingredientName: ing.name,
                        unit: drift.Value(ing.unit),
                        expectedStock: drift.Value(ing.currentStock),
                        actualStock: drift.Value(physical),
                        varianceQuantity: drift.Value(varianceQty),
                        varianceValue: drift.Value(varianceCost),
                        reason: drift.Value(reason),
                        auditedBy: const drift.Value('Pengurus Syif'),
                      ),
                      adjustInventory: true,
                    );
              }

              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Semua ramuan berjaya diselaraskan & log audit direkodkan!',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Sahkan & Kemaskini Semua', style: TextStyle()),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 2: Audit & Variance History Log
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildAuditHistoryTab() {
    final auditsAsync = ref.watch(allStockAuditsProvider);
    final df = DateFormat('dd MMM yyyy, HH:mm');

    return auditsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryCoffee),
      ),
      error: (err, _) => Center(
        child: Text('Ralat: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (audits) {
        if (audits.isEmpty) {
          return const Center(
            child: Text(
              'Tiada rekod audit stok lagi',
              style: TextStyle(color: AppTheme.mutedText),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: audits.length,
          itemBuilder: (context, index) {
            final audit = audits[index];
            final isLoss = audit.varianceQuantity < 0;

            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isLoss
                      ? Colors.red.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  child: HugeIcon(
                    icon: isLoss
                        ? HugeIcons.strokeRoundedSquare
                        : HugeIcons.strokeRoundedSquare,
                    color: isLoss ? Colors.red : Colors.green,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      audit.ingredientName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        audit.reason,
                        style: const TextStyle(
                          color: AppTheme.primaryCoffee,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Sistem: ${audit.expectedStock.toStringAsFixed(1)} ➔ Fizikal: ${audit.actualStock.toStringAsFixed(1)} ${audit.unit} • Diaudit oleh: ${audit.auditedBy} (${df.format(audit.auditedAt)})',
                  style: const TextStyle(
                    color: AppTheme.mutedText,
                    fontSize: 12,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${audit.varianceQuantity >= 0 ? '+' : ''}${audit.varianceQuantity.toStringAsFixed(1)} ${audit.unit}',
                      style: TextStyle(
                        color: isLoss ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${audit.varianceValue >= 0 ? '+' : ''}RM ${audit.varianceValue.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isLoss ? Colors.redAccent : Colors.greenAccent,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
