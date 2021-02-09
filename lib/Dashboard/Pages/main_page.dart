import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:return_med/auth.dart';
import 'package:return_med/user.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, "/");
                      },
                      child: Text("Logout"),
                      color: Colors.green[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Hello there',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
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
      },
    );
  }

  _getUser(String uid) async {
    DocumentSnapshot snapshot = await Auth().userExist(uid);
    // TODO JBLew change the code after debugging

    // if (snapshot == null) {
    //   _showModalBottomSheet(context);
    // } else {
    //   setState(() {
    //     username = snapshot.data()['username'];
    //   });
    // }

    if (snapshot != null) {
      setState(() {
        username = snapshot.data()['username'];
      });
    }
    _showModalBottomSheet(context);
  }
}
