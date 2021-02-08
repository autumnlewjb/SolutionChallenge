import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logn_ui/pages/GetStarted.dart';
import 'package:logn_ui/pages/SignUp.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => HomePage(),
      '/signUp': (context) => SignUpPage()
    },
  ));
}
