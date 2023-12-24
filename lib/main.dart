import 'package:flutter/material.dart';
import 'package:flutter_subm_1/ui/pages/account_page.dart';
import 'package:flutter_subm_1/ui/pages/add_review_page.dart';
import 'package:flutter_subm_1/ui/pages/home_tab_page.dart';
import 'package:flutter_subm_1/ui/pages/login_page.dart';
import 'package:flutter_subm_1/ui/pages/restaurant_detail.dart';
import 'package:flutter_subm_1/ui/pages/search_page.dart';
import 'package:flutter_subm_1/ui/pages/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomeTabPage(),
        '/login-page': (context) => const LoginPage(),
        '/account-page': (context) => const AccountPage(),
        '/restaurant-detail': (context) => const RestaurantDetailPage(),
        '/restaurant-search': (context) => const RestaurantSearchPage(),
        '/add-review': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>;
          final String restaurantId = args['restaurantId'];
          return AddReviewPage(restaurantId: restaurantId);
        },
      },
    );
  }
}
