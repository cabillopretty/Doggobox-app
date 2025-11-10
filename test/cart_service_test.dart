import 'package:flutter_test/flutter_test.dart';
import 'package:dogfoodshop/services/cart_service.dart';

void main() {
  group('CartService Tests', () {
    late CartService cartService;

    setUp(() {
      // Reset the singleton for testing
      // Note: In a real app, you might want to make this testable
      cartService = CartService();
    });

    test('should add item to cart', () {
      final item = CartItem(
        name: 'Test Dog Food',
        price: 100.0,
        image: 'test.png',
      );

      cartService.addItem(item);

      expect(cartService.items.length, greaterThan(0));
      expect(cartService.items.last.name, 'Test Dog Food');
    });

    test('should update quantity when adding same item', () {
      cartService.clearCart();

      final item1 = CartItem(
        name: 'Test Dog Food',
        price: 100.0,
        image: 'test.png',
        size: '1kg',
      );

      final item2 = CartItem(
        name: 'Test Dog Food',
        price: 100.0,
        image: 'test.png',
        size: '1kg',
        quantity: 3,
      );

      cartService.addItem(item1);
      cartService.addItem(item2);

      expect(cartService.items.length, 1); // Should combine into 1 item
      final testItem = cartService.items.firstWhere(
        (item) => item.name == 'Test Dog Food',
      );
      expect(testItem.quantity, 4); // 1 + 3
    });

    test('should remove item from cart', () {
      cartService.clearCart();

      final item = CartItem(name: 'Test Item', price: 50.0, image: 'test.png');

      cartService.addItem(item);
      final initialCount = cartService.items.length;
      cartService.removeItem(0);

      expect(cartService.items.length, initialCount - 1);
    });

    test('should update item quantity', () {
      cartService.clearCart();

      final item = CartItem(name: 'Test Item', price: 50.0, image: 'test.png');

      cartService.addItem(item);
      cartService.updateQuantity(0, 5);

      expect(cartService.items[0].quantity, 5);
    });

    test('should calculate subtotal correctly', () {
      cartService.clearCart();

      final item = CartItem(
        name: 'Test Item',
        price: 50.0,
        image: 'test.png',
        quantity: 2,
      );

      cartService.addItem(item);

      final testItem = cartService.items.firstWhere(
        (item) => item.name == 'Test Item',
      );
      expect(testItem.totalPrice, 100.0);
    });

    test('should clear cart', () {
      cartService.clearCart();

      expect(cartService.items.length, 0);
    });
  });
}
