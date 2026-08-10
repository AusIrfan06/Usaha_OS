import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
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
              child: HugeIcon(icon: HugeIcons.strokeRoundedCircle,
                  color: AppTheme.primaryCoffee, size: 22),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operasi & Pengurusan Tugasan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Checklist Pembukaan, Penutupan & Serahan Syif',
                  style: TextStyle(fontSize: 11, color: AppTheme.mutedText),
                ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedSun01, size: 18), text: 'Buka Kedai (Opening)'),
            Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedMoon01, size: 18), text: 'Tutup Kedai (Closing)'),
            Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedCircle, size: 18), text: 'Serahan Syif (Handover)'),
            Tab(icon: HugeIcon(icon: HugeIcons.strokeRoundedCircle, size: 18), text: 'Papan Tugasan (All Tasks)'),
          ],
        ),
        actions: [
          FilledButton.icon(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedAdd01, size: 18),
            label: const Text('Tambah Tugasan'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () => _showAddTaskDialog(context, db),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ChecklistTabView(category: 'opening', db: db),
          _ChecklistTabView(category: 'closing', db: db),
          _HandoverNotesTabView(db: db),
          _KanbanTasksTabView(db: db),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, AppDatabase db) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String category = switch (_tabController.index) {
      0 => 'opening',
      1 => 'closing',
      2 => 'handover',
      _ => 'general',
    };
    String priority = 'medium';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Row(
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedAdd01, color: AppTheme.primaryCoffee),
                SizedBox(width: 8),
                Text('Tambah Tugasan Baru'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Tajuk Tugasan / Tindakan *',
                      hintText: 'Cth: Periksa baki ais kiub di bar',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Penerangan / Arahan Tambahan',
                      hintText: 'Cth: Pastikan suhu freezer di bawah -18°C',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Kategori:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildCatChoice('opening', 'Buka Kedai', category, (c) => setDialogState(() => category = c)),
                      _buildCatChoice('closing', 'Tutup Kedai', category, (c) => setDialogState(() => category = c)),
                      _buildCatChoice('handover', 'Serahan Syif', category, (c) => setDialogState(() => category = c)),
                      _buildCatChoice('cleaning', 'Pembersihan', category, (c) => setDialogState(() => category = c)),
                      _buildCatChoice('maintenance', 'Penyelenggaraan', category, (c) => setDialogState(() => category = c)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Keutamaan (Priority):', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildPriorityChoice('low', 'Rendah', Colors.blue, priority, (p) => setDialogState(() => priority = p)),
                      const SizedBox(width: 8),
                      _buildPriorityChoice('medium', 'Sederhana', Colors.orange, priority, (p) => setDialogState(() => priority = p)),
                      const SizedBox(width: 8),
                      _buildPriorityChoice('high', 'Tinggi (Kritikal)', Colors.red, priority, (p) => setDialogState(() => priority = p)),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () async {
                  if (titleCtrl.text.trim().isEmpty) return;
                  await db.insertTask(
                    TasksCompanion.insert(
                      title: titleCtrl.text.trim(),
                      description: drift.Value(descCtrl.text.trim()),
                      category: drift.Value(category),
                      priority: drift.Value(priority),
                      status: const drift.Value('todo'),
                    ),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('Simpan Tugasan'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCatChoice(String val, String label, String current, ValueChanged<String> onSelect) {
    final isSelected = val == current;
    return ChoiceChip(
      selected: isSelected,
      label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppTheme.darkEspresso)),
      selectedColor: AppTheme.primaryCoffee,
      onSelected: (_) => onSelect(val),
    );
  }

  Widget _buildPriorityChoice(String val, String label, Color color, String current, ValueChanged<String> onSelect) {
    final isSelected = val == current;
    return ChoiceChip(
      selected: isSelected,
      label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : color)),
      selectedColor: color,
      onSelected: (_) => onSelect(val),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Checklist Tab View (Opening & Closing)
// ─────────────────────────────────────────────────────────────────────────────

class _ChecklistTabView extends StatelessWidget {
  final String category;
  final AppDatabase db;

  const _ChecklistTabView({required this.category, required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: db.watchTasksByCategory(category),
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? [];
        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(icon: 
                  category == 'opening' ? HugeIcons.strokeRoundedSun01 : HugeIcons.strokeRoundedMoon01,
                  size: 56,
                  color: AppTheme.mutedText,
                ),
                const SizedBox(height: 12),
                Text(
                  'Tiada item checklist untuk ${category == 'opening' ? 'Pembukaan' : 'Penutupan'}.',
                  style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.mutedText),
                ),
              ],
            ),
          );
        }

        final completedCount = tasks.where((t) => t.status == 'completed').length;
        final progress = tasks.isEmpty ? 0.0 : completedCount / tasks.length;
        final isAllDone = completedCount == tasks.length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isAllDone ? const Color(0xFFE8F5E9) : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isAllDone ? AppTheme.successGreen : const Color(0xFFEDE3D8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            HugeIcon(icon: 
                              isAllDone ? HugeIcons.strokeRoundedCircle : HugeIcons.strokeRoundedCircle,
                              color: isAllDone ? AppTheme.successGreen : AppTheme.primaryCoffee,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isAllDone ? 'Semua Checklist Selesai!' : 'Kemajuan Checklist Syif',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isAllDone ? AppTheme.successGreen : AppTheme.darkEspresso,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$completedCount / ${tasks.length} (${(progress * 100).toInt()}%)',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isAllDone ? AppTheme.successGreen : AppTheme.primaryCoffee,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: const Color(0xFFEDE3D8),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isAllDone ? AppTheme.successGreen : AppTheme.primaryCoffee,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Checklist Items
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final task = tasks[i];
                  final isDone = task.status == 'completed';

                  return Card(
                    color: isDone ? const Color(0xFFFAF6F0) : Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isDone ? AppTheme.successGreen.withOpacity(0.3) : const Color(0xFFEDE3D8),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      leading: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: isDone,
                          activeColor: AppTheme.successGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          onChanged: (val) async {
                            final newStatus = (val ?? false) ? 'completed' : 'todo';
                            await db.updateTaskStatus(task.id, newStatus, completedBy: 'Staf Semasa');
                          },
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          decoration: isDone ? TextDecoration.lineThrough : null,
                          color: isDone ? AppTheme.mutedText : AppTheme.darkEspresso,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (task.description.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              task.description,
                              style: TextStyle(fontSize: 12, color: isDone ? AppTheme.mutedText : const Color(0xFF6D4C41)),
                            ),
                          ],
                          if (isDone && task.completedAt != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Diselesaikan pada: ${DateFormat('hh:mm a, dd MMM').format(task.completedAt!)}',
                              style: const TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildPriorityBadge(task.priority),
                          IconButton(
                            icon: HugeIcon(icon: HugeIcons.strokeRoundedDelete01, size: 18, color: Colors.grey),
                            onPressed: () async {
                              await db.deleteTask(task.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color bg;
    Color fg;
    String label;

    switch (priority) {
      case 'high':
        bg = const Color(0xFFFFEBEE);
        fg = Colors.red;
        label = 'Kritikal';
        break;
      case 'low':
        bg = const Color(0xFFE3F2FD);
        fg = Colors.blue;
        label = 'Rendah';
        break;
      default:
        bg = const Color(0xFFFFF3E0);
        fg = Colors.orange;
        label = 'Sederhana';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Handover Notes Tab View
// ─────────────────────────────────────────────────────────────────────────────

class _HandoverNotesTabView extends StatelessWidget {
  final AppDatabase db;

  const _HandoverNotesTabView({required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: db.watchTasksByCategory('handover'),
      builder: (context, snapshot) {
        final notes = snapshot.data ?? [];
        if (notes.isEmpty) {
          return const Center(
            child: Text(
              'Tiada nota serahan syif untuk hari ini.',
              style: TextStyle(color: AppTheme.mutedText),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: notes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final note = notes[i];
            final isAcknowledged = note.status == 'completed';

            return Card(
              color: isAcknowledged ? const Color(0xFFF9F7F4) : Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isAcknowledged ? const Color(0xFFE0D5C7) : AppTheme.primaryCoffee.withOpacity(0.4),
                  width: isAcknowledged ? 1 : 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            HugeIcon(icon: 
                              isAcknowledged ? HugeIcons.strokeRoundedCircle : HugeIcons.strokeRoundedCircle,
                              color: isAcknowledged ? AppTheme.mutedText : AppTheme.primaryCoffee,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              note.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isAcknowledged ? AppTheme.mutedText : AppTheme.darkEspresso,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat('hh:mm a').format(note.createdAt),
                          style: const TextStyle(fontSize: 12, color: AppTheme.mutedText),
                        ),
                      ],
                    ),
                    if (note.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        note.description,
                        style: const TextStyle(fontSize: 14, color: Color(0xFF5C4033)),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isAcknowledged ? '✅ Diterima oleh Syif Masuk' : '⚠️ Menunggu Pengesahan Syif Masuk',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isAcknowledged ? AppTheme.successGreen : const Color(0xFFE65100),
                          ),
                        ),
                        if (!isAcknowledged)
                          FilledButton.icon(
                            icon: HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkBadge01, size: 16),
                            label: const Text('Terima Nota (Acknowledge)'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.primaryCoffee,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            onPressed: () async {
                              await db.updateTaskStatus(note.id, 'completed', completedBy: 'Syif Masuk');
                            },
                          ),
                      ],
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

// ─────────────────────────────────────────────────────────────────────────────
// Kanban Tasks Tab View
// ─────────────────────────────────────────────────────────────────────────────

class _KanbanTasksTabView extends StatelessWidget {
  final AppDatabase db;

  const _KanbanTasksTabView({required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: db.watchAllTasks(),
      builder: (context, snapshot) {
        final allTasks = snapshot.data ?? [];
        final todoTasks = allTasks.where((t) => t.status == 'todo').toList();
        final inProgTasks = allTasks.where((t) => t.status == 'in_progress').toList();
        final doneTasks = allTasks.where((t) => t.status == 'completed').toList();

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildColumn(context, 'Belum Mula (To Do)', todoTasks, const Color(0xFFE65100), 'in_progress', 'Mula')),
                  const VerticalDivider(width: 1),
                  Expanded(child: _buildColumn(context, 'Sedang Berjalan', inProgTasks, const Color(0xFF1565C0), 'completed', 'Siap')),
                  const VerticalDivider(width: 1),
                  Expanded(child: _buildColumn(context, 'Selesai (Done)', doneTasks, AppTheme.successGreen, 'todo', 'Buka Semula')),
                ],
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildColumnHeader('Belum Mula (To Do)', todoTasks.length, const Color(0xFFE65100)),
                ...todoTasks.map((t) => _buildKanbanCard(context, t, 'in_progress', 'Mula')),
                const SizedBox(height: 16),
                _buildColumnHeader('Sedang Berjalan', inProgTasks.length, const Color(0xFF1565C0)),
                ...inProgTasks.map((t) => _buildKanbanCard(context, t, 'completed', 'Siap')),
                const SizedBox(height: 16),
                _buildColumnHeader('Selesai (Done)', doneTasks.length, AppTheme.successGreen),
                ...doneTasks.map((t) => _buildKanbanCard(context, t, 'todo', 'Buka Semula')),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildColumn(BuildContext context, String title, List<Task> items, Color headerColor, String nextStatus, String actionLabel) {
    return Container(
      color: headerColor.withOpacity(0.03),
      child: Column(
        children: [
          _buildColumnHeader(title, items.length, headerColor),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) => _buildKanbanCard(context, items[i], nextStatus, actionLabel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnHeader(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border(bottom: BorderSide(color: color.withOpacity(0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: color)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            child: Text('$count', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanCard(BuildContext context, Task task, String nextStatus, String actionLabel) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFEDE3D8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFF5EDE3), borderRadius: BorderRadius.circular(6)),
                  child: Text(task.category.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.darkEspresso)),
                ),
                IconButton(
                  icon: HugeIcon(icon: HugeIcons.strokeRoundedDelete01, size: 16, color: Colors.grey),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => db.deleteTask(task.id),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(task.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(task.description, style: const TextStyle(fontSize: 12, color: Color(0xFF6D4C41))),
            ],
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, size: 14),
                  label: Text(actionLabel, style: const TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () async {
                    await db.updateTaskStatus(task.id, nextStatus, completedBy: 'Pengguna');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
