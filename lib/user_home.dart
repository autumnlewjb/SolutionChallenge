import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  var _backgroundColor = [
    Colors.green[200],
    Colors.green[300],
    Colors.green[500]
  ];
  final _firebase_instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[300],
        body: Container(
          child: ElevatedButton(
            child: Text("Log Out"),
            style: ElevatedButton.styleFrom(primary: Colors.transparent),
            onPressed: () async {
              await _firebase_instance.signOut();
              print(FirebaseAuth.instance.currentUser);
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topRight,
        ),
      ),
    );
  }
}
