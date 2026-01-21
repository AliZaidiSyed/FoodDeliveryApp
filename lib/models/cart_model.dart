import 'package:flutter/material.dart';
import 'menu_model.dart'; // Import MenuModel and Item

class CartModel extends ChangeNotifier {
  final Map<Item, int> _items = {}; // Item -> quantity
  late MenuModel menu;

  Map<Item, int> get items => _items;

  int get totalPrice {
    return _items.entries.fold(0, (total, entry) {
      return total + (entry.key.price * entry.value);
    });
  }

  void add(Item item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! + 1;
    } else {
      _items[item] = 1;
    }
    notifyListeners();
  }

  void remove(Item item) {
    if (_items.containsKey(item)) {
      if (_items[item]! > 1) {
        _items[item] = _items[item]! - 1;
      } else {
        _items.remove(item);
      }
      notifyListeners();
    }
  }
}
