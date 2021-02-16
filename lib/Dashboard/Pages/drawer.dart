import 'package:flutter/material.dart';
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
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage: AssetImage(""),
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
            title: Text('This is tile 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
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
