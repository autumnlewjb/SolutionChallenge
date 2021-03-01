import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/Dashboard/Partner/partner_main_page.dart';
import 'package:return_med/src/Models/user.dart';
import 'package:return_med/src/Services/auth.dart';
import 'package:return_med/src/Services/database.dart';
import 'package:return_med/src/dashboard/pages/drawer.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
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
    return Scaffold(
      drawer: AppDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.deepPurple,
              pinned: true,
              stretch: false,
              expandedHeight: MediaQuery.of(context).size.height / 5,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Welcome to Return Med'),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   child: Center(
                    //     child: Text(
                    //       'Welcome to Return Med',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 25,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: screenHeight * 0.03,
                    // ),
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
                            "This is where you can start to dispose of your medicine without any worries. Let's start now!",
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
                          onPressed: () => _launchURL(context),
                          icon: Icon(Icons.question_answer_rounded),
                          label: Text("Need help?"),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new PMainpage()));
                          },
                          icon: Icon(Icons.arrow_drop_down_circle),
                          label: Text("Partner"),
                          color: Colors.white,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.timer,
                                      size: 50,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Step 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Click the second icon below",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.assignment_rounded,
                                      size: 50,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Step 2",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Fill in the details on the page",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.assignment_turned_in_rounded,
                                      size: 50,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Step 3",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Wait for the good news!",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/medicine.webp",
                      height: screenHeight * 0.135,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('Did you know that?',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          width: 210,
                          child: Text(
                            "Most people do not handle their medicine correctly!",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple[200],
                        Colors.deepPurple[400],
                        Colors.deepPurple
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
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
