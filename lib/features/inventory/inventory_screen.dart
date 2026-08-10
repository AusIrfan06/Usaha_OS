import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../../shared/widgets/common_widgets.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() =>
      _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final ingredientsAsync = ref.watch(ingredientsProvider);
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        actions: [
          ingredientsAsync.maybeWhen(
            data: (items) {
              final low =
                  items.where((i) => i.currentStock <= i.reorderPoint);
              if (low.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Chip(
                  backgroundColor:
                      AppTheme.warningAmber.withOpacity(0.12),
                  label: Text('${low.length} low',
                      style: const TextStyle(
                          color: AppTheme.warningAmber,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                  avatar: HugeIcon(icon: HugeIcons.strokeRoundedAlert01,
                      color: AppTheme.warningAmber, size: 14),
                  side: BorderSide.none,
                ),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search ingredients…',
                prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedSearch01, size: 20),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          // List
          Expanded(
            child: ingredientsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Error: $e')),
              data: (items) {
                final filtered = _search.isEmpty
                    ? items
                    : items
                        .where((i) => i.name
                            .toLowerCase()
                            .contains(_search.toLowerCase()))
                        .toList();

                if (filtered.isEmpty) {
                  return const EmptyState(
                    icon: HugeIcons.strokeRoundedPackage,
                    title: 'No ingredients found',
                    subtitle: 'Try a different search term',
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(isTablet ? 24 : 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 10),
                  itemBuilder: (ctx, i) =>
                      _IngredientCard(ingredient: filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientCard extends ConsumerWidget {
  final Ingredient ingredient;
  const _IngredientCard({required this.ingredient});

  Color get _statusColor {
    if (ingredient.currentStock == 0) return AppTheme.dangerRed;
    if (ingredient.currentStock <= ingredient.reorderPoint) {
      return AppTheme.warningAmber;
    }
    return AppTheme.successGreen;
  }

  String get _statusLabel {
    if (ingredient.currentStock == 0) return 'Out of Stock';
    if (ingredient.currentStock <= ingredient.reorderPoint) {
      return 'Low Stock';
    }
    return 'In Stock';
  }

  double get _stockPercent {
    if (ingredient.reorderPoint == 0) return 1.0;
    // Show percentage relative to 3× reorder point as "full"
    final full = ingredient.reorderPoint * 3;
    return (ingredient.currentStock / full).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = Theme.of(context).textTheme;
    final db = ref.read(databaseProvider);

    return UCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ingredient.name,
                        style: tt.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(_statusLabel,
                            style: TextStyle(
                                fontSize: 12,
                                color: _statusColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              // Stock amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${ingredient.currentStock.toStringAsFixed(1)} ${ingredient.unit}',
                    style: tt.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: _statusColor),
                  ),
                  Text(
                    'Reorder at ${ingredient.reorderPoint.toStringAsFixed(0)} ${ingredient.unit}',
                    style: tt.bodySmall
                        ?.copyWith(color: AppTheme.mutedText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Stock gauge
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _stockPercent,
              minHeight: 6,
              backgroundColor: _statusColor.withOpacity(0.12),
              valueColor:
                  AlwaysStoppedAnimation<Color>(_statusColor),
            ),
          ),
          const SizedBox(height: 12),
          // Quick adjust buttons
          Row(
            children: [
              Text('Adjust:',
                  style: tt.bodySmall
                      ?.copyWith(color: AppTheme.mutedText)),
              const Spacer(),
              _adjustButton(
                  icon: HugeIcons.strokeRoundedRemove01,
                  delta: -1,
                  db: db,
                  ingredient: ingredient,
                  ref: ref),
              const SizedBox(width: 8),
              _adjustButton(
                  icon: HugeIcons.strokeRoundedRemove01,
                  label: '-10',
                  delta: -10,
                  db: db,
                  ingredient: ingredient,
                  ref: ref),
              const SizedBox(width: 8),
              _adjustButton(
                  icon: HugeIcons.strokeRoundedAdd01,
                  label: '+10',
                  delta: 10,
                  db: db,
                  ingredient: ingredient,
                  ref: ref),
              const SizedBox(width: 8),
              _adjustButton(
                  icon: HugeIcons.strokeRoundedAdd01,
                  label: '+100',
                  delta: 100,
                  db: db,
                  ingredient: ingredient,
                  ref: ref),
            ],
          ),
        ],
      ),
    );
  }

  Widget _adjustButton({
    required dynamic icon,
    String? label,
    required double delta,
    required db,
    required Ingredient ingredient,
    required WidgetRef ref,
  }) {
    final isNeg = delta < 0;
    return GestureDetector(
      onTap: () async {
        await db.adjustIngredientStock(ingredient.id, delta);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isNeg
              ? AppTheme.dangerRed.withOpacity(0.08)
              : AppTheme.successGreen.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isNeg
                ? AppTheme.dangerRed.withOpacity(0.3)
                : AppTheme.successGreen.withOpacity(0.3),
          ),
        ),
        child: Text(
          label ?? (isNeg ? '-1' : '+1'),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isNeg ? AppTheme.dangerRed : AppTheme.successGreen,
          ),
        ),
      ),
    );
  }
}
