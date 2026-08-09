import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Premium Card Container
// ─────────────────────────────────────────────────────────────────────────────

class UCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const UCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(20);
    final card = Container(
      decoration: BoxDecoration(
        color: color ?? AppTheme.cardBg,
        borderRadius: br,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A3E2004),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(20),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: br,
        child: InkWell(
          onTap: onTap,
          borderRadius: br,
          splashColor: AppTheme.primaryCoffee.withOpacity(0.06),
          highlightColor: AppTheme.primaryCoffee.withOpacity(0.04),
          child: card,
        ),
      );
    }
    return card;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status Badge
// ─────────────────────────────────────────────────────────────────────────────

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      'pending' => ('Pending', const Color(0xFFFFF3E0), AppTheme.warningAmber),
      'in_progress' => ('In Progress', const Color(0xFFE3F2FD), Colors.blue),
      'ready' => ('Ready', const Color(0xFFE8F5E9), AppTheme.successGreen),
      'completed' => ('Completed', const Color(0xFFE8F5E9), AppTheme.successGreen),
      'voided' => ('Voided', const Color(0xFFFFEBEE), AppTheme.dangerRed),
      _ => (status, const Color(0xFFF5F5F5), Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Order Type Badge
// ─────────────────────────────────────────────────────────────────────────────

class OrderTypeBadge extends StatelessWidget {
  final String orderType;
  const OrderTypeBadge({super.key, required this.orderType});

  @override
  Widget build(BuildContext context) {
    final (label, icon, color) = switch (orderType) {
      'dine_in' => ('Dine-in', HugeIcons.strokeRoundedRestaurant01, const Color(0xFF6A1B9A)),
      'takeaway' => ('Takeaway', HugeIcons.strokeRoundedShoppingBag01, AppTheme.primaryCoffee),
      'delivery' => ('Delivery', Icons.delivery_dining, AppTheme.duitNowBlue),
      _ => ('?', HugeIcons.strokeRoundedHelpCircle, Colors.grey),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon is IconData ? Icon(icon, size: 14, color: color) : HugeIcon(icon: icon as dynamic, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat Card
// ─────────────────────────────────────────────────────────────────────────────

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final dynamic icon;
  final Color iconColor;
  final Color? iconBg;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return UCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBg ?? iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: icon is List<List<dynamic>> 
                  ? HugeIcon(icon: icon as List<List<dynamic>>, color: iconColor, size: 20)
                  : Icon(icon as IconData, color: iconColor, size: 20),
            ),
          ),
          const SizedBox(height: 14),
          Text(value,
              style: tt.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800, fontSize: 24, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(label,
              style: tt.bodySmall?.copyWith(color: AppTheme.mutedText, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section Header
// ─────────────────────────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;

  const SectionHeader({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(title,
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty State
// ─────────────────────────────────────────────────────────────────────────────

class EmptyState extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String subtitle;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.mutedText.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: icon is IconData
                ? Icon(icon as IconData, size: 48, color: AppTheme.mutedText.withOpacity(0.7))
                : HugeIcon(icon: icon, size: 48, color: AppTheme.mutedText.withOpacity(0.7)),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: tt.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700, color: AppTheme.mutedText)),
          const SizedBox(height: 8),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: tt.bodySmall?.copyWith(color: AppTheme.mutedText)),
          if (action != null) ...[
            const SizedBox(height: 20),
            action!,
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sync Indicator dot
// ─────────────────────────────────────────────────────────────────────────────

class SyncDot extends StatelessWidget {
  final bool isOnline;
  const SyncDot({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isOnline ? AppTheme.successGreen : AppTheme.mutedText,
      ),
    );
  }
}
