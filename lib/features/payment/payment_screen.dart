import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';
import '../../shared/widgets/common_widgets.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final int orderId;
  const PaymentScreen({super.key, required this.orderId});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _tendered = '';
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Order? _order;
  List<OrderItem> _items = [];

  Future<void> _loadOrder() async {
    if (_order != null) return;
    final db = ref.read(databaseProvider);
    _order = await db.getOrder(widget.orderId);
    _items = await db.getOrderItems(widget.orderId);
    setState(() {});
  }

  double get _tenderedAmount => double.tryParse(_tendered) ?? 0.0;
  double get _change => _tenderedAmount - (_order?.totalAmount ?? 0.0);

  Future<void> _confirmPayment(String method, double tendered) async {
    if (_processing) return;
    setState(() => _processing = true);

    final db = ref.read(databaseProvider);
    final syncService = ref.read(syncServiceProvider);

    await db.completeOrder(
      orderId: widget.orderId,
      paymentMethod: method,
      tendered: tendered,
    );

    // Sync to Supabase (fire-and-forget)
    syncService.syncCompletedOrder(widget.orderId);

    // Clear cart
    ref.read(cartProvider.notifier).clear();

    if (mounted) {
      context.go('/receipt/${widget.orderId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 700;

    return FutureBuilder(
      future: _loadOrder(),
      builder: (context, _) {
        if (_order == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppTheme.warmCream,
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Payment'),
                Text(_order!.orderNumber,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.mutedText)),
              ],
            ),
            leading: IconButton(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
              onPressed: () => context.pop(),
            ),
          ),
          body: isTablet
              ? _tabletLayout()
              : _phoneLayout(),
        );
      },
    );
  }

  Widget _phoneLayout() {
    return Column(
      children: [
        _orderSummaryCard(),
        _tabBar(),
        Expanded(child: _tabContent()),
      ],
    );
  }

  Widget _tabletLayout() {
    return Row(
      children: [
        Expanded(child: _orderSummaryCard()),
        Container(width: 1, color: const Color(0xFFEDE3D8)),
        Expanded(
          child: Column(
            children: [
              _tabBar(),
              Expanded(child: _tabContent()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _orderSummaryCard() {
    final tt = Theme.of(context).textTheme;
    return Container(
      color: AppTheme.cardBg,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              OrderTypeBadge(orderType: _order!.orderType),
              const Spacer(),
              StatusBadge(status: _order!.status),
            ],
          ),
          const SizedBox(height: 16),
          // Items list
          ..._items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Text('${item.quantity}×',
                        style: const TextStyle(
                            color: AppTheme.primaryCoffee,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(item.itemName,
                          style: tt.bodyMedium),
                    ),
                    Text(CurrencyFormatter.format(item.subtotal),
                        style: tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
          const Divider(height: 20),
          Row(
            children: [
              Text('Subtotal',
                  style:
                      tt.bodyMedium?.copyWith(color: AppTheme.mutedText)),
              const Spacer(),
              Text(CurrencyFormatter.format(_order!.subtotal),
                  style: tt.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('SST',
                  style:
                      tt.bodyMedium?.copyWith(color: AppTheme.mutedText)),
              const SizedBox(width: 6),
              const Text('OFF',
                  style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.mutedText,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('RM 0.00',
                  style:
                      tt.bodyMedium?.copyWith(color: AppTheme.mutedText)),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              Text('Total',
                  style: tt.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const Spacer(),
              Text(
                CurrencyFormatter.format(_order!.totalAmount),
                style: tt.titleLarge?.copyWith(
                    color: AppTheme.primaryCoffee,
                    fontWeight: FontWeight.w800,
                    fontSize: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      color: AppTheme.cardBg,
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedMoney01, size: 18),
            text: 'Cash',
          ),
          Tab(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedCircle, size: 18),
            text: 'DuitNow QR',
          ),
          Tab(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedCreditCard, size: 18),
            text: 'Card',
          ),
        ],
      ),
    );
  }

  Widget _tabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _cashTab(),
        _duitNowTab(),
        _cardTab(),
      ],
    );
  }

  // ── Cash Tab ───────────────────────────────────────────────────────────────

  Widget _cashTab() {
    final tt = Theme.of(context).textTheme;
    final due = _order!.totalAmount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Amount due
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text('Amount Due',
                    style: TextStyle(
                        fontSize: 14, color: AppTheme.mutedText)),
                const SizedBox(height: 4),
                Text(CurrencyFormatter.format(due),
                    style: tt.headlineLarge?.copyWith(
                        color: AppTheme.primaryCoffee,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Tendered display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEDE3D8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cash Tendered',
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.mutedText)),
                const SizedBox(height: 4),
                Text(
                  _tendered.isEmpty
                      ? '0.00'
                      : 'RM $_tendered',
                  style: tt.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (_tenderedAmount >= due) ...[
                  const Divider(height: 20),
                  Row(
                    children: [
                      const Text('Change',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.successGreen,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text(
                        CurrencyFormatter.format(_change),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.successGreen),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Quick amount buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [due, 10, 20, 50, 100, 200]
                .where((v) => v >= due || v == due)
                .take(4)
                .map((amt) => OutlinedButton(
                      onPressed: () =>
                          setState(() => _tendered = amt.toStringAsFixed(2)),
                      child: Text(
                          amt == due
                              ? 'Exact'
                              : 'RM ${amt.toInt()}',
                          style: const TextStyle(fontSize: 13)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          // Numpad
          _numpad(),
          const SizedBox(height: 20),
          // Confirm
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: (_tenderedAmount >= due && !_processing)
                  ? () => _confirmPayment(
                      AppConstants.cash, _tenderedAmount)
                  : null,
              icon: _processing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white))
                  : HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkBadge01),
              label: Text(
                _processing
                    ? 'Processing…'
                    : 'Confirm Cash Payment',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numpad() {
    final keys = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '.', '0', '⌫',
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.0,
      children: keys.map((k) => _numpadKey(k)).toList(),
    );
  }

  Widget _numpadKey(String key) {
    final isBackspace = key == '⌫';
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() {
          if (isBackspace) {
            if (_tendered.isNotEmpty) {
              _tendered = _tendered.substring(0, _tendered.length - 1);
            }
          } else if (key == '.') {
            if (!_tendered.contains('.')) {
              _tendered += _tendered.isEmpty ? '0.' : '.';
            }
          } else {
            // Prevent more than 2 decimal places
            if (_tendered.contains('.')) {
              final parts = _tendered.split('.');
              if (parts[1].length >= 2) return;
            }
            _tendered += key;
          }
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isBackspace
              ? AppTheme.dangerRed.withOpacity(0.08)
              : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isBackspace
              ? HugeIcon(icon: HugeIcons.strokeRoundedCircle,
                  color: AppTheme.dangerRed, size: 20)
              : Text(key,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkEspresso)),
        ),
      ),
    );
  }

  // ── DuitNow QR Tab ─────────────────────────────────────────────────────────

  Widget _duitNowTab() {
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // QR placeholder
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.duitNowBlue.withOpacity(0.3),
                  width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.duitNowBlue.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.duitNowBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: HugeIcon(icon: HugeIcons.strokeRoundedCircle,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(height: 12),
                Text('DuitNow QR',
                    style: tt.titleMedium?.copyWith(
                        color: AppTheme.duitNowBlue,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                const Text(
                  'Configure your DuitNow merchant QR in Settings to display here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.mutedText),
                ),
                const SizedBox(height: 16),
                // QR code placeholder grid
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: HugeIcon(icon: HugeIcons.strokeRoundedQrCode01,
                      size: 120, color: Color(0xFF003399)),
                ),
                const SizedBox(height: 16),
                Text(
                  CurrencyFormatter.format(_order!.totalAmount),
                  style: tt.headlineMedium?.copyWith(
                      color: AppTheme.duitNowBlue,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.duitNowBlue,
              ),
              onPressed: _processing
                  ? null
                  : () => _confirmPayment(
                      AppConstants.duitNowQr, _order!.totalAmount),
              icon: _processing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkBadge01),
              label: Text(
                _processing ? 'Processing…' : 'Mark as Paid',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Card Tab ───────────────────────────────────────────────────────────────

  Widget _cardTab() {
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEDE3D8)),
            ),
            child: Column(
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedCreditCard,
                    size: 48, color: AppTheme.mutedText),
                const SizedBox(height: 12),
                const Text('Card / Terminal',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkEspresso)),
                const SizedBox(height: 6),
                const Text(
                  'Process payment on your card terminal, then tap Mark as Paid.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, color: AppTheme.mutedText),
                ),
                const SizedBox(height: 20),
                Text(
                  CurrencyFormatter.format(_order!.totalAmount),
                  style: tt.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.darkEspresso),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: _processing
                  ? null
                  : () => _confirmPayment(
                      AppConstants.card, _order!.totalAmount),
              icon: _processing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkBadge01),
              label: Text(
                _processing ? 'Processing…' : 'Mark as Paid',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
