import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/models/cart_item.dart';

/// Manages the active cart — add, remove, decrement, clear.
/// Now supports add-ons: items with different add-on selections are treated as
/// separate line items.
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  /// Add item with optional add-ons.
  /// If an identical item+addons combination exists, increment its quantity.
  void addItem(MenuItem item, {List<SelectedAddon> addons = const []}) {
    final key = _makeKey(item.id, addons);
    final idx = state.indexWhere((i) => i.cartKey == key);
    if (idx >= 0) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity + 1),
        ...state.sublist(idx + 1),
      ];
    } else {
      state = [...state, CartItem(menuItem: item, selectedAddons: addons)];
    }
  }

  /// Add a combo to the cart as a single line item
  void addCombo({
    required MenuItem representativeItem,
    required int comboId,
    required String comboName,
    required double comboPrice,
    List<SelectedAddon> addons = const [],
  }) {
    // Create a modified "virtual" menu item with the combo price
    // We track it via comboId on the CartItem
    state = [
      ...state,
      CartItem(
        menuItem: representativeItem,
        selectedAddons: addons,
        isCombo: true,
        comboId: comboId,
        comboName: comboName,
      ),
    ];
  }

  void decrementItem(String cartKey) {
    final idx = state.indexWhere((i) => i.cartKey == cartKey);
    if (idx < 0) return;
    if (state[idx].quantity > 1) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity - 1),
        ...state.sublist(idx + 1),
      ];
    } else {
      removeItem(cartKey);
    }
  }

  /// Legacy: decrement by menuItemId (for backward compatibility)
  void decrementItemById(int menuItemId) {
    final idx = state.indexWhere((i) => i.menuItem.id == menuItemId);
    if (idx < 0) return;
    if (state[idx].quantity > 1) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity - 1),
        ...state.sublist(idx + 1),
      ];
    } else {
      state = state.where((i) => i.menuItem.id != menuItemId).toList();
    }
  }

  void removeItem(String cartKey) {
    state = state.where((i) => i.cartKey != cartKey).toList();
  }

  void clear() => state = [];

  double get subtotal => state.fold(0.0, (sum, i) => sum + i.subtotal);

  int get totalItemCount => state.fold(0, (sum, i) => sum + i.quantity);

  int quantityOf(int menuItemId) {
    // Sum all quantities for this menu item ID (across different addon combos)
    return state
        .where((i) => i.menuItem.id == menuItemId)
        .fold(0, (sum, i) => sum + i.quantity);
  }

  /// Build the modifiers JSON string for an order item
  static String buildModifiersJson(CartItem item) {
    if (item.selectedAddons.isEmpty) return '';
    return jsonEncode(item.selectedAddons.map((a) => a.toJson()).toList());
  }

  String _makeKey(int menuItemId, List<SelectedAddon> addons) {
    final addonIds = addons.map((a) => a.id).toList()..sort();
    return '${menuItemId}_${addonIds.join(',')}';
  }
}
