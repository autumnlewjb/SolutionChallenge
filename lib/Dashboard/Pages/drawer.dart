import 'package:flutter/material.dart';

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
            child: Text(
              "THIS IS THE HEADER"
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[500], Colors.green[800]]
              )
            ),
          ),
          ListTile(
            title: Text('This is tile 1'),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('This is tile 2'),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('This is tile 3'),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
