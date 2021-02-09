import 'package:flutter/material.dart';
import 'package:return_med/auth.dart';
import 'package:return_med/user.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  final _formKey =  GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5),
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
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Cannot leave blank';
                      }
                      return null;
                    },
                    controller: emailCtrl,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email'),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Cannot leave blank';
                      }
                      return null;
                    },
                    controller: usernameCtrl,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.people_alt_rounded),
                        labelText: 'Username'),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  child: TextFormField(
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Cannot leave blank';
                      }
                      else if (password.length < 8){
                        return "Password must be more than 8 characters";
                      }
                      return null;
                    },
                    controller: passwordCtrl,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
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
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField(
                    validator: (choice){
                      if (choice == null){
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Cannot leave blank';
                      }
                      return null;
                    },
                    controller: postCodeCtrl,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                        if (_formKey.currentState.validate()) {
                          AppUser appUser = AppUser(
                              firstNameCtrl.text,
                              lastNameCtrl.text,
                              usernameCtrl.text,
                              emailCtrl.text,
                              address1Ctrl.text,
                              address2Ctrl.text,
                              state,
                              postCodeCtrl.text);
                          await Auth().createUser(
                              emailCtrl.text, passwordCtrl.text, appUser);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Create my account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  child: FlatButton(
                    color: Colors.blue,
                    child: Text("TO DASHBOARD"),
                    onPressed: (){
                      setState(() {
                        Navigator.pushNamed(context, '/dashboard');
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
