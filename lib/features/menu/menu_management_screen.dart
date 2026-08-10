import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';

class MenuManagementScreen extends ConsumerWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItemsAsync = ref.watch(allMenuItemsWithAvailabilityProvider);
    final db = ref.read(databaseProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EB),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryCoffee.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMenuSquare,
                color: AppTheme.primaryCoffee,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Urus Menu (Menu Management)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Tetapkan status "HABIS" untuk item menu',
                  style: TextStyle(fontSize: 11, color: AppTheme.mutedText),
                ),
              ],
            ),
          ],
        ),
      ),
      body: menuItemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Tiada menu dijumpai.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final item = items[i];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A3E2004),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  subtitle: Text(
                    CurrencyFormatter.format(item.basePrice),
                    style: const TextStyle(
                      color: AppTheme.primaryCoffee,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Switch(
                    value: item.isAvailable,
                    activeColor: AppTheme.successGreen,
                    onChanged: (val) async {
                      await db.toggleMenuItemAvailability(item.id, val);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
