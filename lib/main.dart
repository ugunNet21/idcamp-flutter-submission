import 'package:flutter/material.dart';
import 'package:flutter_subm_1/ui/pages/account_page.dart';
import 'package:flutter_subm_1/ui/pages/home_tab_page.dart';
import 'package:flutter_subm_1/ui/pages/login_page.dart';
import 'package:flutter_subm_1/ui/pages/restaurant_detail.dart';
import 'package:flutter_subm_1/ui/pages/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

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
        '/restaurant-detail': (context) =>  RestaurantDetailPage(),
        // '/restaurant-list': (context) => const RestaurantList(),
      },
    );
  }
}
