import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/pos/pos_screen.dart';
import '../../features/kds/kds_screen.dart';
import '../../features/tasks/tasks_screen.dart';
import '../../features/loyalty/loyalty_screen.dart';
import '../../features/staff/staff_screen.dart';
import '../../features/suppliers/suppliers_po_screen.dart';
import '../../features/inventory/stock_take_screen.dart';
import '../../features/expenses/expenses_screen.dart';
import '../../features/payment/payment_screen.dart';
import '../../features/payment/receipt_screen.dart';
import '../../features/orders/orders_screen.dart';
import '../../features/inventory/inventory_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/outlets/outlets_screen.dart';
import '../../features/delivery/delivery_screen.dart';
import '../../features/analytics/advanced_analytics_screen.dart';
import '../../features/kiosk/kiosk_mode_screen.dart';
import '../../features/kiosk/kiosk_order_screen.dart';
import '../../features/kiosk/kiosk_checkout_screen.dart';
import '../../features/ai_forecast/ai_forecast_screen.dart';
import '../../features/einvoice/einvoice_screen.dart';
import '../../core/theme/app_theme.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          _AppShell(location: state.fullPath ?? '/', child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/pos', builder: (_, __) => const PosScreen()),
        GoRoute(path: '/kds', builder: (_, __) => const KdsScreen()),
        GoRoute(path: '/tasks', builder: (_, __) => const TasksScreen()),
        GoRoute(path: '/loyalty', builder: (_, __) => const LoyaltyScreen()),
        GoRoute(path: '/staff', builder: (_, __) => const StaffScreen()),
        GoRoute(
          path: '/suppliers',
          builder: (_, __) => const SuppliersPoScreen(),
        ),
        GoRoute(
          path: '/stock-take',
          builder: (_, __) => const StockTakeScreen(),
        ),
        GoRoute(path: '/expenses', builder: (_, __) => const ExpensesScreen()),
        GoRoute(path: '/outlets', builder: (_, __) => const OutletsScreen()),
        GoRoute(path: '/delivery', builder: (_, __) => const DeliveryScreen()),
        GoRoute(
          path: '/analytics',
          builder: (_, __) => const AdvancedAnalyticsScreen(),
        ),
        GoRoute(path: '/orders', builder: (_, __) => const OrdersScreen()),
        GoRoute(
          path: '/inventory',
          builder: (_, __) => const InventoryScreen(),
        ),
        GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
        GoRoute(
          path: '/ai-forecast',
          builder: (_, __) => const AiForecastScreen(),
        ),
        GoRoute(path: '/einvoice', builder: (_, __) => const EinvoiceScreen()),
      ],
    ),
    // Full-screen routes (outside shell — no nav bar/rail)
    GoRoute(
      path: '/payment/:orderId',
      builder: (_, state) =>
          PaymentScreen(orderId: int.parse(state.pathParameters['orderId']!)),
    ),
    GoRoute(
      path: '/receipt/:orderId',
      builder: (_, state) =>
          ReceiptScreen(orderId: int.parse(state.pathParameters['orderId']!)),
    ),
    // Kiosk — full-screen routes (no nav bar/rail, locked for customers)
    GoRoute(path: '/kiosk', builder: (_, __) => const KioskModeScreen()),
    GoRoute(path: '/kiosk/order', builder: (_, __) => const KioskOrderScreen()),
    GoRoute(
      path: '/kiosk/checkout/:orderId',
      builder: (_, state) => KioskCheckoutScreen(
        orderId: int.parse(state.pathParameters['orderId']!),
      ),
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────────────
// Adaptive Shell: NavigationRail on tablet, NavigationBar + Drawer on phone
// ─────────────────────────────────────────────────────────────────────────────

class _Dest {
  final dynamic icon;
  final dynamic activeIcon;
  final String label;
  final String path;
  const _Dest(this.icon, this.activeIcon, this.label, this.path);
}

class _AppShell extends StatelessWidget {
  final String location;
  final Widget child;

  const _AppShell({required this.location, required this.child});

  static const _destinations = [
    _Dest(
      HugeIcons.strokeRoundedHome01,
      HugeIcons.strokeRoundedHome01,
      'Dashboard',
      '/',
    ),
    _Dest(
      HugeIcons.strokeRoundedShoppingCart01,
      HugeIcons.strokeRoundedShoppingCart01,
      'POS',
      '/pos',
    ),
    _Dest(
      HugeIcons.strokeRoundedRestaurant01,
      HugeIcons.strokeRoundedRestaurant01,
      'KDS',
      '/kds',
    ),
    _Dest(
      HugeIcons.strokeRoundedTask01,
      HugeIcons.strokeRoundedTask01,
      'Tugasan',
      '/tasks',
    ),
    _Dest(
      HugeIcons.strokeRoundedGift,
      HugeIcons.strokeRoundedGift,
      'Loyalty',
      '/loyalty',
    ),
    _Dest(
      HugeIcons.strokeRoundedUserGroup,
      HugeIcons.strokeRoundedBadge,
      'Staf',
      '/staff',
    ),
    _Dest(
      HugeIcons.strokeRoundedTruckDelivery,
      HugeIcons.strokeRoundedTruckDelivery,
      'Pembekal & PO',
      '/suppliers',
    ),
    _Dest(
      HugeIcons.strokeRoundedPackage,
      HugeIcons.strokeRoundedPackage,
      'Stock Take',
      '/stock-take',
    ),
    _Dest(
      HugeIcons.strokeRoundedBank,
      HugeIcons.strokeRoundedBank,
      'Perbelanjaan',
      '/expenses',
    ),
    _Dest(
      HugeIcons.strokeRoundedStore01,
      HugeIcons.strokeRoundedStore01,
      'Multi-Outlet',
      '/outlets',
    ),
    _Dest(
      HugeIcons.strokeRoundedScooter01,
      HugeIcons.strokeRoundedScooter01,
      'Delivery Hub',
      '/delivery',
    ),
    _Dest(
      HugeIcons.strokeRoundedPresentation01,
      HugeIcons.strokeRoundedPresentation01,
      'Analitik Lanjutan',
      '/analytics',
    ),
    _Dest(
      HugeIcons.strokeRoundedInvoice01,
      HugeIcons.strokeRoundedInvoice01,
      'Pesanan',
      '/orders',
    ),
    _Dest(
      HugeIcons.strokeRoundedPackage,
      HugeIcons.strokeRoundedPackage,
      'Inventori',
      '/inventory',
    ),
    _Dest(
      HugeIcons.strokeRoundedBarChart,
      HugeIcons.strokeRoundedBarChart,
      'Laporan',
      '/reports',
    ),
    _Dest(
      HugeIcons.strokeRoundedSettings02,
      HugeIcons.strokeRoundedSettings02,
      'Tetapan',
      '/settings',
    ),
  ];

  int get _index {
    final idx = _destinations.indexWhere((d) => d.path == location);
    return idx >= 0 ? idx : 0;
  }

  void _navigate(BuildContext context, int i) =>
      context.go(_destinations[i].path);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 800;
    final isDesktop = width >= 1200;

    if (isTablet) {
      return _railLayout(context, isDesktop);
    }
    return _bottomNavLayout(context);
  }

  // ── Phone: NavigationBar + More Menu ─────────────────────────────────────

  Widget _bottomNavLayout(BuildContext context) {
    // Show top 4 primary + More menu
    final primaryPhoneDestinations = _destinations.take(4).toList();
    final currentIndex = _index;
    final isPrimary = currentIndex < 4;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: isPrimary ? currentIndex : 4,
        onDestinationSelected: (i) {
          if (i < 4) {
            _navigate(context, i);
          } else {
            _showMoreMenu(context);
          }
        },
        destinations: [
          ...primaryPhoneDestinations.map((d) {
            final isHuge = d.icon is List<List<dynamic>>;
            return NavigationDestination(
              icon: isHuge
                  ? HugeIcon(
                      icon: d.icon as List<List<dynamic>>,
                      size: 24,
                      color: AppTheme.mutedText,
                    )
                  : HugeIcon(
                      icon: d.icon as dynamic,
                      color: AppTheme.mutedText,
                    ),
              selectedIcon: isHuge
                  ? HugeIcon(
                      icon: d.activeIcon as List<List<dynamic>>,
                      size: 24,
                      color: AppTheme.primaryCoffee,
                    )
                  : HugeIcon(
                      icon: d.activeIcon as dynamic,
                      color: AppTheme.primaryCoffee,
                    ),
              label: d.label,
            );
          }),
          const NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedMenu01),
            selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedMenu01),
            label: 'Lain-lain',
          ),
        ],
      ),
    );
  }

  void _showMoreMenu(BuildContext context) {
    final moreDestinations = _destinations.skip(4).toList();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Modul Usaha OS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: moreDestinations.length,
              itemBuilder: (ctx, i) {
                final d = moreDestinations[i];
                final isSelected = location == d.path;
                final isHuge = d.activeIcon is List<List<dynamic>>;
                final iconColor = isSelected
                    ? AppTheme.primaryCoffee
                    : AppTheme.darkEspresso;

                return InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    context.go(d.path);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryCoffee.withOpacity(0.15)
                          : AppTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(
                              color: AppTheme.primaryCoffee,
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isHuge
                            ? HugeIcon(
                                icon: d.activeIcon as List<List<dynamic>>,
                                color: iconColor,
                                size: 26,
                              )
                            : HugeIcon(
                                icon: d.activeIcon as dynamic,
                                color: iconColor,
                                size: 26,
                              ),
                        const SizedBox(height: 6),
                        Text(
                          d.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: isSelected
                                ? AppTheme.primaryCoffee
                                : AppTheme.darkEspresso,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Tablet / Desktop: NavigationRail ─────────────────────────────────────

  Widget _railLayout(BuildContext context, bool extended) {
    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: NavigationRail(
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
                            image: const DecorationImage(
                              image: AssetImage('assets/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (extended) ...[
                          const SizedBox(height: 8),
                          const Text(
                            'Usaha OS',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: AppTheme.darkEspresso,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  destinations: _destinations.map((d) {
                    final isHuge = d.icon is List<List<dynamic>>;
                    return NavigationRailDestination(
                      icon: isHuge
                          ? HugeIcon(
                              icon: d.icon as List<List<dynamic>>,
                              size: 24,
                              color: AppTheme.mutedText,
                            )
                          : HugeIcon(
                              icon: d.icon as dynamic,
                              color: AppTheme.mutedText,
                            ),
                      selectedIcon: isHuge
                          ? HugeIcon(
                              icon: d.activeIcon as List<List<dynamic>>,
                              size: 24,
                              color: AppTheme.primaryCoffee,
                            )
                          : HugeIcon(
                              icon: d.activeIcon as dynamic,
                              color: AppTheme.primaryCoffee,
                            ),
                      label: Text(d.label),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(width: 1, color: const Color(0xFFEDE3D8)),
          Expanded(child: child),
        ],
      ),
    );
  }
}
