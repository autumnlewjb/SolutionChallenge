import 'package:flutter/material.dart';

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
          /*child: StreamBuilder<QuerySnapshot>(
              stream: Database.schDB
                  .where('status', isEqualTo: "Completed")
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
                      return WidgetModel()
                          .schReturnTile(this.context,context, info,index);
                    });
              })*/
          ),
    );
  }
}
