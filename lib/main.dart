import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogfoodshop/services/cart_service.dart';
import 'package:dogfoodshop/pages/welcome_page.dart';
import 'package:dogfoodshop/pages/login_page.dart';
import 'package:dogfoodshop/pages/register_page.dart';
import 'package:dogfoodshop/pages/home_page.dart';
import 'package:dogfoodshop/pages/category_page.dart';
import 'package:dogfoodshop/pages/dogfood_details_page.dart';
import 'package:dogfoodshop/pages/cart_page.dart';
import 'package:dogfoodshop/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartService(),
      child: MaterialApp(
        title: 'Doggobox',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF46D6F0),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
        ),
        home: const WelcomePage(),
        routes: {
          '/welcome': (context) => const WelcomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/cart': (context) => const CartPage(),
          '/profile': (context) => const ProfilePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/category') {
            final String categoryName = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => CategoryPage(categoryName: categoryName),
            );
          } else if (settings.name == '/details') {
            final Map<String, dynamic> product =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => DogFoodDetailsPage(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}
