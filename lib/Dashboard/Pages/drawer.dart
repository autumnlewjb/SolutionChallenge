import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/Dashboard/Pages/History.dart';
import 'package:return_med/Dashboard/Pages/claimed_reward.dart';
import '../../auth.dart';
import '../../database.dart';
import 'profile.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  String username = "";
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await Auth().signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/icon.png"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '$username',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple[300], Colors.deepPurple[600]])),
          ),
          ListTile(
              title: Text('Profile'),
              leading: Icon(
                Icons.people_rounded,
                color: Colors.deepPurple,
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Profile()));
              }),
          ListTile(
              title: Text('Claimed reward'),
              leading: Icon(
                Icons.card_giftcard_rounded,
                color: Colors.deepPurple,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ClaimedReward()));
              }),
          ListTile(
              title: Text('History'),
              leading: Icon(
                Icons.history,
                color: Colors.deepPurple,
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new History()));
              }),
          ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
              color: Colors.deepPurple,
            ),
            onTap: () {
              _showMyDialog();
            },
          ),
        ],
      ),
    );
  }

  void _getUser() async {
    var doc = await Database.getUser(FirebaseAuth.instance.currentUser.uid);
    setState(() {
      username = doc.data()['username'];
    });
  }
}
