import 'package:flutter/material.dart';
import 'package:flutter_subm_1/ui/pages/home_tab_page.dart';
import 'package:flutter_subm_1/ui/pages/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomeTabPage(),
      },
    );
  }
}
