import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/models/return_info.dart';
import 'package:return_med/src/models/user.dart';

import '../Services/database.dart';
import 'bottom_navi_bar.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>(
            create: (BuildContext context) => Database.getUserStream(user.uid),
            lazy: false,
            catchError: (_, error) => null),
        StreamProvider<List<ReturnInfo>>(
            create: (BuildContext context) => Database.getReturnInfo(user.uid),
            lazy: true,
            catchError: (_, error) => null)
      ],
      child: MaterialApp(
        home: BottomNavBar(),
      ),
    );
  }
}
