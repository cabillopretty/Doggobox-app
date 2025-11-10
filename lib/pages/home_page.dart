import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogfoodshop/widgets/product_card.dart';
import 'package:dogfoodshop/widgets/category_chip.dart';
import 'package:dogfoodshop/services/cart_service.dart';
import 'package:dogfoodshop/widgets/cart_icon_with_badge.dart';
import 'package:dogfoodshop/widgets/app_snackbars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter states
  String _sortBy = 'name'; // 'name', 'price-low', 'price-high'
  Set<String> _selectedCategories = {};
  Set<String> _selectedDietaryPrefs = {};

  final List<String> categories = ['Food', 'Treats', 'Supplies', 'Health'];

  final List<String> dietaryPreferences = ['Organic', 'Grain-Free'];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Royal Canin',
      'price': 850.00,
      'description':
          'Premium dry food for adult dogs, promotes healthy digestion and shiny coat.',
      'image': 'assets/product/Royal Canin.png',
    },
    {
      'name': 'JerHigh Stick',
      'price': 120.00,
      'description': 'Soft and chewy chicken sticks made from real meat.',
      'image': 'assets/product/JerHigh Stick.png',
    },
    {
      'name': 'Doggo Collar',
      'price': 250.00,
      'description': 'Adjustable nylon collar with durable metal buckle.',
      'image': 'assets/product/Doggo Collar.png',
    },
    {
      'name': 'PetOne Vits',
      'price': 250.00,
      'description':
          'Daily multivitamin supplement to boost immunity and bones.',
      'image': 'assets/product/PetOne Vits.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  List<Map<String, dynamic>> get _filteredProducts {
    // If there is no search query and no active filters, treat this as
    // the Featured Products view and preserve the original products order.
    final bool isFeaturedView =
        _searchQuery.isEmpty &&
        _selectedCategories.isEmpty &&
        _selectedDietaryPrefs.isEmpty;

    List<Map<String, dynamic>> filtered = List<Map<String, dynamic>>.from(
      products,
    );

    if (isFeaturedView) {
      // Return the original products order for featured products
      return filtered;
    }

    // Apply search filter when not in featured view
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        return product['name'].toLowerCase().contains(
          _searchQuery.toLowerCase(),
        );
      }).toList();
    }

    // Apply category filters
    if (_selectedCategories.isNotEmpty) {
      filtered = filtered.where((product) {
        return _selectedCategories.any(
          (category) =>
              product['name'].toLowerCase().contains(category.toLowerCase()),
        );
      }).toList();
    }

    // Apply dietary preference filters
    if (_selectedDietaryPrefs.isNotEmpty) {
      filtered = filtered.where((product) {
        return _selectedDietaryPrefs.any(
          (pref) => product['name'].toLowerCase().contains(pref.toLowerCase()),
        );
      }).toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'price-low':
        filtered.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'price-high':
        filtered.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'name':
      default:
        filtered.sort((a, b) => a['name'].compareTo(b['name']));
        break;
    }

    return filtered;
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _sortBy = 'name';
                        _selectedCategories.clear();
                        _selectedDietaryPrefs.clear();
                      });
                      this.setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Clear All',
                      style: TextStyle(color: Color(0xFF46D6F0)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Sort By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildSortOption('Name', 'name', setState),
                  const SizedBox(width: 10),
                  _buildSortOption('Price: Low to High', 'price-low', setState),
                  const SizedBox(width: 10),
                  _buildSortOption(
                    'Price: High to Low',
                    'price-high',
                    setState,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                      this.setState(() {});
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: const Color(0xFF46D6F0).withOpacity(0.2),
                    checkmarkColor: const Color(0xFF46D6F0),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Dietary Preferences',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dietaryPreferences.map((pref) {
                  final isSelected = _selectedDietaryPrefs.contains(pref);
                  return FilterChip(
                    label: Text(pref),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedDietaryPrefs.add(pref);
                        } else {
                          _selectedDietaryPrefs.remove(pref);
                        }
                      });
                      this.setState(() {});
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: const Color(0xFF46D6F0).withOpacity(0.2),
                    checkmarkColor: const Color(0xFF46D6F0),
                  );
                }).toList(),
              ),
              const Spacer(),
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Apply Filters',
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
      ),
    );
  }

  Widget _buildSortOption(String label, String value, StateSetter setState) {
    final isSelected = _sortBy == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _sortBy = value;
          });
          this.setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF46D6F0) : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  bool _hasActiveFilters() {
    return _selectedCategories.isNotEmpty ||
        _selectedDietaryPrefs.isNotEmpty ||
        _sortBy != 'name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '𝕯𝖔𝖌𝖌𝖔𝖇𝖔𝖝',
          style: TextStyle(
            color: Color(0xFF46D6F0),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Icon(Icons.person_outline, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search dog food...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF46D6F0),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _showFilterDialog,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF46D6F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Promotional Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/dogbanner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Premium Dog Food',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Healthy & nutritious food for your furry friend',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF46D6F0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    label: categories[index],
                    isSelected: _selectedCategory == index,
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                      Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: categories[index],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Products Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _hasActiveFilters()
                      ? 'Filtered Results (${_filteredProducts.length})'
                      : _searchQuery.isEmpty
                      ? 'Featured Products'
                      : 'Search Results (${_filteredProducts.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: product,
                      );
                    },
                    child: ProductCard(
                      imageUrl: product['image'],
                      productName: product['name'],
                      price: product['price'],
                      onAddToCart: () {
                        Provider.of<CartService>(
                          context,
                          listen: false,
                        ).addItem(
                          CartItem(
                            name: product['name'],
                            price: product['price'],
                            image: product['image'],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBars.success(
                            message: '${product['name']} added to cart!',
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<CartService>(
        builder: (context, cartService, child) => BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF46D6F0),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 1) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/cart');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(icon: CartIconWithBadge(), label: 'Cart'),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
