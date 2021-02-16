import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:return_med/auth.dart';
import 'package:return_med/database.dart';
import 'package:return_med/user.dart';
import 'package:return_med/Dashboard/Pages/drawer.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 15, 10),
            child: FlatButton(
              onPressed: () async {
                await Auth().signOut();
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
        ],
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
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: Center(
                      child: Text(
                        'Welcome to Return Med',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Do you have any disposable medicine?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: Text(
                          "This is where you can start to dispose of your medicine without any worries",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        icon: Icon(Icons.people_rounded),
                        label: Text("Go to profile"),
                        color: Colors.lightGreen[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.question_answer_rounded),
                        label: Text("Need help?"),
                        color: Colors.lightGreen[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Steps to be taken",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 40, backgroundImage: AssetImage("")),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Image 1")
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 40, backgroundImage: AssetImage("")),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Image 2")
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 40, backgroundImage: AssetImage("")),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Image 3")
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[200],
                      Colors.green[400],
                      Colors.green
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20)),
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
    final _formKey = GlobalKey<FormState>();

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
      enableDrag: false,
      isDismissible: false,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Wrap(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "Hello New Guy!",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Cannot leave blank';
                              }
                              return null;
                            },
                            controller: firstNameCtrl,
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'First name',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Cannot leave blank';
                              }
                              return null;
                            },
                            controller: lastNameCtrl,
                            obscureText: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
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
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Cannot leave blank';
                        }
                        return null;
                      },
                      controller: address1Ctrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Address line 1'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Cannot leave blank';
                        }
                        return null;
                      },
                      controller: address2Ctrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Address line 2'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField(
                        validator: (choice) {
                          if (choice == null) {
                            return "Please select your state";
                          }
                          return null;
                        },
                        isExpanded: true,
                        decoration: InputDecoration.collapsed(hintText: ''),
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
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Cannot leave blank';
                        }
                        return null;
                      },
                      controller: postCodeCtrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Post code'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            AppUser appUser = AppUser(
                                firstNameCtrl.text,
                                lastNameCtrl.text,
                                username,
                                email,
                                address1Ctrl.text,
                                address2Ctrl.text,
                                state,
                                postCodeCtrl.text);
                            await Database.addUser(
                                FirebaseAuth.instance.currentUser.uid, appUser);
                            Navigator.pop(context);
                          }
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
              ),
            ),
          ),
        );
      },
    );
  }

  _getUser(String uid) async {
    DocumentSnapshot snapshot = await Database.userExist(uid);

    if (snapshot == null) {
      _showModalBottomSheet(context);
    } else {
      setState(() {
        username = snapshot.data()['username'];
      });
    }

    // if (snapshot != null) {
    //   setState(() {
    //     username = snapshot.data()['username'];
    //   });
    // }
    // _showModalBottomSheet(context);
  }
}
