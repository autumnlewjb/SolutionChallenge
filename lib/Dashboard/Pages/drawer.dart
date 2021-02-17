import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/Dashboard/Pages/claimed_reward.dart';
import 'profile.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(0,20,0,20),
            child: Column(
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/icon.png"),
                  ),
                ),
                SizedBox(height: 15,),
                Text('USERNAME',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple[300], Colors.deepPurple[600]])),
          ),
          ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.people_rounded,color: Colors.deepPurple,),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Profile()));
              }),
          ListTile(
              title: Text('Claimed reward'),
              leading: Icon(Icons.card_giftcard_rounded,color: Colors.deepPurple,),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new ClaimedReward()));
              }),
          ListTile(
            title: Text('This is tile 3'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
