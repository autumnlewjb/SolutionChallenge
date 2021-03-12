import 'package:flutter/material.dart';
import 'package:return_med/src/patient/pages/reward.dart';

import 'Pages/main_page.dart';
import 'Pages/ongoing_return.dart';
import 'Pages/schedule_return.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final pageController = PageController();
  List<Widget> _screen = [MainPage(), ScheduleReturn(), Ongoing(), Reward()];

  List isSelected = [true, false, false, false];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: _screen,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: isSelected[0] ? Colors.deepPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.home_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: isSelected[1] ? Colors.deepPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.timer),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: isSelected[2] ? Colors.deepPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.trending_up),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: isSelected[3] ? Colors.deepPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.card_giftcard_rounded),
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          setState(() {
            pageController.jumpToPage(index);
            currentIndex = index;
            for (int i = 0; i < 4; i++) {
              isSelected[i] = false;
              if (i == currentIndex) {
                isSelected[i] = true;
              }
            }
          });
        },
      ),
    );
  }
}
