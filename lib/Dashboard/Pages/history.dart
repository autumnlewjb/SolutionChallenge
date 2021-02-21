import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/return_info.dart';
import 'package:return_med/Models/widget_model.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On going history'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Consumer<List<ReturnInfo>>(builder: (_, returnList, __) {
          if (returnList == null) {
            return CircularProgressIndicator();
          }
          returnList = returnList
              .where((element) => element.status == 'Completed')
              .toList();
          if (returnList.isEmpty) {
            return Text(
              'No ongoing return found. Feel free to schedule a return now! :)',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            );
          }
          return ListView.builder(
              itemCount: returnList.length,
              itemBuilder: (context, index) {
                ReturnInfo info = returnList[index];
                return WidgetModel().schReturnTile(this.context, context, info);
              });
        }),
      ),
    );
  }
}
