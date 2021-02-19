import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/return_info.dart';
import 'package:return_med/database.dart';

import 'bottom_navi_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<ReturnInfo>>(
            create: (BuildContext context) => Database.getReturnInfo(),
            catchError: (_, error) => null),
      ],
      child: MaterialApp(
        home: BottomNavBar(),
      ),
    );
  }
}
