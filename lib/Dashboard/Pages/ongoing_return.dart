import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/return_info.dart';
import 'package:return_med/Models/widget_model.dart';

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
            if (returnList.isEmpty) {
              return Text(
                'No ongoing return found. Feel free to schedule a return now! :)',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              );
            }
            returnList = returnList
                .where((element) => element.status != 'Completed')
                .toList();
            returnList.sort((a, b) => a.status.compareTo(b.status));
            return ListView.builder(
                itemCount: returnList.length,
                itemBuilder: (context, index) {
                  ReturnInfo info = returnList[index];
                  return WidgetModel()
                      .schReturnTile(this.context, context, info);
                });
          }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
