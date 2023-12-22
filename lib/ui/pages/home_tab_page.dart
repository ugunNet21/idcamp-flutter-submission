import 'package:flutter/material.dart';
import 'package:flutter_subm_1/shared/themes.dart';
import 'package:flutter_subm_1/ui/pages/account_page.dart';
import 'package:flutter_subm_1/ui/pages/chat_page.dart';
import 'package:flutter_subm_1/ui/pages/dashboard_page.dart';
import 'package:flutter_subm_1/ui/pages/order_page.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
     HomeDashboardPage(),
    const ChatPage(),
    const OrderRestaurantPage(),
    const AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
          elevation: 0,
          selectedItemColor: orangeColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          selectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          unselectedLabelStyle: orangeTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: blackColor),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: blackColor),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes, color: blackColor),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: blackColor),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
