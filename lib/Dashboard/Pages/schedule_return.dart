import 'package:flutter/material.dart';

class ScheduleReturn extends StatefulWidget {
  @override
  _ScheduleReturnState createState() => _ScheduleReturnState();
}

class _ScheduleReturnState extends State<ScheduleReturn> {
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
            child: Text("THIS IS SCHEDULE RETURN PAGE"),
          ),
        ),
      ),
    );
  }
}
