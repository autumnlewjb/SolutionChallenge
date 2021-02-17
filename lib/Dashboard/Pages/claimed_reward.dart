import 'package:flutter/material.dart';

class ClaimedReward extends StatefulWidget {
  @override
  _ClaimedRewardState createState() => _ClaimedRewardState();
}

class _ClaimedRewardState extends State<ClaimedReward> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        title: Text(
          'Claimed Reward',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
