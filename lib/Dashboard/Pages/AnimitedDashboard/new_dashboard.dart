import 'package:flutter/material.dart';
import 'package:return_med/Dashboard/Pages/AnimitedDashboard/drawerscreen.dart';
import 'package:return_med/Dashboard/Pages/AnimitedDashboard/main_screen.dart';

class AnimatedDashboard extends StatefulWidget {
  @override
  _AnimatedDashboardState createState() => _AnimatedDashboardState();
}

class _AnimatedDashboardState extends State<AnimatedDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MainScreen(),
          DrawerScreen(),
        ],
      ),
    );
  }
}
