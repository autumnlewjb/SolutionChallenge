import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/models/return_info.dart';
import 'package:return_med/src/models/user.dart';
import 'package:return_med/src/services/auth.dart';
import 'package:return_med/src/services/database.dart';
import 'package:return_med/src/collector/pages/drawer.dart';

class PartnerMainPage extends StatefulWidget {
  @override
  _PartnerMainPageState createState() => _PartnerMainPageState();
}

class _PartnerMainPageState extends State<PartnerMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _checkIfUserExists();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenHeight = MediaQuery.of(context).size.height;
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.deepPurple[400],
                  Colors.deepPurple[300]
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 50,
                      color: Colors.grey.withOpacity(0.5))
                ],
              ),
              child: Column(
                children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     alignment: Alignment.centerLeft,
                  //     child: Container(
                  //       margin: EdgeInsets.all(2),
                  //       child: Icon(Icons.menu),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer<List<ReturnInfo>>(
                            builder: (_, returnList, __) {
                              returnList = returnList
                                  ?.where((element) =>
                                      element.status == 'Completed')
                                  ?.where((element) => element.pic == user.uid)
                                  ?.toList();
                              return Expanded(
                                flex: 3,
                                child: FittedBox(
                                  alignment: Alignment.bottomLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "${returnList?.length ?? 0}",
                                    style: TextStyle(
                                        fontSize: 150, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "collections",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.only(left: 30),
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Hello!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
    final appUser = AppUser();

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
                          primary: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            appUser.uid = FirebaseAuth.instance.currentUser.uid;
                            appUser.email =
                                FirebaseAuth.instance.currentUser.email;
                            appUser.username =
                                FirebaseAuth.instance.currentUser.displayName;
                            appUser.photoUrl =
                                FirebaseAuth.instance.currentUser.photoURL;
                            appUser.firstName = firstNameCtrl.text;
                            appUser.lastName = lastNameCtrl.text;
                            appUser.address1 = address1Ctrl.text;
                            appUser.address2 = address2Ctrl.text;
                            appUser.state = state;
                            appUser.postcode = postCodeCtrl.text;
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
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          context.read<Auth>().signOut();
                        },
                        child: Text(
                          'Login with Another Account',
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
    ).whenComplete(() => Database.addUser(appUser));
  }

  _checkIfUserExists() async {
    final user = context.read<User>();
    DocumentSnapshot snapshot = await Database.getUser(user.uid);

    if (snapshot == null) {
      _showModalBottomSheet(context);
    }
  }

  void _launchURL(BuildContext context) async {
    const url = 'https://tawk.to/chat/5fda273aa8a254155ab3f4a1/1epm2ig2o';
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Colors.deepPurple,
          showPageTitle: false,
          enableDefaultShare: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  bool get wantKeepAlive => false;
}
