import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';

class LoyaltyScreen extends ConsumerStatefulWidget {
  const LoyaltyScreen({super.key});

  @override
  ConsumerState<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends ConsumerState<LoyaltyScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryCoffee.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.card_membership_rounded,
                  color: AppTheme.primaryCoffee, size: 22),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CRM & Program Kesetiaan (Loyalty)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Mata Ganjaran, Kad Cop & Direktori Pelanggan',
                  style: TextStyle(fontSize: 11, color: AppTheme.mutedText),
                ),
              ],
            ),
          ],
        ),
        actions: [
          FilledButton.icon(
            icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
            label: const Text('Daftar Ahli Baru'),
            onPressed: () => _showAddCustomerDialog(context, db),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(bottom: BorderSide(color: Color(0xFFEDE3D8))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Cari nama atau nombor telefon ahli (Cth: 0123456789)...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                    ),
                    onChanged: (val) => setState(() => _searchQuery = val.trim().toLowerCase()),
                  ),
                ),
              ],
            ),
          ),

          // Customers List Stream
          Expanded(
            child: StreamBuilder<List<Customer>>(
              stream: db.watchAllCustomers(),
              builder: (context, snapshot) {
                final allCustomers = snapshot.data ?? [];
                final filtered = allCustomers.where((c) {
                  if (_searchQuery.isEmpty) return true;
                  return c.name.toLowerCase().contains(_searchQuery) ||
                      c.phone.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline_rounded, size: 64, color: AppTheme.mutedText.withOpacity(0.6)),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'Tiada Ahli Didaftarkan Lagi'
                              : 'Tiada ahli dijumpai untuk "$_searchQuery"',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        if (_searchQuery.isEmpty)
                          FilledButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Daftar Ahli Pertama'),
                            onPressed: () => _showAddCustomerDialog(context, db),
                          ),
                      ],
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 850;

                    if (isWide) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, i) => _CustomerLoyaltyCard(
                          customer: filtered[i],
                          db: db,
                          onEdit: () => _showEditCustomerDialog(context, db, filtered[i]),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) => _CustomerLoyaltyCard(
                        customer: filtered[i],
                        db: db,
                        onEdit: () => _showEditCustomerDialog(context, db, filtered[i]),
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
  }

  void _showAddCustomerDialog(BuildContext context, AppDatabase db) {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.person_add_alt_1_rounded, color: AppTheme.primaryCoffee),
            SizedBox(width: 8),
            Text('Daftar Ahli Baru'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama Penuh Pelanggan *', hintText: 'Cth: Ahmad Faizal'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Nombor Telefon *', hintText: 'Cth: 0123456789'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Emel (Pilihan)', hintText: 'Cth: faizal@gmail.com'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty || phoneCtrl.text.trim().isEmpty) return;
              await db.insertCustomer(
                CustomersCompanion.insert(
                  name: nameCtrl.text.trim(),
                  phone: phoneCtrl.text.trim(),
                  email: drift.Value(emailCtrl.text.trim().isEmpty ? null : emailCtrl.text.trim()),
                  tier: const drift.Value('Bronze'),
                  points: const drift.Value(10), // Welcome bonus points!
                  stampsCount: const drift.Value(1), // Welcome stamp!
                ),
              );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Daftar Ahli (+10 Mata Bonus)'),
          ),
        ],
      ),
    );
  }

  void _showEditCustomerDialog(BuildContext context, AppDatabase db, Customer customer) {
    final pointsCtrl = TextEditingController(text: customer.points.toString());
    final stampsCtrl = TextEditingController(text: customer.stampsCount.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.edit_note_rounded, color: AppTheme.primaryCoffee),
            const SizedBox(width: 8),
            Text('Kemas Kini: ${customer.name}'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pointsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Baki Mata Ganjaran', suffixText: 'pts'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stampsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah Cop (Maks 10)', suffixText: 'cop'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await db.deleteCustomer(customer.id);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Padam Ahli'),
          ),
          FilledButton(
            onPressed: () async {
              final newPts = int.tryParse(pointsCtrl.text) ?? customer.points;
              final newStamps = (int.tryParse(stampsCtrl.text) ?? customer.stampsCount).clamp(0, 10);
              await db.updateCustomer(
                customer.toCompanion(true).copyWith(
                      points: drift.Value(newPts),
                      stampsCount: drift.Value(newStamps),
                    ),
              );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Customer Loyalty Card Component
// ─────────────────────────────────────────────────────────────────────────────

class _CustomerLoyaltyCard extends StatelessWidget {
  final Customer customer;
  final AppDatabase db;
  final VoidCallback onEdit;

  const _CustomerLoyaltyCard({
    required this.customer,
    required this.db,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final (tierColor, tierGradient) = switch (customer.tier) {
      'Platinum' => (
          const Color(0xFF37474F),
          const LinearGradient(colors: [Color(0xFF455A64), Color(0xFF263238)])
        ),
      'Gold' => (
          const Color(0xFFFFA000),
          const LinearGradient(colors: [Color(0xFFFFB300), Color(0xFFFF8F00)])
        ),
      'Silver' => (
          const Color(0xFF78909C),
          const LinearGradient(colors: [Color(0xFF90A4AE), Color(0xFF607D8B)])
        ),
      _ => (
          const Color(0xFF8D4E1C),
          const LinearGradient(colors: [Color(0xFFA1887F), Color(0xFF6D4C41)])
        ),
    };

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDE3D8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Header: Name + Tier Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.phone_iphone_rounded, size: 14, color: AppTheme.mutedText),
                        const SizedBox(width: 4),
                        Text(customer.phone, style: const TextStyle(fontSize: 12, color: AppTheme.mutedText)),
                      ],
                    ),
                  ],
                ),
                // Tier Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: tierGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.workspace_premium_rounded, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        customer.tier.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Points & Total Spend Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCoffee.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mata Ganjaran', style: TextStyle(fontSize: 11, color: AppTheme.mutedText)),
                        const SizedBox(height: 2),
                        Text(
                          '${customer.points} pts',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.primaryCoffee),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5EDE3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jumlah Belanja', style: TextStyle(fontSize: 11, color: AppTheme.mutedText)),
                        const SizedBox(height: 2),
                        Text(
                          'RM ${customer.totalSpent.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.darkEspresso),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Stamp Card (10 Stamps -> Free Coffee!)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.local_cafe_rounded, size: 14, color: AppTheme.primaryCoffee),
                        SizedBox(width: 4),
                        Text('Kad Cop Kopi Percuma', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Text(
                      '${customer.stampsCount}/10 Cop',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.primaryCoffee),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Stamp Circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(10, (idx) {
                    final isStamped = idx < customer.stampsCount;
                    final isLast = idx == 9;
                    return Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isStamped
                            ? AppTheme.primaryCoffee
                            : isLast
                                ? const Color(0xFFFFECB3)
                                : const Color(0xFFEDE3D8),
                        border: isLast
                            ? Border.all(color: Colors.amber.shade700, width: 1.5)
                            : null,
                      ),
                      child: Center(
                        child: isStamped
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : isLast
                                ? const Icon(Icons.card_giftcard_rounded, size: 12, color: Color(0xFFE65100))
                                : Text(
                                    '${idx + 1}',
                                    style: const TextStyle(fontSize: 9, color: AppTheme.mutedText, fontWeight: FontWeight.w700),
                                  ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Card Footer & Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (customer.stampsCount >= 10)
                  FilledButton.icon(
                    icon: const Icon(Icons.redeem_rounded, size: 16),
                    label: const Text('Tebus Kopi Percuma!'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.successGreen,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    onPressed: () async {
                      final ok = await db.redeemCustomerStamps(customer.id);
                      if (ok && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🎉 Berjaya menebus 1 Kopi Percuma untuk ahli ini!'),
                            backgroundColor: AppTheme.successGreen,
                          ),
                        );
                      }
                    },
                  )
                else
                  Text(
                    customer.lastVisitedAt != null
                        ? 'Lawatan Terakhir: ${DateFormat('dd/MM/yyyy').format(customer.lastVisitedAt!)}'
                        : 'Ahli Baru',
                    style: const TextStyle(fontSize: 11, color: AppTheme.mutedText),
                  ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined, size: 18, color: AppTheme.mutedText),
                  onPressed: onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
