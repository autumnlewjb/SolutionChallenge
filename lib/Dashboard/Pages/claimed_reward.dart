import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';

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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: Database.claimedRewardDB
                  .orderBy('timeClaimed', descending: true)
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data.size == 0) {
                  return Text("Haven't claimed any reward.");
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<DocumentSnapshot>(
                          stream: Database.getRewardDetails(
                              snapshot.data.docs[index].data()['hospitalId'],
                              snapshot.data.docs[index].data()['rewardId']),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Card(
                                elevation: 5,
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  title: Text(snapshot.data.data()['title']),
                                  subtitle: Text(
                                      snapshot.data.data()['description'] ??
                                          ''),
                                ));
                          });
                    });
              })),
    );
  }
}
