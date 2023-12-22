import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_subm_1/shared/themes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login-page', (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: Container(
          width: 155,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ic_resto.png'),
            ),
          ),
        ),
      ),
    );
  }
}
