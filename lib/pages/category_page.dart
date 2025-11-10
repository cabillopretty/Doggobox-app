import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogfoodshop/widgets/product_card.dart';
import 'package:dogfoodshop/services/cart_service.dart';
import 'package:dogfoodshop/widgets/cart_icon_with_badge.dart';
import 'package:dogfoodshop/widgets/app_snackbars.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Map<String, dynamic>> categoryProducts;

  final Map<String, List<Map<String, dynamic>>> productsByCategory = {
    'Food': [
      {
        'name': 'Royal Canin',
        'price': 850.00,
        'description':
            'Premium dry food for adult dogs, promotes healthy digestion and shiny coat.',
        'image': 'assets/product/Royal Canin.png',
      },
      {
        'name': 'Pedigree Puppy',
        'price': 420.00,
        'description':
            'Nutritious chicken and milk formula for growing puppies.',
        'image': 'assets/product/Pedigree Puppy.png',
      },
      {
        'name': 'Orijen Original',
        'price': 1200.00,
        'description':
            'Grain-free kibble packed with protein from chicken, turkey, and fish.',
        'image': 'assets/product/Orijen Original.png',
      },
      {
        'name': 'SmartHeart Beef',
        'price': 380.00,
        'description': 'Delicious beef and liver mix for strength and energy.',
        'image': 'assets/product/SmartHeart Beef.png',
      },
      {
        'name': 'Cesar Chicken',
        'price': 90.00,
        'description': 'Soft wet food made with real chicken in tasty gravy.',
        'image': 'assets/product/Cesar Chicken.png',
      },
      {
        'name': 'BowWow Lamb',
        'price': 650.00,
        'description': 'Dehydrated lamb bites rich in flavor and nutrients.',
        'image': 'assets/product/BowWow Lamb.png',
      },
    ],
    'Treats': [
      {
        'name': 'JerHigh Stick',
        'price': 120.00,
        'description': 'Soft and chewy chicken sticks made from real meat.',
        'image': 'assets/product/JerHigh Stick.png',
      },
      {
        'name': 'Pedigree Dentastix',
        'price': 160.00,
        'description':
            'Dental chew sticks that clean teeth and freshen breath.',
        'image': 'assets/product/Pedigree Dentastix.png',
      },
      {
        'name': 'BowWow Bacon',
        'price': 140.00,
        'description': 'Crispy bacon-flavored snacks dogs love.',
        'image': 'assets/product/BowWow Bacon.png',
      },
      {
        'name': 'Doggie Bones',
        'price': 180.00,
        'description': 'Crunchy bone-shaped treats with added calcium.',
        'image': 'assets/product/Doggie Bones.png',
      },
      {
        'name': 'Orijen Treats',
        'price': 350.00,
        'description':
            'Natural freeze-dried treats made from poultry and fish.',
        'image': 'assets/product/Orijen Treats.png',
      },
      {
        'name': 'Cesar Bites',
        'price': 110.00,
        'description': 'Soft, bite-sized beef treats perfect for training.',
        'image': 'assets/product/Cesar Bites.png',
      },
    ],
    'Supplies': [
      {
        'name': 'Doggo Collar',
        'price': 250.00,
        'description': 'Adjustable nylon collar with durable metal buckle.',
        'image': 'assets/product/Doggo Collar.png',
      },
      {
        'name': 'FurMagic Brush',
        'price': 380.00,
        'description':
            'Gentle slicker brush that removes tangles and loose fur.',
        'image': 'assets/product/FurMagic Brush.png',
      },
      {
        'name': 'Doggo Bowl',
        'price': 550.00,
        'description': 'Non-slip stainless steel bowls for food and water.',
        'image': 'assets/product/Doggo Bowl.png',
      },
      {
        'name': 'PawMate Leash',
        'price': 300.00,
        'description': 'Strong, comfortable leash with padded handle.',
        'image': 'assets/product/PawMate Leash.png',
      },
      {
        'name': 'CozyBed Cushion',
        'price': 980.00,
        'description': 'Soft, washable cushion bed for all dog sizes.',
        'image': 'assets/product/CozyBed Cushion.png',
      },
      {
        'name': 'PupClean Shampoo',
        'price': 290.00,
        'description': 'Gentle aloe-based shampoo that keeps fur shiny.',
        'image': 'assets/product/PupClean Shampoo.png',
      },
    ],
    'Health': [
      {
        'name': 'PetOne Vits',
        'price': 250.00,
        'description':
            'Daily multivitamin supplement to boost immunity and bones.',
        'image': 'assets/product/PetOne Vits.png',
      },
      {
        'name': 'Frontline Plus',
        'price': 750.00,
        'description': 'Spot-on protection against ticks, fleas, and lice.',
        'image': 'assets/product/Frontline Plus.png',
      },
      {
        'name': 'Omega Oil',
        'price': 400.00,
        'description': 'Fish oil capsules for a healthy coat and heart.',
        'image': 'assets/product/Omega Oil.png',
      },
      {
        'name': 'DrPaws Deworm',
        'price': 280.00,
        'description': 'Effective deworming syrup for all breeds.',
        'image': 'assets/product/DrPaws Deworm.png',
      },
      {
        'name': 'Virbac Kit',
        'price': 420.00,
        'description': 'Toothpaste and brush set for clean teeth and gums.',
        'image': 'assets/product/Virbac Kit.png',
      },
      {
        'name': 'Doggo Cleaner',
        'price': 300.00,
        'description': 'Gentle ear cleaner that prevents infections.',
        'image': 'assets/product/Doggo Cleaner.png',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    categoryProducts = productsByCategory[widget.categoryName] ?? [];
  }

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
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: categoryProducts[index],
                      );
                    },
                    child: ProductCard(
                      imageUrl: categoryProducts[index]['image'],
                      productName: categoryProducts[index]['name'],
                      price: categoryProducts[index]['price'],
                      onAddToCart: () {
                        Provider.of<CartService>(
                          context,
                          listen: false,
                        ).addItem(
                          CartItem(
                            name: categoryProducts[index]['name'],
                            price: categoryProducts[index]['price'],
                            image: categoryProducts[index]['image'],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBars.success(
                            message:
                                '${categoryProducts[index]['name']} added to cart!',
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
