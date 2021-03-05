import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/dashboard/pages/claimed_reward.dart';
import 'package:return_med/src/dashboard/pages/history.dart';
import 'package:return_med/src/models/user.dart';

import '../../Services/auth.dart';
import 'profile.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                await this.context.read<Auth>().signOut();
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
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Consumer<AppUser>(builder: (_, user, __) {
                    print(user.photoUrl);
                    return Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: user.photoUrl,
                          placeholder: (context, builder) =>
                              CircularProgressIndicator(),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 45,
                            backgroundImage: imageProvider,
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage("assets/icon.png"),
                          ),
                        )
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                Consumer<AppUser>(
                  builder: (_, user, __) {
                    return Text(
                      '${user?.username}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                )
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple[300], Colors.deepPurple[600]])),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
                title: Text('Profile'),
                leading: Icon(
                  Icons.people_rounded,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Profile()));
                }),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
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
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
                title: Text('History'),
                leading: Icon(
                  Icons.history,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new History()));
                }),
          ),
          Expanded(child: Container()),
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
}
