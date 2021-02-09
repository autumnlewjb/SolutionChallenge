import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:return_med/homepage.dart';
import 'package:return_med/login.dart';
import 'package:return_med/sign_up.dart';
import 'package:return_med/user_home.dart';
import 'Dashboard/dashboard.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/': (context) => Root(),
      '/signUp': (context) => SignUpPage(),
      '/logIn': (context) => LoginPage(),
      '/userHome': (context) => Home(),
      '/dashboard': (context) => Dashboard(),
    },
  ));
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            print(snapshot.data.uid);
            return Home();
          } else {
            return HomePage();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
    // final user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   return FutureBuilder<bool>(
    //       future: Auth().userExist(user.uid),
    //       builder: (context, snapshot) {
    //         print("sstuff" + "${snapshot.data}");
    //         if (snapshot.data) {
    //           return Home();
    //         } else {
    //           return InfoPage();
    //         }
    //       });
    // } else {
    //   return HomePage();
    // }
  }
}
