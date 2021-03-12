import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/models/user.dart';
import 'package:return_med/src/services/database.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Stack(children: [
            Container(
              width: width,
              height: height * 0.3 - 80,
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
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  _profilePic(),
                  _usernameAndPoints(),
                  _profileInfo(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _profilePic() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Consumer<AppUser>(
        builder: (_, user, __) {
          return CachedNetworkImage(
            imageUrl: user.photoUrl,
            placeholder: (context, builder) => CircularProgressIndicator(),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 45,
              backgroundImage: imageProvider,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage("assets/icon.png"),
            ),
          );
        },
      ),
    );
  }

  Widget _profileInfo() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
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
          Row(
            children: [
              Icon(
                Icons.people,
                size: 20,
              ),
              SizedBox(
                width: width * 0.075,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FIRST NAME",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Consumer<AppUser>(builder: (_, user, __) {
                    return Text(
                      user.firstName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              ),
              SizedBox(
                width: width * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LAST NAME",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Consumer<AppUser>(builder: (_, user, __) {
                    return Text(
                      user.lastName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Row(
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
                  Consumer<AppUser>(builder: (_, user, __) {
                    return Text(
                      user.email,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Row(
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
                  Consumer<AppUser>(builder: (_, user, __) {
                    return Text(
                      "${user.address1}\n${user.address2}\n${user.postcode} ${user.state}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.deepPurple, width: 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                _showModalBottomSheet(context);
              },
              child: Text(
                'Update Information',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _usernameAndPoints() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 50,
              color: Colors.grey.withOpacity(0.5))
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.perm_identity_rounded),
                SizedBox(
                  width: width * 0.03,
                ),
                Consumer<AppUser>(builder: (_, user, __) {
                  return Text(
                    user.username,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  );
                }),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.card_giftcard_rounded),
                SizedBox(
                  width: width * 0.03,
                ),
                Consumer<AppUser>(
                  builder: (_, user, __) {
                    return Text(
                      'Point(s): ${user.rewardPoint}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(context) {
    final firstNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    final address1Ctrl = TextEditingController();
    final address2Ctrl = TextEditingController();
    final postCodeCtrl = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final AppUser user = Provider.of<AppUser>(context, listen: false);
    firstNameCtrl.text = user.firstName;
    lastNameCtrl.text = user.lastName;
    address1Ctrl.text = user.address1;
    address2Ctrl.text = user.address2;
    postCodeCtrl.text = user.postcode;
    String state = user.state;

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

    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Wrap(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "Update Information",
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
                          Map<String, dynamic> data = {
                            'first_name': firstNameCtrl.text,
                            'last_name': lastNameCtrl.text,
                            'address1': address1Ctrl.text,
                            'address2': address2Ctrl.text,
                            'state': state,
                            'postcode': postCodeCtrl.text,
                          };
                          if (data != null) {
                            Database.updateUser(user.uid, data);
                          }
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
        );
      },
    );
  }
}
