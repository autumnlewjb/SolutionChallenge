import 'package:flutter/material.dart';

class HistoryAndReward extends StatefulWidget {
  @override
  _HistoryAndRewardState createState() => _HistoryAndRewardState();
}

class _HistoryAndRewardState extends State<HistoryAndReward> {
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
            child: Text("THIS IS HISTORY AND REWARD PAGE"),
          ),
        ),
      ),
    );
  }
}
