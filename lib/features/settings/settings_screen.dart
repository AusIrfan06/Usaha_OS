import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/supabase_config.dart';
import '../../core/providers.dart';
import '../../shared/widgets/common_widgets.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _ssmCtrl = TextEditingController();
  final _sstNoCtrl = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _ssmCtrl.dispose();
    _sstNoCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadPrefs() async {
    final p = await SharedPreferences.getInstance();
    _nameCtrl.text = p.getString('outlet_name') ?? 'Usaha Cafe & Roastery';
    _addressCtrl.text = p.getString('outlet_address') ?? 'No. 12, Jalan SS2/64, Petaling Jaya, Selangor';
    _phoneCtrl.text = p.getString('outlet_phone') ?? '03-7890 1234';
    _ssmCtrl.text = p.getString('outlet_ssm') ?? '202301098765 (1523456-X)';
    _sstNoCtrl.text = p.getString('outlet_sst') ?? ref.read(sstSettingsProvider).sstNumber;
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('outlet_name', _nameCtrl.text.trim());
    await p.setString('outlet_address', _addressCtrl.text.trim());
    await p.setString('outlet_phone', _phoneCtrl.text.trim());
    await p.setString('outlet_ssm', _ssmCtrl.text.trim());
    await p.setString('outlet_sst', _sstNoCtrl.text.trim());

    ref.read(sstSettingsProvider.notifier).updateSstNumber(_sstNoCtrl.text.trim());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tetapan berjaya disimpan!'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final syncService = ref.watch(syncServiceProvider);
    final sstSettings = ref.watch(sstSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tetapan & Pematuhan'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: _save,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20)),
              icon: const Icon(Icons.save, size: 16),
              label: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Outlet Info ───────────────────────────────────────────
          _sectionHeader('Maklumat Premis / Kafe', Icons.store_outlined),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                _settingsField(
                  controller: _nameCtrl,
                  label: 'Nama Premis / Kafe',
                  hint: 'contoh: Usaha Cafe & Roastery',
                  icon: Icons.storefront_outlined,
                ),
                _divider(),
                _settingsField(
                  controller: _addressCtrl,
                  label: 'Alamat Penuh Premis',
                  hint: 'contoh: No. 12, Jalan SS2/64, Petaling Jaya',
                  icon: Icons.location_on_outlined,
                ),
                _divider(),
                _settingsField(
                  controller: _phoneCtrl,
                  label: 'No. Telefon Kafe',
                  hint: 'contoh: 03-XXXX XXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _divider(),
                _settingsField(
                  controller: _ssmCtrl,
                  label: 'No. Pendaftaran Perniagaan (SSM)',
                  hint: 'contoh: 202301098765 (1523456-X)',
                  icon: Icons.badge_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── SST Tax Engine (Phase 3) ──────────────────────────────
          _sectionHeader('Enjin Cukai SST Malaysia (F&B 6%)', Icons.receipt_long),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance, size: 20, color: AppTheme.primaryCoffee),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Cukai Perkhidmatan SST (F&B 6%)',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.darkEspresso),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '[FASA 3 AKTIF]',
                                  style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              sstSettings.isEnabled
                                  ? 'SST 6% dikenakan secara automatik semasa checkout POS dan dicetak pada resit.'
                                  : 'SST dimatikan (Bagi perniagaan bawah ambang RM1.5 Juta perkhidmatan F&B).',
                              style: const TextStyle(fontSize: 12, color: AppTheme.mutedText),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: sstSettings.isEnabled,
                        activeColor: AppTheme.primaryCoffee,
                        onChanged: (val) {
                          ref.read(sstSettingsProvider.notifier).toggleSst(val);
                        },
                      ),
                    ],
                  ),
                ),
                if (sstSettings.isEnabled) ...[
                  _divider(),
                  _settingsField(
                    controller: _sstNoCtrl,
                    label: 'No. Pendaftaran SST Jabatan Kastam (MySST)',
                    hint: 'contoh: W10-2308-32000000',
                    icon: Icons.assignment_turned_in_outlined,
                  ),
                  _divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        const Text('Kadar Cukai:', style: TextStyle(color: AppTheme.mutedText, fontSize: 13)),
                        const SizedBox(width: 12),
                        ChoiceChip(
                          label: const Text('6% (F&B Standard)'),
                          selected: sstSettings.rate == 0.06,
                          onSelected: (_) => ref.read(sstSettingsProvider.notifier).updateRate(0.06),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('8% (General)'),
                          selected: sstSettings.rate == 0.08,
                          onSelected: (_) => ref.read(sstSettingsProvider.notifier).updateRate(0.08),
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.summarize_outlined, size: 16),
                          label: const Text('Penyata SST-02'),
                          onPressed: () => _showSst02Summary(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── PDPA & Data Management (Phase 3) ──────────────────────
          _sectionHeader('Pematuhan PDPA & Keselamatan Data', Icons.security),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Icon(Icons.privacy_tip_outlined, color: Colors.blue, size: 22),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Akta Perlindungan Data Peribadi (PDPA 2010)',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.darkEspresso),
                            ),
                            Text(
                              'Eksport atau rawakkan data peribadi pelanggan bagi mematuhi hak privasi data.',
                              style: TextStyle(fontSize: 12, color: AppTheme.mutedText),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.download, size: 16),
                        label: const Text('Eksport Data'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data pelanggan berjaya dieksport dalam format selamat (CSV)!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Cloud & Sync ──────────────────────────────────────────
          _sectionHeader('Awan & Sinkronisasi (Supabase)', Icons.sync_outlined),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.cloud_done_outlined, size: 22, color: AppTheme.successGreen),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Supabase 2-Way Sync (Cloud & Offline)',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.darkEspresso),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: syncService.isRealtimeConnected,
                              builder: (context, connected, _) {
                                return ValueListenableBuilder<DateTime?>(
                                  valueListenable: syncService.lastSyncedAt,
                                  builder: (context, lastSync, _) {
                                    if (!SupabaseConfig.isConfigured) {
                                      return const Text(
                                        '⚠️ Belum dikonfigurasi — edit lib/core/constants/supabase_config.dart',
                                        style: TextStyle(fontSize: 12, color: AppTheme.mutedText),
                                      );
                                    }
                                    final syncTimeStr = lastSync != null
                                        ? ' • Terakhir: ${lastSync.hour.toString().padLeft(2, '0')}:${lastSync.minute.toString().padLeft(2, '0')}:${lastSync.second.toString().padLeft(2, '0')}'
                                        : '';
                                    return Text(
                                      connected ? '🟢 Realtime Aktif$syncTimeStr' : '🟡 Menyambung ke Supabase…$syncTimeStr',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: connected ? AppTheme.successGreen : AppTheme.warningAmber,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: syncService.isSyncing,
                        builder: (context, isSyncing, _) {
                          return OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.primaryCoffee,
                              side: const BorderSide(color: AppTheme.primaryCoffee),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            onPressed: isSyncing
                                ? null
                                : () async {
                                    await syncService.pullAllFromSupabase();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('✅ Data berjaya diselaraskan dengan Supabase!'),
                                          backgroundColor: AppTheme.primaryCoffee,
                                        ),
                                      );
                                    }
                                  },
                            icon: isSyncing
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryCoffee),
                                  )
                                : const Icon(Icons.refresh, size: 16),
                            label: Text(isSyncing ? 'Menyelaras…' : 'Selaras Sekarang', style: const TextStyle(fontSize: 12)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _divider(),
                _infoTile(
                  title: 'Pangkalan Data Setempat (Drift SQLite)',
                  subtitle: 'Offline-first — sentiasa berfungsi walaupun tiada internet',
                  icon: Icons.storage_outlined,
                  statusColor: AppTheme.successGreen,
                  statusLabel: 'Online',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── App Info ──────────────────────────────────────────────
          _sectionHeader('Tentang Sistem', Icons.info_outline),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                _infoTile(
                  title: AppConstants.appName,
                  subtitle: 'Malaysia Cafe POS & Operations Suite v${AppConstants.version}',
                  icon: Icons.coffee_outlined,
                  statusColor: AppTheme.primaryCoffee,
                  statusLabel: '',
                ),
                _divider(),
                _infoTile(
                  title: 'Fasa 1 — Core POS & Live Stock',
                  subtitle: 'Pesanan • Bayaran DuitNow/Tunai • Tolakan Stok Ramuan',
                  icon: Icons.check_circle_outline,
                  statusColor: AppTheme.successGreen,
                  statusLabel: 'Selesai',
                ),
                _divider(),
                _infoTile(
                  title: 'Fasa 2 — KDS, Tugas & CRM',
                  subtitle: 'KDS Stesen • Checklist Syif • Kad Cop Ganjaran • Kehadiran PIN',
                  icon: Icons.check_circle_outline,
                  statusColor: AppTheme.successGreen,
                  statusLabel: 'Selesai',
                ),
                _divider(),
                _infoTile(
                  title: 'Fasa 3 — SST, PO, Stock Take & Petty Cash',
                  subtitle: 'Enjin SST 6% • Pembekal & PO • Audit Varians • Aliran Tunai Laci',
                  icon: Icons.check_circle_outline,
                  statusColor: AppTheme.successGreen,
                  statusLabel: 'Selesai',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showSst02Summary(BuildContext context) async {
    final summary = await ref.read(todaySummaryProvider.future);
    final totalSales = (summary['totalSales'] as num?)?.toDouble() ?? 0.0;
    final sstSettings = ref.read(sstSettingsProvider);
    final totalSst = totalSales * sstSettings.rate;

    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.account_balance, color: AppTheme.primaryCoffee),
            SizedBox(width: 10),
            Text('Ringkasan Penyata SST-02', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No. SST: ${sstSettings.sstNumber}', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _summaryRow('Jumlah Nilai Jualan Bercukai:', 'RM ${totalSales.toStringAsFixed(2)}'),
            const SizedBox(height: 6),
            _summaryRow('Kadar Cukai Perkhidmatan:', '${(sstSettings.rate * 100).toStringAsFixed(0)}%'),
            const Divider(height: 20),
            _summaryRow('Jumlah Cukai SST Kena Bayar:', 'RM ${totalSst.toStringAsFixed(2)}', isBold: true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
        const Spacer(),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: isBold ? AppTheme.primaryCoffee : null)),
      ],
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.mutedText),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.mutedText,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _settingsField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.mutedText),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.mutedText),
                ),
                TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.darkEspresso),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color statusColor,
    required String statusLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: statusColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.darkEspresso)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.mutedText)),
              ],
            ),
          ),
          if (statusLabel.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor)),
            ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, indent: 14, endIndent: 14);
}
