import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/pos/pos_screen.dart';
import '../../features/payment/payment_screen.dart';
import '../../features/payment/receipt_screen.dart';
import '../../features/orders/orders_screen.dart';
import '../../features/inventory/inventory_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../core/theme/app_theme.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          _AppShell(location: state.fullPath ?? '/', child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/pos',
          builder: (_, __) => const PosScreen(),
        ),
        GoRoute(
          path: '/orders',
          builder: (_, __) => const OrdersScreen(),
        ),
        GoRoute(
          path: '/inventory',
          builder: (_, __) => const InventoryScreen(),
        ),
        GoRoute(
          path: '/reports',
          builder: (_, __) => const ReportsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (_, __) => const SettingsScreen(),
        ),
      ],
    ),
    // Full-screen routes (outside shell — no nav bar/rail)
    GoRoute(
      path: '/payment/:orderId',
      builder: (_, state) => PaymentScreen(
        orderId: int.parse(state.pathParameters['orderId']!),
      ),
    ),
    GoRoute(
      path: '/receipt/:orderId',
      builder: (_, state) => ReceiptScreen(
        orderId: int.parse(state.pathParameters['orderId']!),
      ),
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────────────
// Adaptive Shell: NavigationRail on tablet, NavigationBar on phone
// ─────────────────────────────────────────────────────────────────────────────

class _AppShell extends StatelessWidget {
  final String location;
  final Widget child;

  const _AppShell({required this.location, required this.child});

  int get _index {
    return switch (location) {
      '/' => 0,
      '/pos' => 1,
      '/orders' => 2,
      '/inventory' => 3,
      '/reports' => 4,
      '/settings' => 5,
      _ => 0,
    };
  }

  static const _destinations = [
    (icon: Icons.dashboard_outlined, activeIcon: Icons.dashboard_rounded, label: 'Dashboard', path: '/'),
    (icon: Icons.point_of_sale_outlined, activeIcon: Icons.point_of_sale_rounded, label: 'POS', path: '/pos'),
    (icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long_rounded, label: 'Orders', path: '/orders'),
    (icon: Icons.inventory_2_outlined, activeIcon: Icons.inventory_2_rounded, label: 'Inventory', path: '/inventory'),
    (icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart_rounded, label: 'Reports', path: '/reports'),
    (icon: Icons.settings_outlined, activeIcon: Icons.settings_rounded, label: 'Settings', path: '/settings'),
  ];

  void _navigate(BuildContext context, int i) =>
      context.go(_destinations[i].path);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 700;
    final isDesktop = width >= 1100;

    if (isTablet) {
      return _railLayout(context, isDesktop);
    }
    return _bottomNavLayout(context);
  }

  // ── Phone: NavigationBar ─────────────────────────────────────────────────

  Widget _bottomNavLayout(BuildContext context) {
    final phoneDestinations = _destinations.take(5).toList();
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index.clamp(0, 4),
        onDestinationSelected: (i) => _navigate(context, i),
        destinations: phoneDestinations
            .map((d) => NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.activeIcon),
                  label: d.label,
                ))
            .toList(),
      ),
    );
  }

  // ── Tablet / Desktop: NavigationRail ─────────────────────────────────────

  Widget _railLayout(BuildContext context, bool extended) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            selectedIndex: _index,
            onDestinationSelected: (i) => _navigate(context, i),
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCoffee,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.coffee,
                        color: Colors.white, size: 22),
                  ),
                  if (extended) ...[
                    const SizedBox(height: 8),
                    const Text('Usaha OS',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: AppTheme.darkEspresso)),
                  ],
                ],
              ),
            ),
            destinations: _destinations
                .map((d) => NavigationRailDestination(
                      icon: Icon(d.icon),
                      selectedIcon: Icon(d.activeIcon),
                      label: Text(d.label),
                    ))
                .toList(),
          ),
          Container(
              width: 1, color: const Color(0xFFEDE3D8)),
          Expanded(child: child),
        ],
      ),
    );
  }
}
