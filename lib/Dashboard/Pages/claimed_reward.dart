import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/user.dart';
import 'package:return_med/Models/user_reward.dart';

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
          child: Center(child: Consumer<AppUser>(
            builder: (_, user, __) {
              return StreamBuilder<List<UserReward>>(
                stream: user.reward,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data.isEmpty) {
                    return Text("Haven't claimed any reward.");
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      UserReward reward = snapshot.data[index];
                      return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(reward.title),
                            subtitle: Text(reward.description),
                          ));
                    },
                  );
                },
              );
            },
          ))),
    );
  }
}
