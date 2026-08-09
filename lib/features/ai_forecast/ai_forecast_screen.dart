import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/theme/app_theme.dart';

class AiForecastScreen extends StatelessWidget {
  const AiForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, color: AppTheme.darkEspresso, size: 24),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'AI Demand Forecast',
          style: TextStyle(color: AppTheme.darkEspresso, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  HugeIcon(icon: HugeIcons.strokeRoundedAiNetwork, color: Colors.white, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Usaha OS AI Engine Aktif', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 4),
                        Text('Berdasarkan data jualan 30 hari lepas.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Cadangan Pesanan Bekalan (Minggu Ini)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkEspresso)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildForecastItem('Biji Kopi Arabica (Brazil)', 'Tinggal 5kg. Jangkaan habis dalam 3 hari.', 'Pesan 20kg', HugeIcons.strokeRoundedCoffee01, Colors.brown),
                  _buildForecastItem('Susu Segar (Farm Fresh)', 'Permintaan tinggi hujung minggu.', 'Pesan 15 Karton', HugeIcons.strokeRoundedMilkBottle, Colors.blue),
                  _buildForecastItem('Cawan Kertas (Cup)', 'Stok mencukupi untuk 2 minggu.', 'Tiada Tindakan', HugeIcons.strokeRoundedCup01, Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(String title, String desc, String action, List<List<dynamic>> icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: HugeIcon(icon: icon, color: color, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(desc),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: action == 'Tiada Tindakan' ? Colors.grey[200] : AppTheme.primaryCoffee,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            action,
            style: TextStyle(
              color: action == 'Tiada Tindakan' ? Colors.black54 : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
