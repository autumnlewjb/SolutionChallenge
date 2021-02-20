import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';
import 'package:shimmer/shimmer.dart';

import 'drawer.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> with AutomaticKeepAliveClientMixin {
  ConfettiController control;
  var reward;
  Stream<DocumentSnapshot> _stream =
      Database.getUserStream(FirebaseAuth.instance.currentUser.uid);
  List<DocumentSnapshot> _allHospitals;
  List<DocumentSnapshot> _services;

  @override
  void initState() {
    control = ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
    _getHospitals();
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: _stream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("You're not registered."),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          reward = snapshot.data.data()['reward_points'].toInt();
          if (snapshot.connectionState == ConnectionState.active) {
            return _showList();
          }
        });
  }

  Widget _showList() {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Text(
          'Return Med',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reward',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Point(s): $reward',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: control,
                blastDirectionality: BlastDirectionality.explosive,
                minimumSize: const Size(10, 10),
                maximumSize: const Size(40, 40),
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                  Colors.yellow,
                  Colors.red,
                ], // manually specify the colors to be used
              ),
            ),
            Expanded(child: _showHospitals())
          ],
        ),
      ),
    );
  }

  Widget _showHospitals() {
    if (_allHospitals != null) {
      return ListView.builder(
          itemCount: _allHospitals?.length ?? 0,
          itemBuilder: (context, i) {
            return _orgList(_allHospitals[i].data()['name'], _allHospitals[i]);
          });
    } else {
      return Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[300],
          period: Duration(milliseconds: 1000),
          child: ListView(physics: NeverScrollableScrollPhysics(), children: [
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.indigo[200]),
                height: 260,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.indigo[200]),
                height: 260,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.indigo[200]),
                height: 260,
              ),
            )
          ]));
    }
  }

  // list hospitals
  //Later add a new String parameter for the image
  Widget _orgList(String a, [DocumentSnapshot hospital]) {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: AssetImage('assets/HSB.jpg'),
                  //later change the parameter accepted inside for different hospitals images
                  fit: BoxFit.fill,
                  height: 250,
                ),
              ),
              Divider(
                height: 5,
                thickness: 2.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.indigo[100]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$a',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple[200], onPrimary: Colors.white),
                      onPressed: () async {
                        _services = await Database.getServices(hospital.id);
                        _showModalBottomSheet();
                      },
                      child: Text(
                        'Show More',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0,)
            ],
          ),
        );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setter) {
              return ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = _services[index].data();
                  return _rewardList(
                      data['title'], data['cost'], _services[index].reference);
                },
              );
            }),
          );
        });
  }

  //The widget build for every rewards which are the same
  //String a for the name and int b for the points needed
  //Later add a new String parameter for the image
  Widget _rewardList(String a, int b, DocumentReference reference) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage("assets/mask.jpg"),
            //later change the parameter accepted inside for different reward images
            height: 200,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$a',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red, onPrimary: Colors.white),
                  onPressed: reward >= b ? () => press(b, reference) : null,
                  child: Text(
                    'Redeem ($b)',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void press(int a, DocumentReference reference) {
    //To deduct the reward points after claiming
    if (reward >= a) {
      setState(() {
        reward -= a;
        var data = {"reward_points": reward};
        control.play();
        Database.updateUser(FirebaseAuth.instance.currentUser.uid, data);
        Database.addClaimedReward(reference);
      });
      Navigator.pop(context);
    }
  }

  void _getHospitals() async {
    List<DocumentSnapshot> temp = await Database.getAllHospitals();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (this.mounted) {
        setState(() {
          _allHospitals = temp;
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => false;
}
