import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/models/cart_item.dart';

/// Manages the active cart — add, remove, decrement, clear.
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(MenuItem item) {
    final idx = state.indexWhere((i) => i.menuItem.id == item.id);
    if (idx >= 0) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity + 1),
        ...state.sublist(idx + 1),
      ];
    } else {
      state = [...state, CartItem(menuItem: item)];
    }
  }

  void decrementItem(int menuItemId) {
    final idx = state.indexWhere((i) => i.menuItem.id == menuItemId);
    if (idx < 0) return;
    if (state[idx].quantity > 1) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity - 1),
        ...state.sublist(idx + 1),
      ];
    } else {
      removeItem(menuItemId);
    }
  }

  void removeItem(int menuItemId) {
    state = state.where((i) => i.menuItem.id != menuItemId).toList();
  }

  void clear() => state = [];

  double get subtotal => state.fold(0.0, (sum, i) => sum + i.subtotal);

  int get totalItemCount => state.fold(0, (sum, i) => sum + i.quantity);

  int quantityOf(int menuItemId) {
    final idx = state.indexWhere((i) => i.menuItem.id == menuItemId);
    return idx >= 0 ? state[idx].quantity : 0;
  }
}
