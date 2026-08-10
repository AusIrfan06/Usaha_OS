import '../../data/database/app_database.dart';

/// Represents a selected add-on with its details.
class SelectedAddon {
  final int id;
  final String name;
  final double price;

  const SelectedAddon({
    required this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
  };

  factory SelectedAddon.fromJson(Map<String, dynamic> json) => SelectedAddon(
    id: json['id'] as int,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SelectedAddon && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// A single item in the cart with its quantity, optional modifier text, and add-ons.
class CartItem {
  final MenuItem menuItem;
  final int quantity;
  final String modifiers;
  final List<SelectedAddon> selectedAddons;
  final bool isCombo;
  final int? comboId;
  final String? comboName;

  const CartItem({
    required this.menuItem,
    this.quantity = 1,
    this.modifiers = '',
    this.selectedAddons = const [],
    this.isCombo = false,
    this.comboId,
    this.comboName,
  });

  CartItem copyWith({
    int? quantity,
    String? modifiers,
    List<SelectedAddon>? selectedAddons,
  }) => CartItem(
    menuItem: menuItem,
    quantity: quantity ?? this.quantity,
    modifiers: modifiers ?? this.modifiers,
    selectedAddons: selectedAddons ?? this.selectedAddons,
    isCombo: isCombo,
    comboId: comboId,
    comboName: comboName,
  );

  /// Total add-on price per unit
  double get addonsTotal => selectedAddons.fold(0.0, (sum, a) => sum + a.price);

  /// Unit price including add-ons
  double get unitPrice => menuItem.basePrice + addonsTotal;

  /// Subtotal = (base + addons) × quantity
  double get subtotal => unitPrice * quantity;

  /// A unique key to identify this specific cart line (item + addons combination)
  String get cartKey {
    final addonIds = selectedAddons.map((a) => a.id).toList()..sort();
    return '${menuItem.id}_${addonIds.join(',')}';
  }

  /// Human-readable add-on summary for display
  String get addonSummary {
    if (selectedAddons.isEmpty) return '';
    return selectedAddons.map((a) {
      if (a.price > 0) return '${a.name} (+RM${a.price.toStringAsFixed(2)})';
      return a.name;
    }).join(', ');
  }
}
