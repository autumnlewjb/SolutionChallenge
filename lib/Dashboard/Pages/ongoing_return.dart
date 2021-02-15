import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';

class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  var _backgroundColor = [
    Colors.green[200],
    Colors.green[300],
    Colors.green[500]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "On going return",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _backgroundColor,
        )),
        child: Container(
          child: Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Database().schDB.snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new Card(
                          elevation: 5,
                            child: ExpansionTile(
                              children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Text(document.data()['address2']),
                                    new Text(document.data()['state']),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                    label: Text("Delete")),
                              ),
                            ),
                          ],
                          title: new Text(document.data()['medicine']),
                          subtitle: new Text(document.data()['address1']),
                        ));
                      }).toList(),
                    );
                  })),
        ),
      ),
    );
  }
}
