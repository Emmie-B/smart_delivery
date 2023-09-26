import 'package:e_delivery/constants.dart';
import 'package:e_delivery/screens/dashboard.dart';
import 'package:e_delivery/screens/orders.dart';
import 'package:e_delivery/screens/settings.dart';
import 'package:e_delivery/screens/track_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.args});

  var args;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void _onTappedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static List screens = [
    const DashBoardScreen(),
    const OrderScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            backgroundColor: kWhiteColor,
            currentIndex: selectedIndex,
            selectedItemColor: kPrimeColor,
            unselectedItemColor: kPrimaryColor,
            elevation: 0,
            onTap: _onTappedItem,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
