import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final double price;
  final String image;
  String size;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.size = '1kg',
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'size': size,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'],
      price: map['price'],
      image: map['image'],
      size: map['size'] ?? '1kg',
      quantity: map['quantity'] ?? 1,
    );
  }
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 9.99;

  double get totalAmount => subtotal + deliveryFee;

  void addItem(CartItem item) {
    // Check if item already exists with same name and size
    final existingIndex = _items.indexWhere(
      (cartItem) => cartItem.name == item.name && cartItem.size == item.size,
    );

    if (existingIndex != -1) {
      // Update quantity if item exists
      _items[existingIndex].quantity += item.quantity;
    } else {
      // Add new item
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length && newQuantity > 0) {
      _items[index].quantity = newQuantity;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void removeSelectedItems(Set<int> selectedIndices) {
    final indicesToRemove = selectedIndices.toList()
      ..sort((a, b) => b.compareTo(a));
    for (final index in indicesToRemove) {
      if (index < _items.length) {
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }
}
