import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogfoodshop/services/cart_service.dart';
import 'package:dogfoodshop/widgets/app_snackbars.dart';
import 'package:dogfoodshop/widgets/cart_icon_with_badge.dart';

class DogFoodDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const DogFoodDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DogFoodDetailsPage> createState() => _DogFoodDetailsPageState();
}

class _DogFoodDetailsPageState extends State<DogFoodDetailsPage> {
  String _selectedSize = '1kg';
  int _quantity = 1;

  final List<String> sizes = ['1kg', '3kg', '5kg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          Consumer<CartService>(
            builder: (context, cartService, child) => IconButton(
              icon: CartIconWithBadge(),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.white,
              child: widget.product['image'].startsWith('assets/')
                  ? Image.asset(
                      widget.product['image'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        );
                      },
                    )
                  : Image.network(
                      widget.product['image'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '₱${widget.product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF46D6F0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.8 (120 reviews)',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Description
                  Text(
                    'Description',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product['description'] as String? ??
                        'No description available for this product.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  // size selector removed; product sizes not required
                  const SizedBox(height: 20),
                  // Quantity Selector
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.remove, size: 20),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.add, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF46D6F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<CartService>(
                          context,
                          listen: false,
                        ).addItem(
                          CartItem(
                            name: widget.product['name'],
                            price: widget.product['price'],
                            image: widget.product['image'],
                            size: _selectedSize,
                            quantity: _quantity,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBars.success(
                            message:
                                '${widget.product['name']} (${_selectedSize}) x $_quantity added to cart!',
                          ),
                        );
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
