import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> with AutomaticKeepAliveClientMixin {
  ConfettiController control;
  int reward;
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

  void dispose(){
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
          print("has data");
          reward = snapshot.data.data()['reward_points'];
          return _showList();
        });
  }

  Widget _showList() {
    return Scaffold(
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
        padding: const EdgeInsets.all(30.0),
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
                minimumSize: const Size(10,10),
                maximumSize: const Size(40,40),
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
            Expanded(
                child: ListView.builder(
                    itemCount: _allHospitals?.length ?? 0,
                    itemBuilder: (context, i) {
                      return _orgList(
                          _allHospitals[i].data()['name'], _allHospitals[i]);
                    }))
          ],
        ),
      ),
    );
  }

  // list hospitals
  Widget _orgList(String a, [DocumentSnapshot hospital]) {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: Colors.amberAccent),
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
                    primary: Colors.red, onPrimary: Colors.white),
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
        ));
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setter) {
              return ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = _services[index].data();
                  return _rewardList(data['title'], data['cost']);
                },
              );
            }),
          );
        });
  }

  //The widget build for every rewards which are the same
  //String a for the name and int b for the points needed
  Widget _rewardList(String a, int b) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.rectangle, color: Colors.amberAccent),
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
                  primary: Colors.red, onPrimary: Colors.white),
              onPressed: reward >= b ? () => press(b) : null,
              child: Text(
                'Claim',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void press(int a) {
    //To deduct the reward points after claiming
    if (reward >= a) {
      setState(() {
        reward -= a;
        var data = {"reward_points": reward};
        control.play();
        Database.updateUser(FirebaseAuth.instance.currentUser.uid, data);
      });
    }
  }

  void _getHospitals() async {
    List<DocumentSnapshot> temp = await Database.getAllHospitals();
    setState(() {
      _allHospitals = temp;
    });
  }

  @override
  bool get wantKeepAlive => false;
}
