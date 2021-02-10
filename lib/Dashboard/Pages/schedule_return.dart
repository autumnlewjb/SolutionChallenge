import 'package:flutter/material.dart';
import 'package:return_med/return_info.dart';

class ScheduleReturn extends StatefulWidget {
  @override
  _ScheduleReturnState createState() => _ScheduleReturnState();
}

class _ScheduleReturnState extends State<ScheduleReturn> {
  //For state drop down box
  final _formKey = GlobalKey<FormState>();
  String medName;
  String address1;
  String address2;
  String state;
  String postcode;
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
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Return Med',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            backgroundColor: Colors.green[400]),
        body: Container(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  Text(
                    'Schedule a return',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Field required' : null,
                    decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                        medName = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        validator: (val) => date=="Medicine Expiry Date (yyyy-mm-dd)"? 'Field required' : null,
                        decoration: InputDecoration(
                          labelText: '$date',
                          labelStyle:
                          TextStyle(fontSize: 13.0, color: Colors.black),
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                        keyboardType: null,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Field required' : null,
                    decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                        address1 = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Field required' : null,
                    decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                        address2 = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0, fontSize: 0),
                            ),
                            validator: (value) => value == null ? '' : null,
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
                  SizedBox(height: 10.0,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Field required' : null,
                    decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                        postcode = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //ReturnInfo(medName, selectedDate, address1, address2,
                          //    state, postcode);
                        }
                      },
                      child: Icon(
                        Icons.assignment_turned_in,
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
