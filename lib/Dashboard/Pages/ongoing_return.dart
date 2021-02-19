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
    List<ReturnInfo> pendingReturn = Provider.of<List<ReturnInfo>>(context)
        .where((element) => element.status == 'Pending')
        .toList();
    List<ReturnInfo> acceptedReturn = Provider.of<List<ReturnInfo>>(context)
        .where((element) => element.status == 'Accepted')
        .toList();
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
            child: Column(
          children: [
            (acceptedReturn != null)
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: acceptedReturn.length,
                    itemBuilder: (context, index) {
                      ReturnInfo info = acceptedReturn[index];
                      return WidgetModel()
                          .schReturnTile(this.context, context, info);
                    })
                : CircularProgressIndicator(),
            (pendingReturn != null)
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: pendingReturn.length,
                    itemBuilder: (context, index) {
                      ReturnInfo info = pendingReturn[index];
                      return WidgetModel()
                          .schReturnTile(this.context, context, info);
                    })
                : CircularProgressIndicator()
          ],
        )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
