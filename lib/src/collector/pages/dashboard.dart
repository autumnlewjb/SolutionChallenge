import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/collector/pages/partner_navigation.dart';
import 'package:return_med/src/models/return_info.dart';
import 'package:return_med/src/models/user.dart';

import '../../services/database.dart';

class PartnerDashboard extends StatelessWidget {
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
            create: (BuildContext context) => Database.getAllReturnInfo(),
            lazy: true,
            catchError: (_, error) {
              print(error);
            })
      ],
      child: MaterialApp(
        home: PartnerNavigation(),
      ),
    );
  }
}
