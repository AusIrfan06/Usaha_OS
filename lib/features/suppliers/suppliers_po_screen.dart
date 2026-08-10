import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_colors.dart';
import '../../data/database/app_database.dart';

class SuppliersPoScreen extends ConsumerStatefulWidget {
  const SuppliersPoScreen({super.key});

  @override
  ConsumerState<SuppliersPoScreen> createState() => _SuppliersPoScreenState();
}

class _SuppliersPoScreenState extends ConsumerState<SuppliersPoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
              icon: HugeIcons.strokeRoundedTruckDelivery,
              color: AppTheme.primaryCoffee,
            ),
            SizedBox(width: 10),
            Text(
              'Pembekal & Pesanan Belian (PO)',
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
              icon: HugeIcon(icon: HugeIcons.strokeRoundedInvoice01),
              text: 'Pesanan Belian (PO)',
            ),
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedAddressBook),
              text: 'Direktori Pembekal',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_PurchaseOrdersTab(), _SuppliersTab()],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1: Purchase Orders (PO)
// ─────────────────────────────────────────────────────────────────────────────

class _PurchaseOrdersTab extends ConsumerWidget {
  const _PurchaseOrdersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posAsync = ref.watch(allPurchaseOrdersProvider);

    return posAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryCoffee),
      ),
      error: (err, stack) => Center(
        child: Text('Ralat: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (pos) {
        return Column(
          children: [
            // Top action bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    'Jumlah PO: ${pos.length}',
                    style: const TextStyle(
                      color: AppTheme.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCoffee,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedAdd01,
                      size: 18,
                    ),
                    label: const Text('Cipta PO Baharu'),
                    onPressed: () => _showCreatePoDialog(context, ref),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // PO List
            Expanded(
              child: pos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedInvoice01,
                            size: 64,
                            color: AppTheme.mutedText.withOpacity(0.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Tiada pesanan belian aktif',
                            style: TextStyle(
                              color: AppTheme.mutedText,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () => _showCreatePoDialog(context, ref),
                            icon: HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
                            label: const Text('Cipta PO Pertama'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: pos.length,
                      itemBuilder: (context, index) {
                        final po = pos[index];
                        return _PoCard(po: po);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  void _showCreatePoDialog(BuildContext context, WidgetRef ref) async {
    final suppliers = await ref.read(databaseProvider).getAllSuppliers();
    final ingredients = await ref.read(databaseProvider).getAllIngredients();

    if (suppliers.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sila tambah pembekal terlebih dahulu di tab Direktori Pembekal!',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (ctx) =>
          _CreatePoDialog(suppliers: suppliers, ingredients: ingredients),
    );
  }
}

class _PoCard extends ConsumerWidget {
  final PurchaseOrder po;
  const _PoCard({required this.po});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(purchaseOrderItemsProvider(po.id));
    final df = DateFormat('dd MMM yyyy, HH:mm');

    Color statusColor;
    String statusText;
    switch (po.status) {
      case 'received':
        statusColor = Colors.green;
        statusText = 'Diterima & Stok Dikemaskini';
        break;
      case 'ordered':
        statusColor = Colors.orange;
        statusText = 'Dipesan (Menunggu Penghantaran)';
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = 'Dibatalkan';
        break;
      default:
        statusColor = Colors.blue;
        statusText = 'Draf';
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: po.status == 'ordered'
              ? Colors.orange.withOpacity(0.4)
              : Colors.white10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppTheme.primaryCoffee.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    po.poNumber,
                    style: const TextStyle(
                      color: AppTheme.primaryCoffee,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    po.supplierName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Date & Notes
            Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedBuilding04,
                  size: 14,
                  color: AppTheme.mutedText,
                ),
                const SizedBox(width: 6),
                Text(
                  'Tarikh Pesanan: ${df.format(po.orderDate)}',
                  style: const TextStyle(
                    color: AppTheme.mutedText,
                    fontSize: 12,
                  ),
                ),
                if (po.expectedDate != null) ...[
                  const SizedBox(width: 16),
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedTruckDelivery,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Jangkaan: ${DateFormat('dd MMM').format(po.expectedDate!)}',
                    style: const TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                ],
              ],
            ),
            if (po.notes.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                'Nota: ${po.notes}',
                style: const TextStyle(
                  color: AppTheme.mutedText,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            Divider(height: 20, color: AppTheme.mutedText.withOpacity(0.2)),

            // Items List
            itemsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (err, _) => Text(
                'Ralat item: $err',
                style: const TextStyle(color: Colors.red),
              ),
              data: (items) {
                return Column(
                  children: [
                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              '• ${item.ingredientName}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const Spacer(),
                            Text(
                              '${item.quantityOrdered.toStringAsFixed(1)} ${item.unit} @ RM${item.unitCost.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppTheme.mutedText,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'RM ${item.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            Divider(height: 20, color: AppTheme.mutedText.withOpacity(0.2)),

            // Footer: Total & Action Buttons
            Row(
              children: [
                const Text(
                  'Jumlah Anggaran:',
                  style: TextStyle(color: AppTheme.mutedText, fontSize: 13),
                ),
                const SizedBox(width: 8),
                Text(
                  'RM ${po.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppTheme.primaryCoffee,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (po.status == 'draft')
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange,
                      side: const BorderSide(color: Colors.orange),
                    ),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedStore01,
                      size: 16,
                    ),
                    label: const Text('Hantar Pesanan'),
                    onPressed: () {
                      ref
                          .read(databaseProvider)
                          .updatePurchaseOrderStatus(po.id, 'ordered');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'PO ${po.poNumber} telah ditanda sebagai Dipesan',
                          ),
                        ),
                      );
                    },
                  ),
                if (po.status == 'ordered')
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                    ),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedPackage,
                      size: 16,
                    ),
                    label: const Text('Terima Barang (Auto-Stock)'),
                    onPressed: () => _confirmReceiveGoods(context, ref, po),
                  ),
                if (po.status == 'received')
                  const Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                        color: Colors.green,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Stok Telah Ditambah',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReceiveGoods(
    BuildContext context,
    WidgetRef ref,
    PurchaseOrder po,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Penerimaan Barang (Goods Receiving)',
          style: TextStyle(),
        ),
        content: Text(
          'Adakah anda telah menerima semua barang untuk ${po.poNumber}?\n\nKuantiti stok bagi semua ramuan dalam PO ini akan DITAMBAHKAN secara automatik ke dalam inventori.',
          style: const TextStyle(color: AppTheme.mutedText),
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
              backgroundColor: Colors.green.shade700,
            ),
            onPressed: () async {
              await ref.read(databaseProvider).receivePurchaseOrder(po.id);
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Barang ${po.poNumber} berjaya diterima & stok dikemaskini!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Sahkan & Tambah Stok', style: TextStyle()),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Create PO Dialog
// ─────────────────────────────────────────────────────────────────────────────

class _CreatePoDialog extends ConsumerStatefulWidget {
  final List<Supplier> suppliers;
  final List<Ingredient> ingredients;

  const _CreatePoDialog({required this.suppliers, required this.ingredients});

  @override
  ConsumerState<_CreatePoDialog> createState() => _CreatePoDialogState();
}

class _CreatePoDialogState extends ConsumerState<_CreatePoDialog> {
  late Supplier _selectedSupplier;
  final List<_PoItemDraft> _items = [];
  final TextEditingController _notesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedSupplier = widget.suppliers.first;
    if (widget.ingredients.isNotEmpty) {
      _items.add(
        _PoItemDraft(
          ingredient: widget.ingredients.first,
          quantity: 10.0,
          unitCost: widget.ingredients.first.costPerUnit > 0
              ? widget.ingredients.first.costPerUnit
              : 1.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _items.fold(
      0.0,
      (sum, i) => sum + (i.quantity * i.unitCost),
    );

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedAdd01,
                  color: AppTheme.primaryCoffee,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Cipta Pesanan Belian (PO)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    color: AppTheme.mutedText,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Divider(color: AppTheme.mutedText.withOpacity(0.2)),

            // Supplier Dropdown
            const Text(
              'Pilih Pembekal:',
              style: TextStyle(color: AppTheme.mutedText, fontSize: 13),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.mutedText.withOpacity(0.2)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Supplier>(
                  value: _selectedSupplier,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  items: widget.suppliers.map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(
                        '${s.name} (${s.category})',
                        style: const TextStyle(),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedSupplier = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Items List
            Row(
              children: [
                const Text(
                  'Senarai Ramuan:',
                  style: TextStyle(color: AppTheme.mutedText, fontSize: 13),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: widget.ingredients.isEmpty
                      ? null
                      : () {
                          setState(() {
                            _items.add(
                              _PoItemDraft(
                                ingredient: widget.ingredients.first,
                                quantity: 5.0,
                                unitCost: widget.ingredients.first.costPerUnit,
                              ),
                            );
                          });
                        },
                  icon: HugeIcon(icon: HugeIcons.strokeRoundedAdd01, size: 16),
                  label: const Text('Tambah Ramuan'),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, idx) {
                  final item = _items[idx];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Ingredient>(
                              value: item.ingredient,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              items: widget.ingredients.map((ing) {
                                return DropdownMenuItem(
                                  value: ing,
                                  child: Text(
                                    ing.name,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    item.ingredient = val;
                                    item.unitCost = val.costPerUnit > 0
                                        ? val.costPerUnit
                                        : 1.0;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: item.quantity.toString(),
                            style: const TextStyle(fontSize: 13),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Kuantiti (${item.ingredient.unit})',
                              labelStyle: const TextStyle(
                                color: AppTheme.mutedText,
                                fontSize: 11,
                              ),
                              isDense: true,
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              setState(() {
                                item.quantity = double.tryParse(v) ?? 0.0;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: item.unitCost.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 13),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Kos/Unit (RM)',
                              labelStyle: TextStyle(
                                color: AppTheme.mutedText,
                                fontSize: 11,
                              ),
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              setState(() {
                                item.unitCost = double.tryParse(v) ?? 0.0;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'RM ${(item.quantity * item.unitCost).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppTheme.primaryCoffee,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        IconButton(
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedDelete01,
                            color: Colors.red,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() => _items.removeAt(idx));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: _notesCtrl,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'Nota Pesanan / Arahan Khas',
                labelStyle: TextStyle(color: AppTheme.mutedText),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 16),

            // Total & Save
            Row(
              children: [
                const Text(
                  'Jumlah Anggaran: ',
                  style: TextStyle(color: AppTheme.mutedText),
                ),
                Text(
                  'RM ${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppTheme.primaryCoffee,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: AppTheme.mutedText),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryCoffee,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _items.isEmpty
                      ? null
                      : () async {
                          final now = DateTime.now();
                          final poNumber =
                              'PO-${DateFormat('yyyyMMdd').format(now)}-${now.millisecond}';

                          final poCompanion = PurchaseOrdersCompanion.insert(
                            poNumber: poNumber,
                            supplierId: _selectedSupplier.id,
                            supplierName: _selectedSupplier.name,
                            status: const drift.Value('ordered'),
                            totalAmount: drift.Value(totalAmount),
                            notes: drift.Value(_notesCtrl.text),
                          );

                          final itemsCompanion = _items.map((i) {
                            return PurchaseOrderItemsCompanion.insert(
                              poId: 0,
                              ingredientId: i.ingredient.id,
                              ingredientName: i.ingredient.name,
                              unit: drift.Value(i.ingredient.unit),
                              quantityOrdered: drift.Value(i.quantity),
                              quantityReceived: const drift.Value(0.0),
                              unitCost: drift.Value(i.unitCost),
                              subtotal: drift.Value(i.quantity * i.unitCost),
                            );
                          }).toList();

                          await ref
                              .read(databaseProvider)
                              .insertPurchaseOrder(poCompanion, itemsCompanion);

                          if (!context.mounted) return;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('PO $poNumber berjaya dicipta!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                  child: const Text('Simpan & Hantar PO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PoItemDraft {
  Ingredient ingredient;
  double quantity;
  double unitCost;

  _PoItemDraft({
    required this.ingredient,
    required this.quantity,
    required this.unitCost,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2: Suppliers Directory
// ─────────────────────────────────────────────────────────────────────────────

class _SuppliersTab extends ConsumerWidget {
  const _SuppliersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(allSuppliersProvider);

    return suppliersAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryCoffee),
      ),
      error: (err, _) => Center(
        child: Text('Ralat: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (suppliers) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    'Jumlah Pembekal: ${suppliers.length}',
                    style: const TextStyle(
                      color: AppTheme.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCoffee,
                      foregroundColor: Colors.white,
                    ),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedAdd01,
                      size: 18,
                    ),
                    label: const Text('Tambah Pembekal'),
                    onPressed: () => _showAddSupplierDialog(context, ref),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: suppliers.isEmpty
                  ? const Center(
                      child: Text(
                        'Tiada pembekal berdaftar',
                        style: TextStyle(color: AppTheme.mutedText),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: suppliers.length,
                      itemBuilder: (context, index) {
                        final s = suppliers[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.primaryCoffee
                                  .withOpacity(0.2),
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedStore01,
                                color: AppTheme.primaryCoffee,
                              ),
                            ),
                            title: Text(
                              s.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    if (s.contactPerson != null) ...[
                                      HugeIcon(
                                        icon: HugeIcons.strokeRoundedUser,
                                        size: 13,
                                        color: AppTheme.mutedText,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        s.contactPerson!,
                                        style: const TextStyle(
                                          color: AppTheme.mutedText,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                    if (s.phone != null) ...[
                                      HugeIcon(
                                        icon: HugeIcons.strokeRoundedCall,
                                        size: 13,
                                        color: AppTheme.mutedText,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        s.phone!,
                                        style: const TextStyle(
                                          color: AppTheme.mutedText,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                if (s.address != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    s.address!,
                                    style: const TextStyle(
                                      color: AppTheme.mutedText,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppTheme.mutedText.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                s.category,
                                style: const TextStyle(
                                  color: AppTheme.primaryCoffee,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

  void _showAddSupplierDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final personCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    String category = 'Coffee Beans';
    String terms = 'COD';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Tambah Pembekal Baharu', style: TextStyle()),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 450,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Nama Syarikat / Pembekal *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: personCtrl,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Pegawai Dihubungi (Contact Person)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneCtrl,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'No. Telefon',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailCtrl,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Emel',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressCtrl,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Alamat',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: category,
                    dropdownColor: Colors.white,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Kategori Bekalan',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Coffee Beans',
                        child: Text('Biji Kopi (Beans)'),
                      ),
                      DropdownMenuItem(
                        value: 'Dairy & Milk',
                        child: Text('Tenusu & Susu'),
                      ),
                      DropdownMenuItem(
                        value: 'Packaging',
                        child: Text('Pembungkusan & Cawan'),
                      ),
                      DropdownMenuItem(
                        value: 'Syrups',
                        child: Text('Sirap & Perasa'),
                      ),
                      DropdownMenuItem(
                        value: 'Fresh Food',
                        child: Text('Bahan Masakan Basah'),
                      ),
                    ],
                    onChanged: (v) => setState(() => category = v!),
                  ),
                ],
              ),
            ),
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
                if (nameCtrl.text.trim().isEmpty) return;
                await ref
                    .read(databaseProvider)
                    .insertSupplier(
                      SuppliersCompanion.insert(
                        name: nameCtrl.text.trim(),
                        contactPerson: drift.Value(personCtrl.text.trim()),
                        phone: drift.Value(phoneCtrl.text.trim()),
                        email: drift.Value(emailCtrl.text.trim()),
                        address: drift.Value(addressCtrl.text.trim()),
                        category: drift.Value(category),
                        paymentTerms: drift.Value(terms),
                      ),
                    );
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
              },
              child: const Text('Simpan', style: TextStyle()),
            ),
          ],
        ),
      ),
    );
  }
}
