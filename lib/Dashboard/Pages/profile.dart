import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> user;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.3,
            child: Stack(children: [
              Container(
                width: width,
                height: height * 0.3 - 50,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.deepPurple[300],
                    Colors.deepPurple[400],
                    Colors.deepPurple,
                    Colors.deepPurple[600]
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 50,
                        color: Colors.grey.withOpacity(0.5))
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage("assets/icon.png"),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 40,
                child: Container(
                    height: 80,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 50,
                              color: Colors.grey.withOpacity(0.5))
                        ]),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.terrain_rounded),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              _getInfo('username'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.card_giftcard_rounded),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              _getInfo('reward_points'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                      ],
                    ))),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(30),
            width: width,
            height: height * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 50,
                    color: Colors.grey.withOpacity(0.5))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 20,
                      ),
                      SizedBox(
                        width: width * 0.075,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FIRST NAME",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            _getInfo('first_name'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LAST NAME",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            _getInfo('last_name'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.email_rounded,
                      size: 20,
                    ),
                    SizedBox(
                      width: width * 0.075,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EMAIL ADDRESS",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          _getInfo('email'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.house_rounded,
                      size: 20,
                    ),
                    SizedBox(
                      width: width * 0.075,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ADDRESS",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "${_getInfo('address1')}\n${_getInfo('address2')}\n${_getInfo('postcode')} ${_getInfo('state')}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getInfo(String field) {
    return user == null ? "Not set" : "${user[field]}";
  }

  void _getUser() async {
    var doc = await Database.getUser(FirebaseAuth.instance.currentUser.uid);
    setState(() {
      user = doc.data();
    });
  }
}
