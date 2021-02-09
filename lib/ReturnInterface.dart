import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Return extends StatefulWidget {
  @override
  _ReturnState createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  String country;
  List countries = [
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
        title: TextButton(
          onPressed: () {},
          child: Text(
            'Return Med',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: [
          Text(
            'Schedule a return',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '$date',
                  labelStyle: TextStyle(fontSize: 13.0, color: Colors.black),
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
          ),
          TextField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          TextField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text('Choose state'),
                value: country,
                onChanged: (newCountry) {
                  setState(() {
                    country = newCountry;
                  });
                },
                items: countries.map((valueItems) {
                  return DropdownMenuItem(
                    value: valueItems,
                    child: Text(valueItems),
                  );
                }).toList()),
          ),
          TextField(
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.assignment_turned_in,
              ))
        ],
      ),
    );
  }
}
