import 'package:e_delivery/screens/settings.dart';
import 'package:e_delivery/screens/track_screen.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NewWidget();
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Todo'),
                  Tab(text: 'Completed'),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TrackScreen(),
            TrackScreen(),
          ],
        ),
      ),
    );
  }
}
