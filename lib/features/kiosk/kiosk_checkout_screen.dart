import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';

/// Kiosk Checkout Screen — shown after the customer taps "Teruskan ke Pembayaran".
///
/// Displays order summary and payment options:
/// - QR Pay (DuitNow, Touch n Go, etc.)
/// - Bayar di Kaunter (Cash — prints a queue ticket)
///
/// After "payment", the screen shows a success animation and returns to the kiosk welcome.
class KioskCheckoutScreen extends ConsumerStatefulWidget {
  final int orderId;

  const KioskCheckoutScreen({super.key, required this.orderId});

  @override
  ConsumerState<KioskCheckoutScreen> createState() =>
      _KioskCheckoutScreenState();
}

class _KioskCheckoutScreenState extends ConsumerState<KioskCheckoutScreen> {
  bool _isProcessing = false;
  bool _isComplete = false;
  String _selectedMethod = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (_isComplete) {
      return _buildSuccessScreen(context, screenHeight);
    }

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: _isProcessing
                        ? null
                        : () => context.go('/kiosk/order'),
                    icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft01,
                      color: AppTheme.mutedText,
                      size: 20,
                    ),
                    label: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: AppTheme.mutedText,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Pembayaran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.darkEspresso,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 80), // Balance
                ],
              ),
            ),

            // ── Main Content ──
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Order info card
                        _buildOrderInfoCard(),

                        const SizedBox(height: 32),

                        // Payment method title
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pilih Cara Bayar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.darkEspresso,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Payment options
                        _buildPaymentOption(
                          icon: HugeIcons.strokeRoundedQrCode,
                          label: 'QR Pay',
                          subtitle: 'DuitNow, Touch n Go, Boost, GrabPay',
                          color: AppTheme.duitNowBlue,
                          method: 'qr',
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentOption(
                          icon: HugeIcons.strokeRoundedBank,
                          label: 'Bayar di Kaunter',
                          subtitle:
                              'Ambil nombor giliran & bayar tunai di kaunter',
                          color: AppTheme.successGreen,
                          method: 'cash',
                        ),

                        const SizedBox(height: 32),

                        // Confirm button
                        if (_selectedMethod.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton(
                              onPressed: _isProcessing ? null : _processPayment,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.primaryCoffee,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _isProcessing
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      _selectedMethod == 'qr'
                                          ? 'Sahkan & Bayar'
                                          : 'Sahkan & Cetak Nombor',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryCoffee.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedInvoice01,
              color: AppTheme.primaryCoffee,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pesanan Anda',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.mutedText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pesanan #${widget.orderId}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkEspresso,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required dynamic icon,
    required String label,
    required String subtitle,
    required Color color,
    required String method,
  }) {
    final isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFEDE3D8),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: HugeIcon(icon: icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? color : AppTheme.darkEspresso,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.mutedText.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    // Clear cart after order is placed
    ref.read(cartProvider.notifier).clear();

    setState(() {
      _isProcessing = false;
      _isComplete = true;
    });

    // Auto-return to welcome screen after 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        context.go('/kiosk');
      }
    });
  }

  Widget _buildSuccessScreen(BuildContext context, double screenHeight) {
    final isQR = _selectedMethod == 'qr';

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success animation circle
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: EdgeInsets.all(screenHeight > 800 ? 48.0 : 36.0),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(screenHeight > 800 ? 36.0 : 28.0),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                        color: AppTheme.successGreen,
                        size: screenHeight > 800 ? 80.0 : 60.0,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),

            // Success message
            Text(
              isQR ? 'Pembayaran Berjaya!' : 'Pesanan Diterima!',
              style: TextStyle(
                fontSize: screenHeight > 800 ? 36 : 28,
                fontWeight: FontWeight.w900,
                color: AppTheme.darkEspresso,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              isQR
                  ? 'Terima kasih! Pesanan anda sedang disediakan.'
                  : 'Sila bayar di kaunter dan tunjukkan nombor pesanan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight > 800 ? 18 : 15,
                color: AppTheme.mutedText,
              ),
            ),
            const SizedBox(height: 32),

            // Order number badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Nombor Pesanan',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '#${widget.orderId}',
                    style: TextStyle(
                      fontSize: screenHeight > 800 ? 48 : 36,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primaryCoffee,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Auto redirect notice
            Text(
              'Skrin ini akan kembali secara automatik...',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.mutedText.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
