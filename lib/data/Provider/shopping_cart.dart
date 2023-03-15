import 'package:flutter/material.dart';

import '../Models/shopping_cart.dart';

class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};
  Map<int, int> _selectedQuantities = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(int productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }

    if (_selectedQuantities.containsKey(productId)) {
      _selectedQuantities.update(
        productId,
            (existingQuantity) => existingQuantity + 1,
      );
    } else {
      _selectedQuantities.putIfAbsent(
        productId,
            () => 1,
      );
    }

    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);

    _selectedQuantities.remove(productId);

    notifyListeners();
  }

  void clear() {
    _items = {};

    _selectedQuantities = {};

    notifyListeners();
  }

  void setSelectedQuantity(int productId, int quantity) {
    if (_items.containsKey(productId)) {
      _items[productId]!.setQuantity(quantity);
      notifyListeners();
    }
  }

  int getSelectedQuantity(int productId) {
    if (_selectedQuantities.containsKey(productId)) {
      return _selectedQuantities[productId]!;
    }
    return 0;
  }
}
