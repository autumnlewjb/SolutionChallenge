import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:return_med/homepage.dart';
import 'package:return_med/login.dart';
import 'package:return_med/sign_up.dart';

import 'Dashboard/dashboard.dart';
import 'Models/user.dart';
import 'auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth(FirebaseAuth.instance)),
        ChangeNotifierProvider(create: (_) => AppUser()),
        StreamProvider(create: (context) => context.read<Auth>().user),
        /*Provider(
            create: (context) => Database(
                FirebaseFirestore.instance, context.read<Auth>().firebaseAuth))*/
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => Root(),
          '/signUp': (context) => SignUpPage(),
          '/logIn': (context) => LoginPage()
        },
      ),
    );
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if (user != null) {
      return Dashboard();
    }
    return HomePage();
  }
}
