import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../data/database/app_database.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen>
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
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Row(
          children: [
            HugeIcon(icon: HugeIcons.strokeRoundedBank, color: AppColors.primary),
            SizedBox(width: 10),
            Text(
              'Perbelanjaan & Tunai Runcit (Petty Cash)',
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
            Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedFile02), text: 'Log Perbelanjaan'),
            Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedRegister), text: 'Imbangan Laci Tunai (Cash Drawer)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExpensesTab(),
          _buildCashDrawerTab(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 1: Expenses Log
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildExpensesTab() {
    final expensesAsync = ref.watch(allExpensesProvider);
    final totalExpensesAsync = ref.watch(todayTotalExpensesProvider);
    final df = DateFormat('dd MMM yyyy, HH:mm');

    return Column(
      children: [
        // Summary Header Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColors.surfaceDark,
          child: Row(
            children: [
              totalExpensesAsync.when(
                loading: () => const Text('Mengira...', style: TextStyle(color: Colors.white)),
                error: (e, _) => Text('Ralat: $e', style: const TextStyle(color: Colors.red)),
                data: (totalToday) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Jumlah Perbelanjaan Hari Ini:', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    Text(
                      'RM ${totalToday.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                icon: HugeIcon(icon: HugeIcons.strokeRoundedAdd01, size: 18),
                label: const Text('Rekod Perbelanjaan'),
                onPressed: () => _showAddExpenseDialog(context),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.cardDark),

        // List of Expenses
        Expanded(
          child: expensesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            error: (err, _) => Center(child: Text('Ralat: $err', style: const TextStyle(color: Colors.red))),
            data: (expenses) {
              if (expenses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(icon: HugeIcons.strokeRoundedInvoice01, size: 64, color: AppColors.textMuted.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      const Text('Tiada rekod perbelanjaan', style: TextStyle(color: AppColors.textMuted, fontSize: 16)),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => _showAddExpenseDialog(context),
                        icon: HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
                        label: const Text('Rekod Sekarang'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final e = expenses[index];

                  Color catColor = Colors.blue;
                  if (e.category == 'Petty Cash') catColor = Colors.orange;
                  if (e.category == 'Ingredients') catColor = Colors.green;
                  if (e.category == 'Utilities') catColor = Colors.purple;
                  if (e.category == 'Maintenance') catColor = Colors.teal;

                  return Card(
                    color: AppColors.cardDark,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: catColor.withOpacity(0.2),
                        child: HugeIcon(icon: HugeIcons.strokeRoundedMoney01, color: catColor),
                      ),
                      title: Row(
                        children: [
                          Text(
                            e.description.isNotEmpty ? e.description : e.category,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: catColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              e.category,
                              style: TextStyle(color: catColor, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Penerima: ${e.recipient.isNotEmpty ? e.recipient : '-'} • Kaedah: ${e.paymentMethod.toUpperCase()}${e.receiptNumber != null ? ' (No: ${e.receiptNumber})' : ''}',
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                          ),
                          Text(
                            'Direkod oleh: ${e.recordedBy} (${df.format(e.expenseDate)})',
                            style: const TextStyle(color: Colors.white38, fontSize: 11),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '- RM ${e.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: HugeIcon(icon: HugeIcons.strokeRoundedDelete01, color: Colors.white30, size: 20),
                            onPressed: () {
                              ref.read(databaseProvider).deleteExpense(e.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final descCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final recipientCtrl = TextEditingController();
    final receiptCtrl = TextEditingController();
    String category = 'Petty Cash';
    String paymentMethod = 'cash';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppColors.cardDark,
          title: const Text('Rekod Perbelanjaan / Tunai Runcit', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: descCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Keterangan / Tujuan Perbelanjaan *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Jumlah (RM) *',
                      prefixText: 'RM ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: category,
                    dropdownColor: AppColors.surfaceDark,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Kategori Perbelanjaan', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: 'Petty Cash', child: Text('Tunai Runcit (Petty Cash Kecemasan)')),
                      DropdownMenuItem(value: 'Ingredients', child: Text('Bahan Mentah / Ais / Susu')),
                      DropdownMenuItem(value: 'Utilities', child: Text('Utiliti (Elektrik / Air / Internet)')),
                      DropdownMenuItem(value: 'Maintenance', child: Text('Penyelenggaraan & Pembaikan')),
                      DropdownMenuItem(value: 'Staff Wages', child: Text('Gaji Harian / Sambilan')),
                      DropdownMenuItem(value: 'Miscellaneous', child: Text('Lain-lain')),
                    ],
                    onChanged: (v) => setState(() => category = v!),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: paymentMethod,
                    dropdownColor: AppColors.surfaceDark,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Kaedah Bayaran', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: 'cash', child: Text('Tunai dari Laci (Cash Drawer)')),
                      DropdownMenuItem(value: 'duitnow', child: Text('DuitNow QR Kafe')),
                      DropdownMenuItem(value: 'bank_transfer', child: Text('Pindahan Bank Syarikat')),
                    ],
                    onChanged: (v) => setState(() => paymentMethod = v!),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: recipientCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Nama Kedai / Penerima',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: receiptCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'No. Resit / Rujukan Invois',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal', style: TextStyle(color: AppColors.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () async {
                final amount = double.tryParse(amountCtrl.text);
                if (amount == null || amount <= 0 || descCtrl.text.trim().isEmpty) return;

                await ref.read(databaseProvider).insertExpense(
                  ExpensesCompanion.insert(
                    category: drift.Value(category),
                    amount: drift.Value(amount),
                    paymentMethod: drift.Value(paymentMethod),
                    recipient: drift.Value(recipientCtrl.text.trim()),
                    description: drift.Value(descCtrl.text.trim()),
                    receiptNumber: drift.Value(receiptCtrl.text.trim().isNotEmpty ? receiptCtrl.text.trim() : null),
                    recordedBy: const drift.Value('Staf Kafe'),
                  ),
                );

                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Perbelanjaan RM ${amount.toStringAsFixed(2)} berjaya direkodkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Simpan Perbelanjaan', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Tab 2: Cash Drawer Balance & Logs
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildCashDrawerTab() {
    final balanceAsync = ref.watch(todayCashDrawerBalanceProvider);
    final drawerLogsAsync = ref.watch(cashDrawerLogsProvider);
    final df = DateFormat('dd MMM yyyy, HH:mm');

    return Column(
      children: [
        // Cash Balance Card
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary.withOpacity(0.3), AppColors.surfaceDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary,
                child: HugeIcon(icon: HugeIcons.strokeRoundedRegister, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jangkaan Baki Tunai Laci (Drawer Balance)',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                  balanceAsync.when(
                    loading: () => const Text('Mengira...', style: TextStyle(color: Colors.white)),
                    error: (err, _) => Text('Ralat: $err', style: const TextStyle(color: Colors.red)),
                    data: (bal) => Text(
                      'RM ${bal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                icon: HugeIcon(icon: HugeIcons.strokeRoundedSquare),
                label: const Text('Tindakan Tunai (In / Out)'),
                onPressed: () => _showCashActionDialog(context),
              ),
            ],
          ),
        ),

        // Logs
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Log Pergerakan Tunai Laci (Cash In/Out History)',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),

        Expanded(
          child: drawerLogsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            error: (err, _) => Center(child: Text('Ralat: $err', style: const TextStyle(color: Colors.red))),
            data: (logs) {
              if (logs.isEmpty) {
                return const Center(
                  child: Text('Tiada log pergerakan tunai hari ini', style: TextStyle(color: AppColors.textMuted)),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  final isPositive = log.type == 'float_in' || log.type == 'cash_in';

                  return Card(
                    color: AppColors.cardDark,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: HugeIcon(icon: 
                        isPositive ? HugeIcons.strokeRoundedSquare : HugeIcons.strokeRoundedSquare,
                        color: isPositive ? Colors.green : Colors.orange,
                      ),
                      title: Text(
                        log.reason.isNotEmpty ? log.reason : log.type.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Oleh: ${log.recordedBy} • ${df.format(log.createdAt)}',
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                      ),
                      trailing: Text(
                        '${isPositive ? '+' : '-'} RM ${log.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isPositive ? Colors.greenAccent : Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showCashActionDialog(BuildContext context) {
    final amountCtrl = TextEditingController();
    final reasonCtrl = TextEditingController();
    String type = 'cash_out';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppColors.cardDark,
          title: const Text('Pergerakan Tunai Laci (Cash Drawer)', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: type,
                dropdownColor: AppColors.surfaceDark,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Jenis Tindakan', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'float_in', child: Text('Float In (Tambah Apungan Pagi)')),
                  DropdownMenuItem(value: 'cash_in', child: Text('Cash In (Kemasukan Tunai Tambahan)')),
                  DropdownMenuItem(value: 'cash_out', child: Text('Cash Out (Pengeluaran Tunai Runcit)')),
                  DropdownMenuItem(value: 'drop', child: Text('Cash Drop / Simpan ke Peti Besi')),
                ],
                onChanged: (v) => setState(() => type = v!),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Jumlah (RM)',
                  prefixText: 'RM ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: reasonCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Sebab / Catatan',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal', style: TextStyle(color: AppColors.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () async {
                final amount = double.tryParse(amountCtrl.text);
                if (amount == null || amount <= 0) return;

                await ref.read(databaseProvider).insertCashDrawerLog(
                  CashDrawerLogsCompanion.insert(
                    type: type,
                    amount: drift.Value(amount),
                    reason: drift.Value(reasonCtrl.text.trim()),
                    recordedBy: const drift.Value('Staf Kafe'),
                  ),
                );

                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Log tunai RM ${amount.toStringAsFixed(2)} direkodkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Sahkan', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
