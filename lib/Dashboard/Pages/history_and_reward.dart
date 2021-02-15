import 'package:flutter/material.dart';

class HistoryAndReward extends StatefulWidget {
  @override
  _HistoryAndRewardState createState() => _HistoryAndRewardState();
}

class _HistoryAndRewardState extends State<HistoryAndReward> {
  @override
  int reward=10;

  Widget build(BuildContext context) {
    //To deduct the reward points after claiming
    void Press(int a){
      if (reward>=a){
        setState(() {
          return reward-=a;
        });
      }
    }

    //The widget build for every rewards which are the same
    //String a for the name and int b for the points needed
    rewardList (String a,int b){
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amberAccent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$a ($b)',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white
              ),
              onPressed: reward>=b? () => Press(b) : null,
              child: Text(
                'Claim',
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Return Med',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reward',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Point(s): $reward',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height:20.0),
            rewardList("AAA", 5),
            SizedBox(height:20.0),
            rewardList("BBB", 2),
            SizedBox(height:20.0),
            rewardList("CCC", 3),
          ],
        ),
      ),
    );
  }
}
