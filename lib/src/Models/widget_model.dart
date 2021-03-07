import 'package:flutter/material.dart';
import 'package:return_med/src/models/return_info.dart';
import 'package:return_med/src/services/database.dart';

class WidgetModel {
  Card schReturnTile(
      BuildContext scaffoldContext, BuildContext context, ReturnInfo info) {
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
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: info.expiryDate,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Address : ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: info.address1,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ', ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: info.address2,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Postcode : ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: info.postcode,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'State : ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: info.state,
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  content:
                                      Text('Are you sure you want to delete?'),
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
                                          Database.deleteSch(info.timeCreated)
                                              .then((_) =>
                                                  Scaffold.of(scaffoldContext)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Successfully deleted!'),
                                                    duration:
                                                        Duration(seconds: 1),
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
  }

  bool isSelected = false;

  Color _getColor(String text) {
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
}
