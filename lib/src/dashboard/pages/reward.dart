import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/Models/available_reward.dart';
import 'package:return_med/src/Models/hospital.dart';
import 'package:return_med/src/Models/user.dart';
import 'package:return_med/src/Services/database.dart';
import 'package:shimmer/shimmer.dart';

import 'drawer.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> with AutomaticKeepAliveClientMixin {
  ConfettiController control;
  var rewardPoint;

  @override
  void initState() {
    control = ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Text(
          'Reward Collection',
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
                Consumer<AppUser>(builder: (_, user, __) {
                  this.rewardPoint = user?.rewardPoint;
                  return Text(
                    'Current Point(s): $rewardPoint',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  );
                }),
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
    return StreamBuilder<List<Hospital>>(
      stream: Database.getHospitals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[200],
              highlightColor: Colors.grey[300],
              period: Duration(milliseconds: 1000),
              child:
                  ListView(physics: NeverScrollableScrollPhysics(), children: [
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
        if (snapshot.hasData) {
          List<Hospital> hospitalList = snapshot.data;
          if (hospitalList.isEmpty) {
            return Text('No hospital is offering rewards');
          }
          return ListView.builder(
              itemCount: hospitalList.length,
              itemBuilder: (context, i) {
                return _orgList(hospitalList[i]);
              });
        }
        return Text('Something went wrong');
      },
    );
  }

  // list hospitals
  //Later add a new String parameter for the image
  Widget _orgList(Hospital hospital) {
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
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.indigo[100]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${hospital.name}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, onPrimary: Colors.white),
                  onPressed: () async {
                    _showModalBottomSheet(hospital);
                  },
                  child: Text(
                    'Show More',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  _showModalBottomSheet(Hospital hospital) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
              ),
              child: Center(
                child: FutureBuilder<List<AvailableReward>>(
                    future: Database.getAvailableReward(hospital.reference.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        List<AvailableReward> rewardList = snapshot.data;
                        if (rewardList.isEmpty) {
                          return Text('No available rewards');
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(20.0),
                          itemCount: rewardList.length,
                          itemBuilder: (context, index) {
                            return _rewardList(rewardList[index]);
                          },
                        );
                      }
                      return Text('Something went wrong');
                    }),
              ));
        });
  }

  //The widget build for every rewards which are the same
  //Later add a new String parameter for the image
  Widget _rewardList(AvailableReward reward) {
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
                  '${reward.title}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red, onPrimary: Colors.white),
                  onPressed:
                      rewardPoint >= reward.cost ? () => press(reward) : null,
                  child: Text(
                    'Redeem (${reward.cost})',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //To deduct the reward points after claiming
  void press(AvailableReward reward) {
    final uid = context.read<AppUser>().uid;
    rewardPoint -= reward.cost;
    var data = {"reward_points": rewardPoint};
    control.play();
    Database.updateUser(uid, data)
        .then((_) => Database.addClaimedReward(uid, reward));
    Navigator.pop(context);
  }

  @override
  bool get wantKeepAlive => true;
}
