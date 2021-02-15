import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';
import 'package:return_med/return_info.dart';

class ScheduleReturn extends StatefulWidget {
  @override
  _ScheduleReturnState createState() => _ScheduleReturnState();
}

class _ScheduleReturnState extends State<ScheduleReturn> {
  //For state drop down box
  final _formKey = GlobalKey<FormState>();
  final medName = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final postcode = TextEditingController();
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
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Return Med',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            backgroundColor: Colors.green[400]),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Schedule a return',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: medName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    controller: address1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) => val.isEmpty ? 'Field required' : null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelText: 'Address Line 1',
                      labelStyle: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                      ),
                      hintText: 'taman admin',
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
                    controller: address2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) => val.isEmpty ? 'Field required' : null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelText: 'Address Line 2',
                      labelStyle: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                      ),
                      hintText: 'jalan admin',
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
                            decoration: InputDecoration.collapsed(hintText: ''),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
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
                    controller: postcode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await Database()
                                .updateSchDB(ReturnInfo(
                                    medName.text,
                                    selectedDate,
                                    address1.text,
                                    address2.text,
                                    state,
                                    postcode.text))
                                .then((_) =>
                            {
                                      Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (context, ani1, ani2) =>
                                                    ScheduleReturn(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          )),
                                      successDialog(context,
                                          "Your information has been recorded")
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
        ));
  }
}
