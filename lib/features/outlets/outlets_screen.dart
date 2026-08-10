import 'package:hugeicons/hugeicons.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../../shared/widgets/common_widgets.dart';

class OutletsScreen extends ConsumerStatefulWidget {
  const OutletsScreen({super.key});

  @override
  ConsumerState<OutletsScreen> createState() => _OutletsScreenState();
}

class _OutletsScreenState extends ConsumerState<OutletsScreen>
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
    final outletsAsync = ref.watch(allOutletsProvider);
    final transfersAsync = ref.watch(allStockTransfersProvider);
    final activeOutlet = ref.watch(activeOutletProvider);
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        title: const Text(
          'Pengurusan Multi-Outlet & Pemindahan Stok',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppTheme.darkEspresso,
          ),
        ),
        backgroundColor: AppTheme.warmCream,
        surfaceTintColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryCoffee,
          unselectedLabelColor: AppTheme.mutedText,
          indicatorColor: AppTheme.primaryCoffee,
          tabs: const [
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedStore01),
              text: 'Senarai Cawangan',
            ),
            Tab(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedPackage),
              text: 'Pemindahan Stok (Transfer)',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Outlets List & Active Branch Switcher
          outletsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Ralat: $e')),
            data: (outletsList) {
              return _buildOutletsTab(
                context,
                outletsList,
                activeOutlet,
                isTablet,
              );
            },
          ),

          // Tab 2: Cross-Branch Stock Transfers
          transfersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Ralat: $e')),
            data: (transfersList) {
              return _buildTransfersTab(context, transfersList, isTablet);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryCoffee,
        foregroundColor: Colors.white,
        icon: HugeIcon(
          icon: _tabController.index == 0
              ? HugeIcons.strokeRoundedAdd01
              : HugeIcons.strokeRoundedPackage,
        ),
        label: Text(
          _tabController.index == 0 ? 'Tambah Cawangan' : 'Pindah Stok',
        ),
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddOutletDialog(context);
          } else {
            _showRequestTransferDialog(context);
          }
        },
      ),
    );
  }

  Widget _buildOutletsTab(
    BuildContext context,
    List<Outlet> outletsList,
    Outlet? activeOutlet,
    bool isTablet,
  ) {
    if (outletsList.isEmpty) {
      return const Center(child: Text('Tiada cawangan direkodkan'));
    }

    final currentSelected =
        activeOutlet ??
        outletsList.firstWhere(
          (o) => o.isPrimary,
          orElse: () => outletsList.first,
        );

    return ListView(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      children: [
        // Active Branch Banner
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.darkEspresso, AppTheme.primaryCoffee],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryCoffee.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedStore01,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CAWANGAN AKTIF SISTEM',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currentSelected.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Kod: ${currentSelected.code} • Pelaras Harga: ${(currentSelected.priceMultiplier * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Aktif',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const SectionHeader(
          title: 'Senarai Semua Cawangan (HQ & Cawangan Tambahan)',
        ),
        const SizedBox(height: 12),

        ...outletsList.map((outlet) {
          final isSelected = currentSelected.id == outlet.id;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: isSelected ? 3 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: isSelected
                  ? const BorderSide(color: AppTheme.primaryCoffee, width: 2)
                  : BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: outlet.isPrimary
                          ? AppTheme.primaryCoffee.withOpacity(0.15)
                          : Colors.grey.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: HugeIcon(
                      icon: outlet.isPrimary
                          ? HugeIcons.strokeRoundedBank
                          : HugeIcons.strokeRoundedStore01,
                      color: outlet.isPrimary
                          ? AppTheme.primaryCoffee
                          : AppTheme.darkEspresso,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              outlet.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            if (outlet.isPrimary) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryCoffee,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'HQ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          outlet.address.isNotEmpty
                              ? outlet.address
                              : 'Tiada alamat',
                          style: const TextStyle(
                            color: AppTheme.mutedText,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tel: ${outlet.phone.isNotEmpty ? outlet.phone : '-'} • Pelaras Harga: ${(outlet.priceMultiplier * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: AppTheme.mutedText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? Colors.grey.shade200
                          : AppTheme.primaryCoffee,
                      foregroundColor: isSelected
                          ? AppTheme.darkEspresso
                          : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ref.read(activeOutletProvider.notifier).state = outlet;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Cawangan aktif ditukar kepada: ${outlet.name}',
                          ),
                          backgroundColor: AppTheme.successGreen,
                        ),
                      );
                    },
                    child: Text(
                      isSelected ? 'Sedang Digunakan' : 'Pilih Cawangan',
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTransfersTab(
    BuildContext context,
    List<StockTransfer> transfersList,
    bool isTablet,
  ) {
    if (transfersList.isEmpty) {
      return const Center(child: Text('Tiada pemindahan stok direkodkan'));
    }

    final outletsAsync = ref.watch(allOutletsProvider);
    final ingredientsAsync = ref.watch(ingredientsProvider);

    final outletsMap = {
      for (var o in outletsAsync.value ?? <Outlet>[]) o.id: o.name,
    };
    final ingMap = {
      for (var i in ingredientsAsync.value ?? <Ingredient>[]) i.id: i,
    };

    return ListView(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      children: [
        const SectionHeader(
          title: 'Log Pemindahan Stok Antara Cawangan (Inter-Branch)',
        ),
        const SizedBox(height: 12),
        ...transfersList.map((trf) {
          final sourceName =
              outletsMap[trf.sourceOutletId] ??
              'Cawangan #${trf.sourceOutletId}';
          final targetName =
              outletsMap[trf.targetOutletId] ??
              'Cawangan #${trf.targetOutletId}';
          final ing = ingMap[trf.ingredientId];
          final ingName = ing?.name ?? 'Bahan #${trf.ingredientId}';
          final unit = ing?.unit ?? 'unit';

          Color statusColor = AppTheme.warningAmber;
          String statusText = 'Dalam Perjalanan';
          if (trf.status == 'received') {
            statusColor = AppTheme.successGreen;
            statusText = 'Selesai Diterima';
          } else if (trf.status == 'pending') {
            statusColor = Colors.orange;
            statusText = 'Menunggu';
          } else if (trf.status == 'cancelled') {
            statusColor = AppTheme.dangerRed;
            statusText = 'Dibatalkan';
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
                      Text(
                        trf.transferNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: statusColor, width: 1),
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
                  const Divider(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'DARI (SUMBER)',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.mutedText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              sourceName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        color: AppTheme.primaryCoffee,
                        size: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'KE (DESTINASI)',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.mutedText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              targetName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.warmCream,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$ingName: ${trf.quantity} $unit',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Pemohon: ${trf.requestedBy}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.mutedText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trf.notes.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Nota: ${trf.notes}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: AppTheme.mutedText,
                      ),
                    ),
                  ],
                  if (trf.status == 'in_transit' ||
                      trf.status == 'pending') ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            ref
                                .read(databaseProvider)
                                .updateStockTransferStatus(trf.id, 'cancelled');
                          },
                          child: const Text('Batal'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.successGreen,
                            foregroundColor: Colors.white,
                          ),
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                            size: 16,
                          ),
                          label: const Text('Sahkan Penerimaan'),
                          onPressed: () {
                            ref
                                .read(databaseProvider)
                                .updateStockTransferStatus(trf.id, 'received');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Stok berjaya disahkan dan diterima di cawangan destinasi!',
                                ),
                                backgroundColor: AppTheme.successGreen,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showAddOutletDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final codeCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    double priceMultiplier = 1.0;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Tambah Cawangan Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nama Cawangan (e.g. Usaha Coffee KLCC)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: codeCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Kod Cawangan (e.g. MY-KL-04)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: addressCtrl,
                  decoration: const InputDecoration(labelText: 'Alamat Penuh'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombor Telefon',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Pelaras Harga: '),
                    Text(
                      '${(priceMultiplier * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Slider(
                  value: priceMultiplier,
                  min: 0.8,
                  max: 1.5,
                  divisions: 14,
                  label: '${(priceMultiplier * 100).toStringAsFixed(0)}%',
                  onChanged: (v) => setDialogState(() => priceMultiplier = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameCtrl.text.isEmpty || codeCtrl.text.isEmpty) return;
                await ref
                    .read(databaseProvider)
                    .insertOutlet(
                      OutletsCompanion.insert(
                        name: nameCtrl.text.trim(),
                        code: codeCtrl.text.trim(),
                        address: Value(addressCtrl.text.trim()),
                        phone: Value(phoneCtrl.text.trim()),
                        priceMultiplier: Value(priceMultiplier),
                      ),
                    );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRequestTransferDialog(BuildContext context) {
    final outlets = ref.read(allOutletsProvider).value ?? [];
    final ingredients = ref.read(ingredientsProvider).value ?? [];

    if (outlets.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sekurang-kurangnya 2 cawangan diperlukan untuk pemindahan stok',
          ),
        ),
      );
      return;
    }

    int sourceId = outlets[0].id;
    int targetId = outlets[1].id;
    int ingredientId = ingredients.isNotEmpty ? ingredients[0].id : 1;
    final qtyCtrl = TextEditingController(text: '5.0');
    final notesCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Borang Permohonan Pindah Stok'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  value: sourceId,
                  decoration: const InputDecoration(
                    labelText: 'Cawangan Sumber (Asal)',
                  ),
                  items: outlets
                      .map(
                        (o) =>
                            DropdownMenuItem(value: o.id, child: Text(o.name)),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setDialogState(() => sourceId = v ?? sourceId),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: targetId,
                  decoration: const InputDecoration(
                    labelText: 'Cawangan Destinasi (Tujuan)',
                  ),
                  items: outlets
                      .map(
                        (o) =>
                            DropdownMenuItem(value: o.id, child: Text(o.name)),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setDialogState(() => targetId = v ?? targetId),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: ingredientId,
                  decoration: const InputDecoration(labelText: 'Bahan Mentah'),
                  items: ingredients
                      .map(
                        (i) => DropdownMenuItem(
                          value: i.id,
                          child: Text('${i.name} (${i.unit})'),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setDialogState(() => ingredientId = v ?? ingredientId),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: qtyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kuantiti Pemindahan',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: notesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nota / Sebab Pemindahan',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final qty = double.tryParse(qtyCtrl.text) ?? 0.0;
                if (qty <= 0) return;
                final trfNum =
                    'TRF-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

                await ref
                    .read(databaseProvider)
                    .insertStockTransfer(
                      StockTransfersCompanion.insert(
                        transferNumber: trfNum,
                        sourceOutletId: sourceId,
                        targetOutletId: targetId,
                        ingredientId: ingredientId,
                        quantity: qty,
                        status: const Value('in_transit'),
                        requestedBy: const Value('Pengurus Syif'),
                        notes: Value(notesCtrl.text.trim()),
                      ),
                    );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Hantar Permohonan'),
            ),
          ],
        ),
      ),
    );
  }
}
