import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/theme/app_theme.dart';

/// Kiosk Welcome / Splash Screen — "Sentuh untuk Mula"
///
/// This is the idle screen shown to customers when nobody is ordering.
/// It has NO back button and NO navigation drawer/rail.
/// Staff can exit kiosk mode by long-pressing the top-left corner (3 sec).
class KioskModeScreen extends StatefulWidget {
  const KioskModeScreen({super.key});

  @override
  State<KioskModeScreen> createState() => _KioskModeScreenState();
}

class _KioskModeScreenState extends State<KioskModeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _startOrdering() {
    context.go('/kiosk/order');
  }

  void _exitKioskMode() {
    // Show a simple PIN dialog to prevent accidental exit by customers
    showDialog(
      context: context,
      builder: (ctx) {
        final pinController = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Keluar Mod Kiosk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Masukkan PIN staf untuk keluar:'),
              const SizedBox(height: 16),
              TextField(
                controller: pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '****',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                autofocus: true,
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
                // Default PIN: 1234 (can be made configurable later)
                if (pinController.text == '1234') {
                  Navigator.pop(ctx);
                  context.go('/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('PIN salah. Cuba lagi.'),
                      backgroundColor: AppTheme.dangerRed,
                    ),
                  );
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: GestureDetector(
        onTap: _startOrdering,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // ── Background decoration ──
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryCoffee.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryCoffee.withOpacity(0.04),
                ),
              ),
            ),

            // ── Main Content ──
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pulsing touch icon
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      padding: EdgeInsets.all(screenHeight > 800 ? 50 : 36),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryCoffee.withOpacity(0.12),
                            blurRadius: 60,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedTouchInteraction01,
                        color: AppTheme.primaryCoffee,
                        size: screenHeight > 800 ? 120.0 : 80.0,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight > 800 ? 56 : 36),

                  // Title
                  Text(
                    'Sentuh untuk Mula',
                    style: TextStyle(
                      fontSize: screenHeight > 800 ? 40 : 30,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.darkEspresso,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Pesan sendiri, bayar terus & ambil di kaunter.',
                    style: TextStyle(
                      fontSize: screenHeight > 800 ? 18 : 15,
                      color: AppTheme.mutedText,
                    ),
                  ),

                  SizedBox(height: screenHeight > 800 ? 56 : 36),

                  // CTA Button
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: _startOrdering,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryCoffee,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 56,
                            vertical: 22,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                          shadowColor: AppTheme.primaryCoffee.withOpacity(0.4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Mula Pesanan',
                              style: TextStyle(
                                fontSize: screenHeight > 800 ? 24 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.white,
                              size: screenHeight > 800 ? 28.0 : 22.0,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ── Secret admin exit — long press top-left corner ──
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onLongPress: _exitKioskMode,
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.transparent,
                ),
              ),
            ),

            // ── Bottom branding ──
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.successGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Kiosk Layan Diri — Usaha OS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.mutedText.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
