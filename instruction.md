You are an expert Flutter UI developer.
Build a frontend-only mobile app called DogFoodShop, using Flutter.
No backend, no API, no authentication — just mockup UI with placeholder/sample data.

📱 Pages to create (each as a separate widget file):

1. WelcomePage

Fullscreen hero image (dog + dog food theme)

App title: DogFoodShop

Big button: "Get Started" → navigates to LoginPage

#  LoginPage

Fields for Email and Password (UI only)

Buttons: "Login" → stays on login (UI only), "Register" → navigates to RegisterPage, "Continue as Guest" → navigates to HomePage

# RegisterPage

Fields for Name, Email, Password, Confirm Password (UI only)

"Register" button → navigates to HomePage after UI submission (no backend)

"Back to Login" link → navigates back to LoginPage

2. HomePage

AppBar with logo/title

Search bar at the top

Banner with promotional content

Horizontal scrolling categories list (e.g., Puppy, Adult, Organic, Grain-Free, etc.)

Product grid (image, name, price, “Add to Cart” button)

Bottom navigation bar with icons for Home, Categories, Cart, Profile

3. CategoryPage

AppBar showing category name

Displays filtered dog food items using the same product card design as HomePage

4. DogFoodDetailsPage

Large product image on top

Name, price, short description

Dropdown or buttons for size selection (1kg, 3kg, 5kg)

“Add to Cart” button (no actual functionality, just UI)

5. CartPage

List of cart items with image, name, price

Quantity selector ( + / – ) visually working (no backend update)

Subtotal, Delivery Fee, Total Amount (static placeholder values)

“Checkout” button (no functionality)

6. ProfilePage

User avatar (placeholder image)

Username & Email (static/mock)

Buttons: “Edit Profile”, “Order History”, “Logout” (no actions)

🛠️ Requirements:

Flutter latest stable version

Keep UI modern and clean (use padding, spacing, and consistent layout)

Use ListView, GridView, BottomNavigationBar

Create a bottom navigation bar for: Home, Categories, Cart, Profile

Use placeholder/mock data for products (static list or map)

7. Include these UI styling rules in your full DogFoodShop app:
Consistent color palette (#46D6F0, #FFFFFF, #000000)

Rounded buttons and cards

Modern, clean spacing

Proper typography

Highlighted primary actions (buttons, active tabs)

📂 Folder Structure:
lib/
  pages/
    welcome_page.dart
    home_page.dart
    category_page.dart
    dogfood_details_page.dart
    cart_page.dart
    profile_page.dart
  widgets/
    product_card.dart
    category_chip.dart

🔑 Output format:

Give full code for each page

Include reusable widgets (ProductCard, CategoryChip)

Minimal explanation — focus on UI code

Build the UI as if this app will present to a client for approval before backend integration.