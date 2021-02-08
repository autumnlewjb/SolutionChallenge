import 'package:firebase_auth/firebase_auth.dart';

class Profile{
  String name;
  String email;
  String id;

  initializeUser(User user){
    name=user.displayName;
    email=user.email;
    id=user.uid;
  }
}


