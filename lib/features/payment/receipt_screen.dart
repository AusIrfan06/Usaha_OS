import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';

class ReceiptScreen extends ConsumerStatefulWidget {
  final int orderId;
  const ReceiptScreen({super.key, required this.orderId});

  @override
  ConsumerState<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends ConsumerState<ReceiptScreen> {
  Order? _order;
  List<OrderItem> _items = [];
  String _outletName = 'My Cafe';
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    _order = await db.getOrder(widget.orderId);
    _items = await db.getOrderItems(widget.orderId);

    final prefs = await SharedPreferences.getInstance();
    _outletName = prefs.getString('outlet_name') ?? 'My Cafe';

    if (mounted) setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0EBE3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0EBE3),
        title: const Text('Receipt'),
        leading: IconButton(
          icon: HugeIcon(icon: HugeIcons.strokeRoundedCancel01),
          onPressed: () => context.go('/pos'),
        ),
        actions: [
          IconButton(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedShare01),
            tooltip: 'Share',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share coming in Phase 2')),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedPrinter),
              tooltip: 'Print',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Printer integration coming in Phase 2'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _receiptCard(context),
              ),
            ),
          ),
          // Bottom Actions
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/orders'),
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedInvoice01,
                        size: 18,
                      ),
                      label: const Text('All Orders'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => context.go('/pos'),
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedAdd01,
                        size: 18,
                      ),
                      label: const Text('New Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _receiptCard(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final dateStr = DateFormat('dd/MM/yyyy').format(_order!.createdAt);
    final timeStr = DateFormat('HH:mm').format(_order!.createdAt);
    final payLabel = switch (_order!.paymentMethod) {
      'cash' => 'Cash',
      'duitnow_qr' => 'DuitNow QR',
      'card' => 'Card',
      _ => _order!.paymentMethod ?? '—',
    };

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top tear edge
          _TearEdge(top: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Header
                HugeIcon(
                  icon: HugeIcons.strokeRoundedCoffee01,
                  color: AppTheme.primaryCoffee,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'USAHA OS',
                  style: tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    color: AppTheme.darkEspresso,
                  ),
                ),
                Text(
                  _outletName,
                  style: tt.bodyMedium?.copyWith(color: AppTheme.darkEspresso),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Thank you for visiting! ❤️',
                  style: TextStyle(fontSize: 12, color: AppTheme.mutedText),
                ),

                _dottedDivider(),

                // Order info
                _receiptRow('Order', _order!.orderNumber),
                _receiptRow('Date', '$dateStr $timeStr'),
                _receiptRow('Type', switch (_order!.orderType) {
                  'dine_in' => 'Dine-in',
                  'delivery' => 'Delivery',
                  _ => 'Takeaway',
                }),

                _dottedDivider(),

                // Items
                ..._items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.quantity}×',
                          style: const TextStyle(
                            color: AppTheme.primaryCoffee,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item.itemName,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.darkEspresso,
                            ),
                          ),
                        ),
                        Text(
                          CurrencyFormatter.format(item.subtotal),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkEspresso,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _dottedDivider(),

                // Totals
                _receiptRow(
                  'Subtotal',
                  CurrencyFormatter.format(_order!.subtotal),
                ),
                _receiptRow(
                  _order!.taxAmount > 0 ? 'SST (6%)' : 'SST (0%)',
                  CurrencyFormatter.format(_order!.taxAmount),
                  small: true,
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'TOTAL',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      CurrencyFormatter.format(_order!.totalAmount),
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: AppTheme.primaryCoffee,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                _dottedDivider(),

                // Payment
                _receiptRow('Payment', payLabel),
                if (_order!.paymentMethod == 'cash') ...[
                  _receiptRow(
                    'Cash',
                    CurrencyFormatter.format(_order!.tenderedAmount ?? 0),
                  ),
                  _receiptRow(
                    'Change',
                    CurrencyFormatter.format(
                      (_order!.tenderedAmount ?? 0) - _order!.totalAmount,
                    ),
                  ),
                ],

                _dottedDivider(),

                const SizedBox(height: 4),
                Text(
                  'Usaha OS v1.0 • Powered by Flutter',
                  style: TextStyle(fontSize: 10, color: AppTheme.mutedText),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Bottom tear edge
          _TearEdge(top: false),
        ],
      ),
    );
  }

  Widget _receiptRow(String label, String value, {bool small = false}) {
    final style = TextStyle(
      fontSize: small ? 11 : 13,
      color: small ? AppTheme.mutedText : AppTheme.darkEspresso,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: style),
          const Spacer(),
          Text(value, style: style.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _dottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: List.generate(
          30,
          (i) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              height: 1,
              color: i.isEven
                  ? AppTheme.mutedText.withOpacity(0.3)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

class _TearEdge extends StatelessWidget {
  final bool top;
  const _TearEdge({required this.top});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 12),
      painter: _TearEdgePainter(top: top),
    );
  }
}

class _TearEdgePainter extends CustomPainter {
  final bool top;
  const _TearEdgePainter({required this.top});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF0EBE3)
      ..style = PaintingStyle.fill;
    const r = 8.0;
    final count = (size.width / (r * 2)).floor();
    for (int i = 0; i < count; i++) {
      final cx = r + i * r * 2;
      final cy = top ? 0.0 : size.height;
      canvas.drawCircle(Offset(cx, cy), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
