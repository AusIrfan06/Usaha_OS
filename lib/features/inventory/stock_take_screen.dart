import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../../core/providers.dart';
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
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.inventory_outlined, color: AppColors.primary),
            SizedBox(width: 10),
            Text(
              'Audit Stok Fizikal & Varians (Stock Take)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: AppColors.surfaceDark,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          tabs: const [
            Tab(icon: Icon(Icons.edit_note), text: 'Kiraan Stok Semasa'),
            Tab(icon: Icon(Icons.history), text: 'Log Audit & Varians'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStockTakeEntryTab(),
          _buildAuditHistoryTab(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 1: Stock Take Entry Form
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildStockTakeEntryTab() {
    final ingredientsAsync = ref.watch(ingredientsProvider);

    return ingredientsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (err, _) => Center(child: Text('Ralat: $err', style: const TextStyle(color: Colors.red))),
      data: (ingredients) {
        if (ingredients.isEmpty) {
          return const Center(
            child: Text('Tiada ramuan dalam pangkalan data', style: TextStyle(color: AppColors.textMuted)),
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
              color: AppColors.surfaceDark,
              child: Row(
                children: [
                  _buildKpiCard(
                    title: 'Jumlah Item',
                    value: '${ingredients.length}',
                    color: Colors.blue,
                    icon: Icons.category,
                  ),
                  const SizedBox(width: 12),
                  _buildKpiCard(
                    title: 'Item Ada Varians',
                    value: '$itemsWithVariance',
                    color: itemsWithVariance > 0 ? Colors.orange : Colors.green,
                    icon: Icons.difference,
                  ),
                  const SizedBox(width: 12),
                  _buildKpiCard(
                    title: 'Nilai Varians Bersih',
                    value: 'RM ${totalVarianceValue.toStringAsFixed(2)}',
                    color: totalVarianceValue < 0 ? Colors.red : (totalVarianceValue > 0 ? Colors.green : Colors.white),
                    icon: Icons.monetization_on,
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Selaraskan Semua Stok', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => _commitAllAudits(ingredients),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.cardDark),

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
                    color: AppColors.cardDark,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: hasVariance
                            ? (varianceQty < 0 ? Colors.red.withOpacity(0.5) : Colors.orange.withOpacity(0.5))
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
                                  style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Stok Sistem: ${ing.currentStock.toStringAsFixed(1)} ${ing.unit}',
                                  style: const TextStyle(color: Colors.cyan, fontSize: 13, fontWeight: FontWeight.w600),
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
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      final current = _physicalCounts[ing.id] ?? ing.currentStock;
                                      _physicalCounts[ing.id] = (current - 1).clamp(0.0, 99999.0);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    key: ValueKey('ing_${ing.id}_$physical'),
                                    initialValue: physical.toStringAsFixed(1),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      suffixText: ing.unit,
                                      suffixStyle: const TextStyle(color: AppColors.textMuted, fontSize: 11),
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
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      final current = _physicalCounts[ing.id] ?? ing.currentStock;
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
                                        color: varianceQty == 0 ? Colors.green : (varianceQty < 0 ? Colors.red : Colors.orange),
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
                                    color: varianceCost < 0 ? Colors.redAccent : Colors.white70,
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
                                value: _varianceReasons[ing.id] ?? 'Pemeriksaan Rutin',
                                dropdownColor: AppColors.surfaceDark,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                                decoration: const InputDecoration(
                                  labelText: 'Sebab Varians',
                                  labelStyle: TextStyle(color: AppColors.textMuted, fontSize: 11),
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(value: 'Pemeriksaan Rutin', child: Text('Pemeriksaan Rutin')),
                                  DropdownMenuItem(value: 'Pembaziran (Wastage)', child: Text('Pembaziran (Wastage)')),
                                  DropdownMenuItem(value: 'Tarikh Luput (Expired)', child: Text('Tarikh Luput (Expired)')),
                                  DropdownMenuItem(value: 'Tumpahan (Spillage)', child: Text('Tumpahan (Spillage)')),
                                  DropdownMenuItem(value: 'Makanan Staf (Staff Meal)', child: Text('Makanan Staf')),
                                  DropdownMenuItem(value: 'Ralat Kiraan / Lain-lain', child: Text('Ralat Kiraan')),
                                ],
                                onChanged: (val) {
                                  if (val != null) setState(() => _varianceReasons[ing.id] = val);
                                },
                              ),
                            ),

                          const SizedBox(width: 12),

                          // Individual commit button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hasVariance ? Colors.orange.shade800 : AppColors.surfaceDark,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            onPressed: () => _commitSingleAudit(ing, physical, varianceQty, varianceCost),
                            child: const Text('Selaras', style: TextStyle(fontSize: 12)),
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
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              Text(
                value,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _commitSingleAudit(Ingredient ing, double physical, double varianceQty, double varianceCost) async {
    final reason = _varianceReasons[ing.id] ?? 'Pemeriksaan Rutin';

    await ref.read(databaseProvider).insertStockAudit(
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
        content: Text('Stok ${ing.name} berjaya diselaraskan kepada $physical ${ing.unit}!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _commitAllAudits(List<Ingredient> ingredients) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Sahkan Sesi Stock Take', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Semua baki stok inventori akan diselaraskan mengikut kiraan fizikal yang dimasukkan.\n\nLog audit lengkap akan disimpan untuk semakan varians.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () async {
              for (final ing in ingredients) {
                final physical = _physicalCounts[ing.id] ?? ing.currentStock;
                final varianceQty = physical - ing.currentStock;
                final varianceCost = varianceQty * ing.costPerUnit;
                final reason = _varianceReasons[ing.id] ?? 'Pemeriksaan Rutin';

                await ref.read(databaseProvider).insertStockAudit(
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
                    content: Text('Semua ramuan berjaya diselaraskan & log audit direkodkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Sahkan & Kemaskini Semua', style: TextStyle(color: Colors.white)),
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
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (err, _) => Center(child: Text('Ralat: $err', style: const TextStyle(color: Colors.red))),
      data: (audits) {
        if (audits.isEmpty) {
          return const Center(
            child: Text('Tiada rekod audit stok lagi', style: TextStyle(color: AppColors.textMuted)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: audits.length,
          itemBuilder: (context, index) {
            final audit = audits[index];
            final isLoss = audit.varianceQuantity < 0;

            return Card(
              color: AppColors.cardDark,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isLoss ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                  child: Icon(
                    isLoss ? Icons.trending_down : Icons.trending_up,
                    color: isLoss ? Colors.red : Colors.green,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      audit.ingredientName,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        audit.reason,
                        style: const TextStyle(color: AppColors.primary, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Sistem: ${audit.expectedStock.toStringAsFixed(1)} ➔ Fizikal: ${audit.actualStock.toStringAsFixed(1)} ${audit.unit} • Diaudit oleh: ${audit.auditedBy} (${df.format(audit.auditedAt)})',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
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
