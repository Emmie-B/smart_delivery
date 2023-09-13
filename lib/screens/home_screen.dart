import 'package:e_delivery/constants.dart';
import 'package:e_delivery/screens/orders.dart';
import 'package:e_delivery/screens/settings.dart';
import 'package:e_delivery/screens/track_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  void _onTappedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static List screens = [const TrackScreen(), const OrderScreen(), const SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          // backgroundColor: kTextColor,
          selectedItemColor: kPrimaryColor,
          elevation: 0,
          onTap: _onTappedItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Track',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ]),
    );
  }
}
