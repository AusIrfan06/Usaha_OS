import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/feature_flags.dart';
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
    super.dispose();
  }

  Future<void> _loadPrefs() async {
    final p = await SharedPreferences.getInstance();
    _nameCtrl.text = p.getString('outlet_name') ?? 'My Cafe';
    _addressCtrl.text = p.getString('outlet_address') ?? '';
    _phoneCtrl.text = p.getString('outlet_phone') ?? '';
    _ssmCtrl.text = p.getString('outlet_ssm') ?? '';
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('outlet_name', _nameCtrl.text.trim());
    await p.setString('outlet_address', _addressCtrl.text.trim());
    await p.setString('outlet_phone', _phoneCtrl.text.trim());
    await p.setString('outlet_ssm', _ssmCtrl.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Settings saved!'),
            backgroundColor: AppTheme.successGreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    final syncService = ref.watch(syncServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Outlet Info ───────────────────────────────────────────
          _sectionHeader('Outlet Information', Icons.store_outlined),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                _settingsField(
                  controller: _nameCtrl,
                  label: 'Outlet Name',
                  hint: 'e.g. PJ Damansara Kopitiam',
                  icon: Icons.storefront_outlined,
                ),
                _divider(),
                _settingsField(
                  controller: _addressCtrl,
                  label: 'Address',
                  hint: 'e.g. No. 12, Jalan SS2/64, Petaling Jaya',
                  icon: Icons.location_on_outlined,
                ),
                _divider(),
                _settingsField(
                  controller: _phoneCtrl,
                  label: 'Phone',
                  hint: 'e.g. 03-XXXX XXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _divider(),
                _settingsField(
                  controller: _ssmCtrl,
                  label: 'SSM / Business Registration No.',
                  hint: 'e.g. 202301234567',
                  icon: Icons.badge_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Compliance (dormant) ──────────────────────────────────
          _sectionHeader('Compliance (Dormant)', Icons.gavel_outlined),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                _toggleTile(
                  title: 'SST (Service & Sales Tax)',
                  subtitle:
                      'Enable when annual F&B revenue exceeds RM1.5M',
                  value: FeatureFlags.sstEnabled,
                  enabled: false,
                  badge: 'DORMANT',
                ),
                _divider(),
                _toggleTile(
                  title: 'LHDN e-Invoice (MyInvois)',
                  subtitle: 'Enable when annual turnover exceeds RM1M',
                  value: FeatureFlags.eInvoiceEnabled,
                  enabled: false,
                  badge: 'DORMANT',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Cloud & Sync ──────────────────────────────────────────
          _sectionHeader('Cloud & Sync', Icons.sync_outlined),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.cloud_done_outlined,
                          size: 22,
                          color: AppTheme.successGreen),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text('Supabase 2-Way Sync',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: AppTheme.darkEspresso)),
                            ValueListenableBuilder<bool>(
                              valueListenable: syncService.isRealtimeConnected,
                              builder: (context, connected, _) {
                                return ValueListenableBuilder<DateTime?>(
                                  valueListenable: syncService.lastSyncedAt,
                                  builder: (context, lastSync, _) {
                                    if (!SupabaseConfig.isConfigured) {
                                      return const Text(
                                        '⚠️ Not configured — edit lib/core/constants/supabase_config.dart',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.mutedText),
                                      );
                                    }
                                    final syncTimeStr = lastSync != null
                                        ? ' • Last synced: ${lastSync.hour.toString().padLeft(2, '0')}:${lastSync.minute.toString().padLeft(2, '0')}:${lastSync.second.toString().padLeft(2, '0')}'
                                        : '';
                                    return Text(
                                      connected
                                          ? '🟢 Realtime Active$syncTimeStr'
                                          : '🟡 Connecting to Supabase…$syncTimeStr',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: connected
                                            ? AppTheme.successGreen
                                            : AppTheme.warningAmber,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            onPressed: isSyncing
                                ? null
                                : () async {
                                    await syncService.pullAllFromSupabase();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('✅ Data successfully synced with Supabase!'),
                                          backgroundColor: AppTheme.primaryCoffee,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                            icon: isSyncing
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppTheme.primaryCoffee,
                                    ),
                                  )
                                : const Icon(Icons.refresh, size: 16),
                            label: Text(
                              isSyncing ? 'Syncing…' : 'Sync Now',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _divider(),
                _infoTile(
                  title: 'Local Database',
                  subtitle:
                      'Drift / SQLite — offline-first, always available',
                  icon: Icons.storage_outlined,
                  statusColor: AppTheme.successGreen,
                  statusLabel: 'Online',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── App Info ──────────────────────────────────────────────
          _sectionHeader('About', Icons.info_outline),
          const SizedBox(height: 12),
          UCard(
            child: Column(
              children: [
                _infoTile(
                  title: AppConstants.appName,
                  subtitle:
                      'Malaysia Cafe POS & Operations Suite v${AppConstants.version}',
                  icon: Icons.coffee_outlined,
                  statusColor: AppTheme.primaryCoffee,
                  statusLabel: '',
                ),
                _divider(),
                _infoTile(
                  title: 'Phase 1 — Core POS',
                  subtitle:
                      'Order-taking • Payment • Stock Tracking • Reports',
                  icon: Icons.check_circle_outline,
                  statusColor: AppTheme.successGreen,
                  statusLabel: 'Active',
                ),
                _divider(),
                _infoTile(
                  title: 'Phase 2 — Coming Soon',
                  subtitle:
                      'KDS • Loyalty • Multi-outlet • Advanced analytics',
                  icon: Icons.schedule_outlined,
                  statusColor: AppTheme.mutedText,
                  statusLabel: 'Planned',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.mutedText),
        const SizedBox(width: 8),
        Text(title.toUpperCase(),
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.mutedText,
                letterSpacing: 1.0)),
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
                Text(label,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.mutedText)),
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
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkEspresso),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleTile({
    required String title,
    required String subtitle,
    required bool value,
    required bool enabled,
    required String badge,
  }) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppTheme.darkEspresso)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.mutedText.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(badge,
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.mutedText,
                              letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.mutedText)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: null, // disabled — dormant
            thumbColor:
                WidgetStateProperty.all(Colors.white),
            trackColor:
                WidgetStateProperty.all(AppTheme.mutedText),
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
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppTheme.darkEspresso)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.mutedText)),
              ],
            ),
          ),
          if (statusLabel.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(statusLabel,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: statusColor)),
            ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, indent: 14, endIndent: 14);
}
