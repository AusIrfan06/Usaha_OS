import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/theme/app_theme.dart';

class KioskModeScreen extends StatelessWidget {
  const KioskModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, color: AppTheme.darkEspresso, size: 24),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Kiosk Layan Diri (Self-Order)',
          style: TextStyle(color: AppTheme.darkEspresso, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.successGreen.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkBadge01, color: AppTheme.successGreen, size: 16),
                SizedBox(width: 4),
                Text('Kiosk Aktif', style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppTheme.primaryCoffee.withOpacity(0.1), blurRadius: 40, spreadRadius: 10),
                ],
              ),
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedTouchInteraction01,
                color: AppTheme.primaryCoffee,
                size: 100,
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              'Sentuh untuk Mula',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: AppTheme.darkEspresso,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pesan sendiri, bayar terus & ambil di kaunter.',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.mutedText,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sistem Kiosk akan dibuka (Mockup)')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryCoffee,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Mula Pesanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(width: 12),
                  HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, color: Colors.white, size: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
