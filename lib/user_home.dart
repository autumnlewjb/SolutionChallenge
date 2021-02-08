import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = FirebaseAuth.instance.currentUser;
  String username = FirebaseAuth.instance.currentUser.displayName;
  String email = FirebaseAuth.instance.currentUser.email;
  int reward = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {},
          child: Text(
            'Return Med',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.green[400],
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text('Schedule Return')),
              PopupMenuItem(value: 2, child: Text('Ongoing Returns')),
              PopupMenuItem(value: 3, child: Text('History')),
              PopupMenuItem(value: 4, child: Text('Reward')),
              PopupMenuItem(value: 5, child: Text('Log Out')),
            ],
            onSelected: (option) async {
              if (option == 5) {
                await FirebaseAuth.instance.signOut();
                print(FirebaseAuth.instance.currentUser);
                Navigator.pushReplacementNamed(context, "/");
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          CircleAvatar(
            child: Icon(
              Icons.assignment_ind,
              size: 70.0,
            ),
            radius: 50.0,
            backgroundColor: Colors.green[500],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome,
              ),
              Expanded(
                child: Text(
                  'Welcome $username',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.auto_awesome,
              ),
            ],
          ),
          Divider(
            height: 2.0,
            color: Colors.lightGreenAccent,
            thickness: 2.0,
          ),
          Container(
            padding: EdgeInsets.all(50.0),
            color: Colors.green,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Username:',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' $username',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' $email',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Reward:',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' $reward',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.assistant),
        backgroundColor: Colors.green,
      ),
    );
  }
}
