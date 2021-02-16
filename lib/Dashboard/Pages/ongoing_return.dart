import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';

class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  /*var _backgroundColor = [
    Colors.green[200],
    Colors.green[300],
    Colors.green[500]
  ];*/

  @override
  Widget build(BuildContext context) {
    void showSnackBar() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Successfully deleted!'),
        duration: Duration(seconds: 1),
      ));
    }

    MaterialColor getColor(dynamic text) {
      if (text == 'Pending') {
        return Colors.grey;
      }
      if (text == 'Accepted') {
        return Colors.green;
      }
      if (text == 'Rejected') {
        return Colors.red;
      }
      return Colors.black;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "On going return",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
       /* decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _backgroundColor,
            )),*/
        child: Center(
            child: StreamBuilder<QuerySnapshot>(
                stream: Database()
                    .schDB
                    .orderBy('time created', descending: true)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data.size == 0) {
                    return Text('No ongoing return found.');
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> info =
                            snapshot.data.docs[index].data();
                        return Card(
                            elevation: 5,
                            margin: EdgeInsets.all(5),
                            child: ExpansionTile(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Expiry date : ' +
                                              info['expiry date']),
                                          Text('Address : ' +
                                              info['address1']),
                                          Text(info['address2']),
                                          Text('Postcode : ' +
                                              info['postcode']),
                                          Text('State : ' + info['state']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton.icon(
                                          onPressed: () {
                                            snapshot
                                                .data.docs[index].reference
                                                .delete()
                                                .then((_) => showSnackBar());
                                          },
                                          icon: Icon(Icons.delete),
                                          label: Text("Delete")),
                                    ),
                                  ),
                                ],
                                title: Text(info['medicine']),
                                subtitle: Text(info['time created']),
                                trailing: Text(info['status'],
                                    style: TextStyle(
                                      color: getColor(info['status']),
                                    ))));
                      });
                })),
      ),
    );
  }
}
