import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/Models/user.dart';
import 'package:return_med/src/Models/user_reward.dart';
import 'package:return_med/src/Services/database.dart';

class ClaimedReward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          'Claimed Reward',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepPurple,
              Colors.deepPurple[400],
              Colors.deepPurple[300],
              Colors.deepPurple[200]
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Center(
              child: StreamBuilder<List<UserReward>>(
            stream: Database.getClaimedReward(context.read<AppUser>().uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                List<UserReward> rewardList = snapshot.data;
                if (rewardList.isEmpty) {
                  return Text(
                    "Haven't claimed any reward.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  );
                }
                return ListView.builder(
                  itemCount: rewardList.length,
                  itemBuilder: (context, index) {
                    UserReward reward = rewardList[index];
                    return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(reward.title),
                          subtitle: Text(reward.description),
                        ));
                  },
                );
              }
              return Text('Something went wrong');
            },
          ))),
    );
  }
}
