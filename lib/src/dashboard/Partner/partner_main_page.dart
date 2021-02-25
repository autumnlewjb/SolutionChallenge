import 'package:flutter/cupertino.dart';
import 'package:return_med/src/Dashboard/Pages/history.dart';
import 'package:flutter/material.dart';
import 'package:return_med/src/Dashboard/Pages/profile.dart';
import 'package:return_med/src/Services/auth.dart';
import 'package:provider/provider.dart';

class PMainpage extends StatefulWidget {
  @override
  _PMainpageState createState() => _PMainpageState();
}

class _PMainpageState extends State<PMainpage> {
  double _icon1YOffSet = 0;

  double _icon2YOffSet = -75;

  double _icon3YOffSet = -90;

  bool isPressed = true;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
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
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Profile()));
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
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new History()));
              },
              icon: Icon(Icons.history),
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
            elevation: 0.0,
            child: new Icon(Icons.menu),
            backgroundColor: Colors.deepPurple,
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          color: Colors.deepPurple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Partner Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.white70,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/icon.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
