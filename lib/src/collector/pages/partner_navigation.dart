import 'package:flutter/cupertino.dart';
import 'package:return_med/src/collector/pages/available_return.dart';
import 'package:flutter/material.dart';
import 'package:return_med/src/patient/pages/profile.dart';
import 'package:return_med/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/collector/pages/main_page.dart';
import 'drawer.dart';

class PartnerNavigation extends StatefulWidget {
  @override
  _PartnerNavigationState createState() => _PartnerNavigationState();
}

class _PartnerNavigationState extends State<PartnerNavigation> {
  double _icon1YOffSet = 0;

  double _icon2YOffSet = -75;

  double _icon3YOffSet = -90;

  bool isPressed = false;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ListBody(
              children: <Widget>[
                Text('Do you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await this.context.read<Auth>().signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (isPressed) {
      case true:
        _icon1YOffSet = -30;

        _icon2YOffSet = -20;

        _icon3YOffSet = -10;
        break;

      case false:
        _icon1YOffSet = 165;

        _icon2YOffSet = 110;

        _icon3YOffSet = 55;
        break;
    }

    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              curve: Curves.bounceOut,
              width: 55,
              height: 55,
              transform: Matrix4.translationValues(0, _icon1YOffSet, 1),
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 50,
                        color: Colors.grey.withOpacity(0.4))
                  ],
                  color: Colors.indigo[600],
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Profile()));
                },
                icon: Icon(Icons.people),
                color: Colors.white,
              ),
            ),
            AnimatedContainer(
              curve: Curves.bounceOut,
              width: 55,
              height: 55,
              transform: Matrix4.translationValues(0, _icon2YOffSet, 1),
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 50,
                        color: Colors.grey.withOpacity(0.4))
                  ],
                  color: Colors.indigo[600],
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new AvailableReturn()));
                },
                icon: Icon(Icons.public),
                color: Colors.white,
              ),
            ),
            AnimatedContainer(
              curve: Curves.bounceOut,
              width: 55,
              height: 55,
              transform: Matrix4.translationValues(0, _icon3YOffSet, 1),
              duration: Duration(milliseconds: 700),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 50,
                        color: Colors.grey.withOpacity(0.4))
                  ],
                  color: Colors.indigo[600],
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {
                  _showMyDialog();
                },
                icon: Icon(Icons.logout),
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  isPressed = !isPressed;
                });
              },
              elevation: 5,
              child: new Icon(Icons.menu),
              backgroundColor: Colors.deepPurple,
            )
          ],
        ),
        body: PartnerMainPage());
  }
}
