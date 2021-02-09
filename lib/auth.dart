import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:return_med/user.dart';
=======
import 'package:google_sign_in/google_sign_in.dart';
>>>>>>> main

class Auth {
  String response = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookSignIn = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  CollectionReference user_db = FirebaseFirestore.instance.collection("users");

  //Create new account
  Future<String> createUser(
      String email, String password, AppUser appUser) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await addUser(user.user.uid, appUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'Password should be at least 6 characters';
      } else if (e.code == 'email-already-in-use') {
        response = 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        response = 'Please check your email address and try again.';
      } else if (e.code == 'unknown') {
        response = 'Email and password cannot be blank';
      } else {
        response = e.toString();
      }
    }
    return response;
  }

  //Sign in with email and password
  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        response = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        response = 'Please check your email address and try again.';
      } else if (e.code == 'unknown') {
        response = 'Email and password cannot be blank';
      } else {
        response = e.toString();
      }
    }
    return response;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return googleSignInAccount.toString();
  }

  Future<String> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    FacebookAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken.token);
    await _firebaseAuth.signInWithCredential(credential);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        response = 'Login cancelled by the user.';
        break;
      case FacebookLoginStatus.error:
        response = 'An error occurred: ${result.errorMessage}';
        break;
    }
    return response;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut().whenComplete(() => print('Signed out'));
  }

  Future<void> signOutWithGoogle() async {
    await googleSignIn.signOut();
    await signOut();
  }

  Future<void> signOutWithFacebook() async {
    await facebookSignIn.logOut();
    await signOut();
  }

  Future<void> resetPassword(String email) async => await _firebaseAuth
      .sendPasswordResetEmail(email: email)
      .whenComplete(() => print('An email has been sent.'));

  Future<void> addUser(String uid, AppUser appUser) async {
    return user_db.doc(uid).set({
      'first_name': appUser.firstName,
      'last_name': appUser.lastName,
      'username': appUser.username,
      'email': appUser.email,
      'address1': appUser.address1,
      'address2': appUser.address2,
      'state': appUser.state,
      'postcode:': appUser.postcode
    });
  }

  Future<bool> userExist(String uid) async {
    DocumentSnapshot snapshot = await user_db.doc(uid).get();
    if (snapshot.exists) {
      return true;
    }

    return false;
  }
  
}
