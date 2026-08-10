import '../../data/database/app_database.dart';

/// A single item in the cart with its quantity and optional modifier text.
class CartItem {
  final MenuItem menuItem;
  final int quantity;
  final String modifiers;

  const CartItem({
    required this.menuItem,
    this.quantity = 1,
    this.modifiers = '',
  });

  CartItem copyWith({int? quantity, String? modifiers}) => CartItem(
    menuItem: menuItem,
    quantity: quantity ?? this.quantity,
    modifiers: modifiers ?? this.modifiers,
  );

  double get subtotal => menuItem.basePrice * quantity;
}
