import 'package:flutter/material.dart';

// Auth Screens
import '../views/auth/login_screen.dart';
import '../views/auth/signup_screen.dart';

// Home & Search Screens
import '../views/home/home_screen.dart';
import '../views/search/search_screen.dart';

// Product Screens
import '../views/product/product_list_screen.dart';
import '../views/product/product_detail_screen.dart';

// Cart & Checkout Screens
import '../views/cart/cart_screen.dart';
import '../views/checkout/checkout_screen.dart';

// Profile Screen
import '../views/profile/profile_screen.dart';
import '../views/profile/orders_screen.dart';
import '../views/profile/wishlist_screen.dart';
import '../views/profile/addresses_screen.dart';
import '../views/profile/notifications_screen.dart';

class Routes {
  // Route Names
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String productList = '/products';
  static const String productDetail = '/productDetail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String orders = '/orders';
  static const String wishlist = '/wishlist';
  static const String addresses = '/addresses';
  static const String notifications = '/notifications';

  // Routes Map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      signup: (context) => const SignupScreen(),
      home: (context) => const HomeScreen(),
      productList: (context) => const ProductListScreen(),
      productDetail: (context) => const ProductDetailScreen(),
      cart: (context) => const CartScreen(),
      checkout: (context) => const CheckoutScreen(),
      profile: (context) => const ProfileScreen(),
      search: (context) => const SearchScreen(),
      orders: (context) => const OrdersScreen(),
      wishlist: (context) => const WishlistScreen(),
      addresses: (context) => const AddressesScreen(),
      notifications: (context) => const NotificationsScreen(),
    };
  }
}