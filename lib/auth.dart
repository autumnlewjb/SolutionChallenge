import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:return_med/database.dart';

import 'Models/user.dart';

class Auth {
  String response = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookSignIn = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //Create new account
  Future<String> createUser(
      String email, String password, AppUser appUser) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Database.addUser(user.user.uid, appUser);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          response = 'Password should be at least 8 characters';
          break;
        case 'email-already-in-use':
          response = 'An account already exists for this email.';
          break;
        case 'invalid-email':
          response = 'Please check your email address and try again.';
          break;
        case 'unknown':
          response = 'Email and password cannot be blank';
          break;
        default:
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
      switch (e.code) {
        case 'wrong-password':
          response = 'Incorrect password';
          break;
        case 'invalid-email':
          response = 'Please check your email address and try again.';
          break;
        case 'user-not-found':
          response = "Couldn't find your account";
          break;
        case 'unknown':
          response = 'Email and password cannot be blank';
          break;
        default:
          response = e.toString();
      }
    }
    return response;
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      switch (e.code) {
        case GoogleSignIn.kSignInFailedError:
          response = 'Sign in failed';
          break;
        case GoogleSignIn.kSignInCanceledError:
          response = 'Login cancelled.';
          break;
        case GoogleSignIn.kNetworkError:
          response = 'Cannot connect to the server.';
          break;
        default:
          response = e.toString();
      }
    } on NoSuchMethodError {
      response = 'The login process terminated.';
    }
    return response;
  }

  Future<String> signInWithFacebook() async {
    FacebookLoginResult result;
    try {
      result = await facebookSignIn.logIn(['email']);
      FacebookAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);
      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          response = '';
          break;
        case FacebookLoginStatus.cancelledByUser:
          response = 'Login cancelled.';
          break;
        case FacebookLoginStatus.error:
          response = 'An error occurred: ${result.errorMessage}';
          break;
      }
    }
    return response;
  }

  Future<void> signOut() async {
    switch (_firebaseAuth.currentUser.providerData[0].providerId) {
      case 'google.com':
        signOutWithGoogle();
        break;
      case 'facebook.com':
        signOutWithFacebook();
        break;
      default:
        signOutFromApp();
    }
  }

  Future<void> signOutFromApp() async {
    await _firebaseAuth.signOut().then((_) => print('Signed out'));
  }

  Future<void> signOutWithGoogle() async {
    await googleSignIn.signOut();
    await signOutFromApp();
  }

  Future<void> signOutWithFacebook() async {
    await facebookSignIn.logOut();
    await signOutFromApp();
  }

  Future<void> resetPassword(BuildContext context, String email) async =>
      await _firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((_) => showDialog(
              context: context,
              builder: (context) {
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
                return AlertDialog(
                  content: Text('An email has been sent.'),
                );
              }));
}
