import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:return_med/auth.dart';
import 'package:return_med/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = FirebaseAuth.instance.currentUser;
  String username = FirebaseAuth.instance.currentUser.displayName;
  String email = FirebaseAuth.instance.currentUser.email;
  int reward = 10;
  var exist;

  @override
  void initState() {
    super.initState();
    _getUser(FirebaseAuth.instance.currentUser.uid);
  }

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
            height: 10.0,
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
                    fontSize: 20.0,
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
            indent: 40.0,
            endIndent: 40.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.green,
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Username:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' $username',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' $email',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Reward:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' $reward',
                        style: TextStyle(fontSize: 14.0),
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

  _showModalBottomSheet(context) {
    final firstNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    final address1Ctrl = TextEditingController();
    final address2Ctrl = TextEditingController();
    final postCodeCtrl = TextEditingController();

    List states = [
      "Johor",
      "Kedah",
      "Kelantan",
      "Melaka",
      "Negeri Sembilan",
      "Pahang",
      "Penang",
      "Perak",
      "Perlis",
      "Sabah",
      "Sarawak",
      "Selangor",
      "Terengganu"
    ];
    String state;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  child: Wrap(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Hello New Guy!",
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: firstNameCtrl,
                            obscureText: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'First name',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: lastNameCtrl,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Last name'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 70,
                    child: TextField(
                      controller: address1Ctrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Address line 1'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 70,
                    child: TextField(
                      controller: address2Ctrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Address line 2'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField(
                        isExpanded: true,
                        hint: Text('Choose state'),
                        value: state,
                        onChanged: (newState) {
                          setState(() {
                            state = newState;
                          });
                        },
                        items: states.map((valueItems) {
                          return DropdownMenuItem(
                            value: valueItems,
                            child: Text(valueItems),
                          );
                        }).toList()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 70,
                    child: TextField(
                      controller: postCodeCtrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Post code'),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          AppUser appUser = AppUser(
                              firstNameCtrl.text,
                              lastNameCtrl.text,
                              username,
                              email,
                              address1Ctrl.text,
                              address2Ctrl.text,
                              state,
                              postCodeCtrl.text);
                          await Auth().addUser(
                              FirebaseAuth.instance.currentUser.uid, appUser);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )));
        });
  }

  _getUser(String uid) async {
    DocumentSnapshot snapshot = await Auth().userExist(uid);
    if (snapshot == null) {
      _showModalBottomSheet(context);
    } else {
      setState(() {
        username = snapshot.data()['username'];
      });
    }
  }
}
