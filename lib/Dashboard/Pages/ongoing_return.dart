import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:return_med/database.dart';

import 'drawer.dart';

class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "On going return",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.deepPurple,
            Colors.deepPurple[400],
            Colors.deepPurple[300],
            Colors.deepPurple[200]
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Center(
            child: StreamBuilder<QuerySnapshot>(
                stream: Database.schDB
                    .orderBy('timeCreated', descending: true)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data.size == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        'No ongoing return found. Feel free to schedule a return now! :)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    );
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
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Expiry date : ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: info['expiryDate'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Address : ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: info['address1'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: ', ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: info['address2'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Postcode : ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: info['postcode'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'State : ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: info['state'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
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
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('Warning'),
                                                    content: Text(
                                                        'Are you sure you want to delete?'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('Cancel'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text('Confirm'),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          await snapshot
                                                              .data
                                                              .docs[index]
                                                              .reference
                                                              .delete()
                                                              .then((_) =>
                                                                  showSnackBar());
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.delete),
                                          label: Text("Delete")),
                                    ),
                                  ),
                                ],
                                title: Text(info['medicine']),
                                subtitle: Text(info['timeCreated']),
                                trailing: Text(info['status'],
                                    style: TextStyle(
                                      color: getColor(info['status']),
                                    ))));
                      });
                })),
      ),
    );
  }

  void showSnackBar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Successfully deleted!'),
      duration: Duration(seconds: 1),
    ));
  }

  Color getColor(dynamic text) {
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

  @override
  bool get wantKeepAlive => true;
}
