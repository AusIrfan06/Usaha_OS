import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/app_database.dart';

class DeliveryScreen extends ConsumerStatefulWidget {
  const DeliveryScreen({super.key});

  @override
  ConsumerState<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends ConsumerState<DeliveryScreen> {
  String _selectedPlatform = 'all'; // all, grabfood, foodpanda, shopeefood

  @override
  Widget build(BuildContext context) {
    final deliveryOrdersAsync = ref.watch(allDeliveryOrdersProvider);
    final ordersAsync = ref.watch(allOrdersProvider);
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        title: const Text(
          'Integrasi Platform Penghantaran (Delivery)',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.darkEspresso),
        ),
        backgroundColor: AppTheme.warmCream,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.orange, size: 28),
            tooltip: 'Simulasi Webhook Pesanan Masuk',
            onPressed: () => _showWebhookSimulatorDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: deliveryOrdersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ralat: $e')),
        data: (deliveryList) {
          final ordersMap = {
            for (var o in ordersAsync.value ?? <Order>[]) o.id: o
          };

          final filteredList = _selectedPlatform == 'all'
              ? deliveryList
              : deliveryList.where((d) => d.channel.toLowerCase() == _selectedPlatform).toList();

          // Calculate Channel Stats
          double totalGross = 0;
          double totalCommission = 0;
          double totalNet = 0;
          for (final d in deliveryList) {
            final order = ordersMap[d.orderId];
            if (order != null) {
              totalGross += order.totalAmount;
              totalCommission += d.commissionAmount;
              totalNet += d.netPayout;
            }
          }

          return ListView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            children: [
              // Summary Banner
              _buildChannelFinancialBanner(totalGross, totalCommission, totalNet, isTablet),
              const SizedBox(height: 20),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPlatformChip('all', 'Semua Saluran', Icons.apps, Colors.grey.shade800),
                    const SizedBox(width: 8),
                    _buildPlatformChip('grabfood', 'GrabFood (30%)', Icons.delivery_dining, const Color(0xFF00B14F)),
                    const SizedBox(width: 8),
                    _buildPlatformChip('foodpanda', 'Foodpanda (28%)', Icons.pedal_bike, const Color(0xFFD70F64)),
                    const SizedBox(width: 8),
                    _buildPlatformChip('shopeefood', 'ShopeeFood (25%)', Icons.electric_moped, const Color(0xFFEE4D2D)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              if (filteredList.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.delivery_dining_outlined, size: 64, color: AppTheme.mutedText.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      const Text(
                        'Tiada pesanan penghantaran aktif',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.mutedText),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.flash_on, size: 18),
                        label: const Text('Uji Simulasi Pesanan Masuk'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryCoffee, foregroundColor: Colors.white),
                        onPressed: () => _showWebhookSimulatorDialog(context),
                      ),
                    ],
                  ),
                )
              else
                ...filteredList.map((del) {
                  final order = ordersMap[del.orderId];
                  return _buildDeliveryOrderCard(context, del, order);
                }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryCoffee,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.bolt),
        label: const Text('Webhook Simulator'),
        onPressed: () => _showWebhookSimulatorDialog(context),
      ),
    );
  }

  Widget _buildChannelFinancialBanner(double gross, double commission, double net, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkEspresso,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RINGKASAN HASIL PLATFORM PENGHANTARAN',
                style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Live Integration', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBannerMetric('Jualan Kasar (Gross)', CurrencyFormatter.format(gross), Colors.white),
              ),
              Expanded(
                child: _buildBannerMetric('Komisen Saluran', '- ${CurrencyFormatter.format(commission)}', Colors.orangeAccent),
              ),
              Expanded(
                child: _buildBannerMetric('Hasil Bersih (Payout)', CurrencyFormatter.format(net), AppTheme.successGreen),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBannerMetric(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _buildPlatformChip(String platform, String label, IconData icon, Color color) {
    final isSelected = _selectedPlatform == platform;
    return ChoiceChip(
      avatar: Icon(icon, size: 16, color: isSelected ? Colors.white : color),
      label: Text(label),
      selected: isSelected,
      selectedColor: color,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.darkEspresso,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isSelected ? color : Colors.grey.shade300),
      ),
      onSelected: (selected) {
        if (selected) setState(() => _selectedPlatform = platform);
      },
    );
  }

  Widget _buildDeliveryOrderCard(BuildContext context, DeliveryOrder del, Order? order) {
    Color brandColor = const Color(0xFF00B14F); // Grab
    String brandName = 'GrabFood';
    IconData brandIcon = Icons.delivery_dining;

    if (del.channel.toLowerCase() == 'foodpanda') {
      brandColor = const Color(0xFFD70F64);
      brandName = 'Foodpanda';
      brandIcon = Icons.pedal_bike;
    } else if (del.channel.toLowerCase() == 'shopeefood') {
      brandColor = const Color(0xFFEE4D2D);
      brandName = 'ShopeeFood';
      brandIcon = Icons.electric_moped;
    }

    Color pickupColor = Colors.orange;
    String pickupLabel = 'Menunggu Pemandu';
    if (del.pickupStatus == 'driver_assigned') {
      pickupColor = Colors.blue;
      pickupLabel = 'Pemandu Ditugaskan';
    } else if (del.pickupStatus == 'picked_up') {
      pickupColor = Colors.purple;
      pickupLabel = 'Rider Mengambil Pesanan';
    } else if (del.pickupStatus == 'delivered') {
      pickupColor = AppTheme.successGreen;
      pickupLabel = 'Selesai Dihantar';
    }

    final total = order?.totalAmount ?? 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: brandColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(brandIcon, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        brandName,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  del.platformOrderId,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: pickupColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: pickupColor, width: 1),
                  ),
                  child: Text(
                    pickupLabel,
                    style: TextStyle(color: pickupColor, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            // Order & Financial Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order?.notes ?? 'Pesanan ${del.channel}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No. POS: ${order?.orderNumber ?? '-'} • Status KDS: ${order?.status ?? '-'}',
                        style: const TextStyle(color: AppTheme.mutedText, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.person_pin, size: 16, color: AppTheme.primaryCoffee),
                          const SizedBox(width: 4),
                          Text(
                            'Rider: ${del.riderName ?? "Belum Ditugaskan"} (${del.riderPhone ?? "-"})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Financial pill
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.warmCream,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Jumlah Kasar: ${CurrencyFormatter.format(total)}', style: const TextStyle(fontSize: 11)),
                      Text('Komisen (${(del.commissionRate * 100).toStringAsFixed(0)}%): -${CurrencyFormatter.format(del.commissionAmount)}', style: const TextStyle(fontSize: 10, color: Colors.red)),
                      const Divider(height: 6),
                      Text(
                        'Bersih: ${CurrencyFormatter.format(del.netPayout)}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppTheme.successGreen),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            // Action buttons for Rider Workflow
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (del.pickupStatus != 'delivered') ...[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () {
                      ref.read(databaseProvider).updateDeliveryRiderStatus(
                        del.id,
                        'picked_up',
                        riderName: del.riderName ?? 'Rider Assigned',
                      );
                    },
                    child: const Text('Tanda Rider Ambil (Picked Up)'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.successGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () {
                      ref.read(databaseProvider).updateDeliveryRiderStatus(del.id, 'delivered');
                    },
                    child: const Text('Tanda Selesai Dihantar'),
                  ),
                ] else ...[
                  const Text('✅ Selesai Dihantar ke Pelanggan', style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showWebhookSimulatorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.bolt, color: Colors.orange),
            SizedBox(width: 8),
            Text('Simulasi Webhook Pesanan Delivery'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih senario pesanan untuk menguji suntikan pesanan platform pihak ketiga secara langsung ke dalam POS, KDS dan penolakan inventori:',
              style: TextStyle(fontSize: 13, color: AppTheme.mutedText),
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFF00B14F)),
              ),
              leading: const Icon(Icons.delivery_dining, color: Color(0xFF00B14F)),
              title: const Text('GrabFood • 2x Spanish Latte & 1x Croissant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Komisen 30% • Nilai: RM 36.00', style: TextStyle(fontSize: 11)),
              onTap: () async {
                Navigator.pop(ctx);
                await ref.read(databaseProvider).simulateIncomingDeliveryOrder(
                  channel: 'grabfood',
                  customerName: 'Afiqah (Bangsar)',
                  itemsList: [
                    {'menuItemId': 1, 'name': 'Spanish Latte', 'price': 13.00, 'quantity': 2, 'modifiers': 'Oat Milk'},
                    {'menuItemId': 3, 'name': 'Butter Croissant', 'price': 10.00, 'quantity': 1, 'modifiers': 'Warm'},
                  ],
                  notes: 'Pesanan GrabFood #GF-8841: Afiqah (Kurang Manis)',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('⚡ Webhook GrabFood diterima! Pesanan dihantar ke KDS & stok ditolak.'),
                      backgroundColor: Color(0xFF00B14F),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFD70F64)),
              ),
              leading: const Icon(Icons.pedal_bike, color: Color(0xFFD70F64)),
              title: const Text('Foodpanda • 1x Iced Americano & 1x Pain au Choc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Komisen 28% • Nilai: RM 22.00', style: TextStyle(fontSize: 11)),
              onTap: () async {
                Navigator.pop(ctx);
                await ref.read(databaseProvider).simulateIncomingDeliveryOrder(
                  channel: 'foodpanda',
                  customerName: 'Chong Wei (Mid Valley)',
                  itemsList: [
                    {'menuItemId': 2, 'name': 'Iced Americano', 'price': 11.00, 'quantity': 1, 'modifiers': 'Extra Shot'},
                    {'menuItemId': 4, 'name': 'Pain au Chocolat', 'price': 11.00, 'quantity': 1, 'modifiers': ''},
                  ],
                  notes: 'Pesanan Foodpanda #FP-5120: Chong Wei',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('⚡ Webhook Foodpanda diterima! Pesanan dihantar ke KDS & stok ditolak.'),
                      backgroundColor: Color(0xFFD70F64),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFEE4D2D)),
              ),
              leading: const Icon(Icons.electric_moped, color: Color(0xFFEE4D2D)),
              title: const Text('ShopeeFood • 3x Teh Tarik Kaw & 2x Nasi Lemak', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Komisen 25% • Nilai: RM 45.00', style: TextStyle(fontSize: 11)),
              onTap: () async {
                Navigator.pop(ctx);
                await ref.read(databaseProvider).simulateIncomingDeliveryOrder(
                  channel: 'shopeefood',
                  customerName: 'Siti Sarah (Subang)',
                  itemsList: [
                    {'menuItemId': 1, 'name': 'Teh Tarik Kaw', 'price': 7.00, 'quantity': 3, 'modifiers': 'Kurang Manis'},
                    {'menuItemId': 2, 'name': 'Nasi Lemak Ayam Berempah', 'price': 12.00, 'quantity': 2, 'modifiers': 'Sambal Lebih'},
                  ],
                  notes: 'Pesanan ShopeeFood #SF-9912: Siti Sarah',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('⚡ Webhook ShopeeFood diterima! Pesanan dihantar ke KDS & stok ditolak.'),
                      backgroundColor: Color(0xFFEE4D2D),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
        ],
      ),
    );
  }
}
