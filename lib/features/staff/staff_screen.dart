import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pinController.dispose();
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
              child: const Icon(Icons.badge_rounded,
                  color: AppTheme.primaryCoffee, size: 22),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Staf & Kehadiran Syif',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Rekod Clock-In/Out PIN & Pengurusan Pekerja',
                  style: TextStyle(fontSize: 11, color: AppTheme.mutedText),
                ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.access_time_rounded, size: 18), text: 'Kehadiran Hari Ini (Live Shift)'),
            Tab(icon: Icon(Icons.people_alt_rounded, size: 18), text: 'Senarai Staf (Directory)'),
          ],
        ),
        actions: [
          FilledButton.icon(
            icon: const Icon(Icons.punch_clock_rounded, size: 18),
            label: const Text('Clock In / Out PIN'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryCoffee,
            ),
            onPressed: () => _showPinModal(context, db),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.person_add_rounded, size: 18),
            label: const Text('Tambah Staf'),
            onPressed: () => _showAddStaffDialog(context, db),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TodayAttendanceView(db: db),
          _StaffDirectoryView(db: db, onEdit: (s) => _showEditStaffDialog(context, db, s)),
        ],
      ),
    );
  }

  void _showPinModal(BuildContext context, AppDatabase db) {
    _pinController.clear();
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Column(
              children: [
                Icon(Icons.lock_clock_rounded, size: 36, color: AppTheme.primaryCoffee),
                SizedBox(height: 8),
                Text('Clock-In / Clock-Out PIN', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                Text('Masukkan 4-digit PIN staf anda', style: TextStyle(fontSize: 12, color: AppTheme.mutedText)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 16),
                  decoration: const InputDecoration(
                    hintText: '••••',
                    counterText: '',
                  ),
                  onChanged: (val) {
                    if (val.length == 4) {
                      _processPin(ctx, db, val);
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'PIN Contoh: Amirul (8888), Sarah (1111), Haziq (2222), Ramli (3333)',
                  style: TextStyle(fontSize: 11, color: AppTheme.mutedText),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () {
                  if (_pinController.text.length == 4) {
                    _processPin(ctx, db, _pinController.text);
                  }
                },
                child: const Text('Sahkan PIN'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _processPin(BuildContext ctx, AppDatabase db, String pin) async {
    final staff = await db.verifyStaffPin(pin);
    if (staff == null) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text('❌ PIN tidak sah! Sila semak semula PIN anda.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final activeAtt = await db.getActiveAttendance(staff.id);
    if (activeAtt != null) {
      // Clock Out
      await db.clockOutStaff(activeAtt.id);
      if (ctx.mounted) {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text('👋 Selamat pulang, ${staff.name}! Anda telah Clock-Out.'),
            backgroundColor: const Color(0xFF1565C0),
          ),
        );
      }
    } else {
      // Clock In
      await db.clockInStaff(staff.id, staff.name);
      if (ctx.mounted) {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text('✅ Selamat bertugas, ${staff.name}! Clock-In berjaya.'),
            backgroundColor: AppTheme.successGreen,
          ),
        );
      }
    }
  }

  void _showAddStaffDialog(BuildContext context, AppDatabase db) {
    final nameCtrl = TextEditingController();
    final pinCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final rateCtrl = TextEditingController(text: '10.00');
    String role = 'Cashier';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.person_add_alt_1_rounded, color: AppTheme.primaryCoffee),
                SizedBox(width: 8),
                Text('Tambah Staf Baru'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Nama Penuh Staf *', hintText: 'Cth: Nur Aina'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: role,
                    decoration: const InputDecoration(labelText: 'Jawatan / Peranan *'),
                    items: const [
                      DropdownMenuItem(value: 'Shift Manager', child: Text('Shift Manager (Pengurus Syif)')),
                      DropdownMenuItem(value: 'Barista', child: Text('Barista (Pembuat Minuman)')),
                      DropdownMenuItem(value: 'Cashier', child: Text('Cashier (Juruwang)')),
                      DropdownMenuItem(value: 'Kitchen Staff', child: Text('Kitchen Staff (Tukang Masak)')),
                      DropdownMenuItem(value: 'Owner', child: Text('Owner (Pemilik)')),
                    ],
                    onChanged: (val) {
                      if (val != null) setDlgState(() => role = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: pinCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(labelText: '4-Digit PIN Log Masuk *', hintText: 'Cth: 5566'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Nombor Telefon', hintText: 'Cth: 018-9988776'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: rateCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Kadar Gaji Sejam (RM/jam)', prefixText: 'RM '),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
              FilledButton(
                onPressed: () async {
                  if (nameCtrl.text.trim().isEmpty || pinCtrl.text.trim().length != 4) return;
                  await db.insertStaff(
                    StaffMembersCompanion.insert(
                      name: nameCtrl.text.trim(),
                      role: drift.Value(role),
                      pinCode: drift.Value(pinCtrl.text.trim()),
                      phone: drift.Value(phoneCtrl.text.trim().isEmpty ? null : phoneCtrl.text.trim()),
                      hourlyRate: drift.Value(double.tryParse(rateCtrl.text) ?? 10.0),
                      isActive: const drift.Value(true),
                    ),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('Simpan Staf'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditStaffDialog(BuildContext context, AppDatabase db, StaffMember staff) {
    final nameCtrl = TextEditingController(text: staff.name);
    final pinCtrl = TextEditingController(text: staff.pinCode);
    final phoneCtrl = TextEditingController(text: staff.phone ?? '');
    final rateCtrl = TextEditingController(text: staff.hourlyRate.toStringAsFixed(2));
    String role = staff.role;
    bool isActive = staff.isActive;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.badge_rounded, color: AppTheme.primaryCoffee),
                const SizedBox(width: 8),
                Text('Kemas Kini: ${staff.name}'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Nama Penuh Staf'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: role,
                    decoration: const InputDecoration(labelText: 'Jawatan / Peranan'),
                    items: const [
                      DropdownMenuItem(value: 'Shift Manager', child: Text('Shift Manager')),
                      DropdownMenuItem(value: 'Barista', child: Text('Barista')),
                      DropdownMenuItem(value: 'Cashier', child: Text('Cashier')),
                      DropdownMenuItem(value: 'Kitchen Staff', child: Text('Kitchen Staff')),
                      DropdownMenuItem(value: 'Owner', child: Text('Owner')),
                    ],
                    onChanged: (val) {
                      if (val != null) setDlgState(() => role = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: pinCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(labelText: '4-Digit PIN'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Nombor Telefon'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: rateCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Gaji Sejam', prefixText: 'RM '),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Status Aktif'),
                    value: isActive,
                    activeColor: AppTheme.successGreen,
                    onChanged: (val) => setDlgState(() => isActive = val),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await db.deleteStaff(staff.id);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Padam Staf'),
              ),
              FilledButton(
                onPressed: () async {
                  await db.updateStaff(
                    staff.toCompanion(true).copyWith(
                          name: drift.Value(nameCtrl.text.trim()),
                          role: drift.Value(role),
                          pinCode: drift.Value(pinCtrl.text.trim()),
                          phone: drift.Value(phoneCtrl.text.trim().isEmpty ? null : phoneCtrl.text.trim()),
                          hourlyRate: drift.Value(double.tryParse(rateCtrl.text) ?? staff.hourlyRate),
                          isActive: drift.Value(isActive),
                        ),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('Simpan'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Today Attendance Shift Logs View
// ─────────────────────────────────────────────────────────────────────────────

class _TodayAttendanceView extends StatelessWidget {
  final AppDatabase db;

  const _TodayAttendanceView({required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StaffAttendance>>(
      stream: db.watchTodayAttendance(),
      builder: (context, snapshot) {
        final attendances = snapshot.data ?? [];
        if (attendances.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty_rounded, size: 56, color: AppTheme.mutedText),
                SizedBox(height: 12),
                Text(
                  'Belum ada staf yang clock-in hari ini.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.mutedText),
                ),
                SizedBox(height: 6),
                Text(
                  'Gunakan butang "Clock In / Out PIN" di atas.',
                  style: TextStyle(fontSize: 12, color: AppTheme.mutedText),
                ),
              ],
            ),
          );
        }

        final activeOnDuty = attendances.where((a) => a.clockOutTime == null).length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCoffee.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryCoffee.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.work_outline_rounded, color: AppTheme.primaryCoffee),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Staf Sedang Bertugas (On-Duty)', style: TextStyle(fontSize: 12, color: AppTheme.mutedText)),
                            Text(
                              '$activeOnDuty Orang Aktif',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.darkEspresso),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Tarikh: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppTheme.darkEspresso),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Attendance Table / Cards
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: attendances.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final att = attendances[i];
                  final isOnDuty = att.clockOutTime == null;
                  final clockInStr = DateFormat('hh:mm a').format(att.clockInTime);
                  final clockOutStr = att.clockOutTime != null
                      ? DateFormat('hh:mm a').format(att.clockOutTime!)
                      : 'Sedang Bertugas';

                  final durationText = isOnDuty
                      ? '${DateTime.now().difference(att.clockInTime).inHours}j ${DateTime.now().difference(att.clockInTime).inMinutes % 60}m (Live)'
                      : '${att.totalMinutes ~/ 60}j ${att.totalMinutes % 60}m';

                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: isOnDuty ? AppTheme.successGreen : AppTheme.surfaceVariant,
                        child: Icon(
                          isOnDuty ? Icons.person_rounded : Icons.person_outline_rounded,
                          color: isOnDuty ? Colors.white : AppTheme.darkEspresso,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            att.staffName,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isOnDuty ? const Color(0xFFE8F5E9) : const Color(0xFFEDE3D8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isOnDuty ? 'AKTIF' : 'SELESAI',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: isOnDuty ? AppTheme.successGreen : AppTheme.mutedText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Masuk: $clockInStr  •  Keluar: $clockOutStr  •  Tempoh: $durationText',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      trailing: isOnDuty
                          ? OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              ),
                              onPressed: () async {
                                await db.clockOutStaff(att.id);
                              },
                              child: const Text('Clock Out'),
                            )
                          : const Icon(Icons.check_circle_outline, color: AppTheme.successGreen),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// Staff Directory View
// ─────────────────────────────────────────────────────────────────────────────

class _StaffDirectoryView extends StatelessWidget {
  final AppDatabase db;
  final ValueChanged<StaffMember> onEdit;

  const _StaffDirectoryView({required this.db, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StaffMember>>(
      stream: db.watchAllStaff(),
      builder: (context, snapshot) {
        final staffList = snapshot.data ?? [];
        if (staffList.isEmpty) {
          return const Center(child: Text('Tiada senarai staf.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: staffList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final s = staffList[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryCoffee.withOpacity(0.15),
                  child: const Icon(Icons.badge_outlined, color: AppTheme.primaryCoffee),
                ),
                title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                subtitle: Text(
                  'Peranan: ${s.role}  •  Gaji: RM ${s.hourlyRate.toStringAsFixed(2)}/jam  •  PIN: ••••',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_outlined, color: AppTheme.mutedText),
                  onPressed: () => onEdit(s),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
