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
    void showSnackBar() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Successfully deleted!'),
        duration: Duration(seconds: 2),
      ));
    }

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
                          return Card(
                              elevation: 5,
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
                                          Text('Expiry date : ' +
                                              snapshot.data.docs[index]
                                                  .data()['expiry date']),
                                          Text('Address : ' +
                                              snapshot.data.docs[index]
                                                  .data()['address1']),
                                          Text(snapshot.data.docs[index]
                                              .data()['address2']),
                                          Text('Postcode : ' +
                                              snapshot.data.docs[index]
                                                  .data()['postcode']),
                                          Text('State : ' +
                                              snapshot.data.docs[index]
                                                  .data()['state']),
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
                                            snapshot.data.docs[index].reference
                                                .delete()
                                                .then((_) => showSnackBar());
                                          },
                                          icon: Icon(Icons.delete),
                                          label: Text("Delete")),
                                    ),
                                  ),
                                ],
                                title: Text(snapshot.data.docs[index]
                                    .data()['medicine']),
                                subtitle: Text(snapshot.data.docs[index]
                                    .data()['time created']),
                                trailing: Text(
                                    snapshot.data.docs[index].data()['status']),
                              ));
                        });
                  })),
        ),
      ),
    );
  }
}
