import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_interface/profile/Home.dart';

class Return extends StatefulWidget {
@override
_ReturnState createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: (){},
          child: Text(
            'Return Med',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
            ),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Medicine Expiry Date',
              labelStyle: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
              hintText: 'mm/dd/yyyy',
              hintStyle: TextStyle(
                fontSize: 10.0,
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'State',
              labelStyle: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
              hintText: 'Selangor',
              hintStyle: TextStyle(
                fontSize: 10.0,
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          ElevatedButton(
              onPressed: (){},
              child: Icon(
                Icons.assignment_turned_in,
              )
          )
        ],
      ),
    );
  }
}