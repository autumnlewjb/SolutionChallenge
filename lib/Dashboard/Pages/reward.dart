import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/available_reward.dart';
import 'package:return_med/Models/hospital.dart';
import 'package:return_med/Models/user.dart';
import 'package:return_med/database.dart';

import 'drawer.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> with AutomaticKeepAliveClientMixin {
  ConfettiController control;
  var reward;
  List<AvailableReward> _services;

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
                Consumer<AppUser>(builder: (_, user, __) {
                  reward = int.parse(user?.rewardPoint);
                  return Text(
                    'Current Point(s): $reward',
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
            Expanded(child: Consumer<List<Hospital>>(
              builder: (_, hospitalList, __) {
                return ListView.builder(
                    itemCount: hospitalList?.length ?? 0,
                    itemBuilder: (context, i) {
                      return _orgList(hospitalList[i].name, hospitalList[i]);
                    });
              },
            ))
          ],
        ),
      ),
    );
  }

  // list hospitals
  //Later add a new String parameter for the image
  Widget _orgList(String a, Hospital hospital) {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: Colors.indigo[200]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/HSB.jpg'),
                //later change the parameter accepted inside for different hospitals images
                fit: BoxFit.fill,
                height: 250,
              ),
              Divider(
                height: 10,
                thickness: 2.0,
              ),
              Row(
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
                      //_services =hospital.reward;
                      _showModalBottomSheet();
                    },
                    child: Text(
                      'Show More',
                    ),
                  ),
                ],
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
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setter) {
              return Consumer<List<AvailableReward>>(builder: (_, reward, __) {
                return ListView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: reward?.length,
                  itemBuilder: (context, index) {
                    return _rewardList(reward[index]?.title,
                        reward[index]?.cost /*, _services[index].id*/);
                  },
                );
              });
            }),
          );
        });
  }

  //The widget build for every rewards which are the same
  //String a for the name and int b for the points needed
  //Later add a new String parameter for the image
  Widget _rewardList(String a, int b /*, DocumentReference reference*/) {
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
                  onPressed:
                      reward >= b ? () => press(b /*, reference*/) : null,
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

  void press(int a /*, DocumentReference reference*/) {
    //To deduct the reward points after claiming
    if (reward >= a) {
      setState(() {
        reward -= a;
        var data = {"reward_points": reward};
        control.play();
        Database.updateUser(context.read<AppUser>().uid, data);
        //Database.addClaimedReward(reference);
      });
      Navigator.pop(context);
    }
  }

  @override
  bool get wantKeepAlive => false;
}
