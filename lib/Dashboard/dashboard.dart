import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/Models/available_reward.dart';
import 'package:return_med/Models/hospital.dart';
import 'package:return_med/Models/return_info.dart';
import 'package:return_med/Models/user.dart';

import '../database.dart';
import 'bottom_navi_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>(
            create: (BuildContext context) => Database.getUserStream(user.uid),
            catchError: (_, error) => null),
        StreamProvider<List<ReturnInfo>>(
            create: (BuildContext context) => Database.getReturnInfo(),
            catchError: (_, error) => null),
        StreamProvider<List<Hospital>>(
            create: (BuildContext context) => Database.getHospitals(),
            catchError: (_, error) => null),
        StreamProvider<List<AvailableReward>>(
            create: (BuildContext context) =>
                Database.getRewardStream('hospital_a'),
            catchError: (_, error) => null),
      ],
      child: MaterialApp(
        home: BottomNavBar(),
      ),
    );
  }
}
