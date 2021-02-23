import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/return_info.dart';
import 'package:return_med/Services/database.dart';

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
          "Ongoing return",
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
          child: Consumer<List<ReturnInfo>>(builder: (_, returnList, __) {
            if (returnList == null) {
              return CircularProgressIndicator();
            }
            returnList = returnList
                ?.where((element) => element.status != 'Completed')
                ?.toList();
            returnList?.sort((a, b) => a.status.compareTo(b.status));
            if (returnList.isEmpty) {
              return Text(
                'No ongoing return found. Feel free to schedule a return now! :)',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              );
            }
            return ListView.builder(
                itemCount: returnList.length,
                itemBuilder: (_, index) {
                  ReturnInfo info = returnList[index];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Expiry date : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: info.expiryDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Address : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: info.address1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: ', ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: info.address2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Postcode : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: info.postcode,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'State : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: info.state,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
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
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  FlatButton(
                                                      child: Text('Confirm'),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        Database.deleteSch(info
                                                                .timeCreated)
                                                            .then((_) =>
                                                                Scaffold.of(this
                                                                        .context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      'Successfully deleted!'),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                )));
                                                      })
                                                ]);
                                          });
                                    },
                                    icon: Icon(Icons.delete),
                                    label: Text("Delete")),
                              ),
                            ),
                          ],
                          title: Text(info.medName),
                          subtitle: Text(info.timeCreated),
                          trailing: Wrap(
                            spacing: 6,
                            children: [
                              Text(info.status,
                                  style: TextStyle(
                                    color: _getColor(info.status),
                                  )),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 18,
                              )
                            ],
                          )));
                });
          }),
        ),
      ),
    );
  }

  Color _getColor(String text) {
    if (text == 'Pending') {
      return Colors.grey;
    }
    if (text == 'Accepted') {
      return Colors.green;
    }
    return Colors.black;
  }

  @override
  bool get wantKeepAlive => true;
}
