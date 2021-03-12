import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/models/return_info.dart';
import 'package:return_med/src/models/user.dart';
import 'package:return_med/src/services/database.dart';
import 'package:return_med/src/patient/pages/drawer.dart';

class ScheduleReturn extends StatefulWidget {
  @override
  _ScheduleReturnState createState() => _ScheduleReturnState();
}

class _ScheduleReturnState extends State<ScheduleReturn>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final medName = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final postcode = TextEditingController();
  String state;

  var subscribingID;

  //For state drop down box
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

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  //For choosing the date using a calender widget
  String date = 'Medicine Expiry Date (yyyy-mm-dd)';
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = picked.toString().substring(0, 10);
      });
  }

  @override
  void initState() {
    super.initState();

    subscribingID = KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
      if (!visible) {
        FocusManager.instance.primaryFocus.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
            centerTitle: true,
            elevation: 10,
            title: Text(
              'Schedule a return',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple),
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      autovalidateMode: _autoValidate,
                      controller: medName,
                      validator: (val) => val.isEmpty ? 'Field required' : null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Medicine Name',
                        labelStyle: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        hintText: 'Medicine Name',
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          autovalidateMode: _autoValidate,
                          initialValue: null,
                          validator: (val) =>
                              date == "Medicine Expiry Date (yyyy-mm-dd)"
                                  ? 'Field required'
                                  : null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelText: '$date',
                            labelStyle:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                            icon: Icon(
                              Icons.calendar_today,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          keyboardType: null,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      autovalidateMode: _autoValidate,
                      controller: address1,
                      validator: (val) => val.isEmpty ? 'Field required' : null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Address Line 1',
                        labelStyle: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        hintText: 'Taman Admin',
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autovalidateMode: _autoValidate,
                      controller: address2,
                      validator: (val) => val.isEmpty ? 'Field required' : null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Address Line 2',
                        labelStyle: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        hintText: 'Jalan Admin',
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: DropdownButtonFormField(
                              autovalidateMode: _autoValidate,
                              decoration:
                                  InputDecoration.collapsed(hintText: ''),
                              validator: (value) => value == null
                                  ? 'Please select your state'
                                  : null,
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
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      autovalidateMode: _autoValidate,
                      controller: postcode,
                      validator: (val) => val.isEmpty ? 'Field required' : null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Post Code',
                        labelStyle: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        hintText: '05400',
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton.icon(
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Confirm",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await Database.addSch(
                                      this.context.read<AppUser>().uid,
                                      ReturnInfo.toMap(
                                          medName.text,
                                          selectedDate,
                                          address1.text,
                                          address2.text,
                                          state,
                                          postcode.text))
                                  .then((_) => {
                                        setState(() {
                                          _autoValidate =
                                              AutovalidateMode.disabled;
                                          _formKey.currentState.reset();
                                          date =
                                              "Medicine Expiry Date (yyyy-mm-dd)";
                                          state = null;
                                          medName.clear();
                                          postcode.clear();
                                          address1.clear();
                                          address2.clear();
                                        }),
                                        FocusManager.instance.primaryFocus
                                            .unfocus(),
                                        successDialog(context,
                                            "Your information has been recorded")
                                      });
                            } else {
                              setState(() {
                                _autoValidate =
                                    AutovalidateMode.onUserInteraction;
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardVisibilityNotification().removeListener(subscribingID);
    medName.dispose();
    address1.dispose();
    address2.dispose();
    postcode.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
