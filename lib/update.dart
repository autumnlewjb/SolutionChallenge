import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:return_med/auth.dart';
import 'package:return_med/user.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final String username = FirebaseAuth.instance.currentUser.displayName;
  final String email = FirebaseAuth.instance.currentUser.email;
  String state;
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

  // text controllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final address1Ctrl = TextEditingController();
  final address2Ctrl = TextEditingController();
  final postCodeCtrl = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Create a new account"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 45,
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
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
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
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
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
                height: 45,
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: SizedBox(),
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
                height: 45,
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
                      await Auth().createUser(
                          emailCtrl.text, passwordCtrl.text, appUser);
                      Navigator.pushNamed(context, "/userHome");
                    },
                    child: Text(
                      'Continue as $username',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
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
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, "/");
                    },
                    child: Text(
                      'Login with Another Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
