import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/Models/user.dart';
import 'package:return_med/src/models/return_info.dart';
import 'package:return_med/src/services/database.dart';

class PartnerHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Collection history'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.deepPurple,
                Colors.deepPurple[400],
                Colors.deepPurple[300],
                Colors.deepPurple[200]
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Center(
              child: Consumer<List<ReturnInfo>>(builder: (_, returnList, __) {
                if (returnList == null) {
                  return CircularProgressIndicator();
                }
                returnList = returnList
                    ?.where((element) => element.status == 'Completed')
                    ?.where((element) => element.pic == user.uid)
                    ?.toList();
                if (returnList.isEmpty) {
                  return Text(
                    'No records found',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  );
                }
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Expiry date : ',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: info.expiryDate,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Address : ',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: info.address1,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: ', ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: info.address2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Postcode : ',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: info.postcode,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'State : ',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: info.state,
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
                              ],
                              title: Text(info.medName),
                              subtitle: Text(info.timeCreated),
                              trailing: Wrap(
                                spacing: 6,
                                children: [
                                  Text(info.status,
                                      style: TextStyle(
                                        color: Colors.black,
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
          );
        },
      ),
    );
  }
}
