import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:return_med/homepage.dart';
import 'package:return_med/login.dart';
import 'package:return_med/sign_up.dart';
import 'package:return_med/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/': (context) => Root(),
      '/signUp': (context) => SignUpPage(),
      '/logIn': (context) => LoginPage(),
      '/userHome': (context) => UserHome(),
    },
  ));
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return UserHome();
    } else {
      return HomePage();
    }

    // TODO the code below is not working

    // return StreamBuilder<User>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       if (snapshot.hasData) {
    //         return LoginPage();
    //       } else {
    //         return UserHome(); //for testing only
    //       }
    //     } else {
    //       return Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
