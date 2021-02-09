import 'package:flutter/material.dart';

class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  var _backgroundColor = [
    Colors.green[200],
    Colors.green[300],
    Colors.green[500]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _backgroundColor,
            )),
        child: Container(
          child: Center(
            child: Text("THIS IS ONGOING RETURN PAGE"),
          ),
        ),
      ),
    );
  }
}
