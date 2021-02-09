import 'package:flutter/material.dart';
import 'Pages/history_and_reward.dart';
import 'Pages/main_page.dart';
import 'Pages/ongoing_return.dart';
import 'Pages/schedule_return.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List _screen = [
    MainPage(),
    ScheduleReturn(),
    Ongoing(),
    HistoryAndReward()
  ];

  List isSelected = [true, false, false, false];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[currentIndex],
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
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 16
              ),
              decoration: BoxDecoration(
                color: isSelected[0] ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(Icons.home_rounded),
            ),
            title: Text(''),
          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16
              ),
              decoration: BoxDecoration(
                  color: isSelected[1] ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(Icons.assignment_return_rounded),
            ),
            title: Text(''),
          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16
              ),
              decoration: BoxDecoration(
                  color: isSelected[2] ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(Icons.arrow_back_rounded),
            ),
            title: Text(''),
          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16
              ),
              decoration: BoxDecoration(
                  color: isSelected[3] ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(Icons.card_giftcard_rounded),
            ),
            title: Text(''),
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
            for (int i = 0; i < 4; i ++){
              isSelected[i] = false;
              if (i == currentIndex){
                isSelected[i] = true;
              }
            }
          });
        },
      ),
    );
  }
}
