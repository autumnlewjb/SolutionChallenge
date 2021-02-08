import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Auth {
  String error = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookSignIn = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  //Create new account
  Future<String> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'Password should be at least 6 characters';
      } else if (e.code == 'email-already-in-use') {
        error = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        error = 'Please check your email address and try again.';
      } else if (e.code == 'unknown') {
        error = 'Email and password cannot be blank';
      } else {
        error = e.toString();
        print(e.toString());
      }
    }
    return error;
  }

  //Sign in with email and password
  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        error = 'Incorrect password';
      } else {
        error = 'Invalid email or password';
      }
    }
    print(FirebaseAuth.instance.currentUser);
    return error;
  }

  //Sign out
  Future<void> signOut() async {
    _firebaseAuth.signOut();
    print('Signed out');
  }

  //Sign in with Google account
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
    } catch (e) {
      error = GoogleSignIn.kSignInFailedError;
      print(e);
    }
    return error;
  }

  //Google sign out
  Future<void> signOutWithGoogle() async {
    await googleSignIn.disconnect();
    print('Signed out.');
  }

  //Sign in with Facebook account
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
        error = 'Login cancelled by the user.';
        break;
      case FacebookLoginStatus.error:
        error = 'An error occurred: ${result.errorMessage}';
        break;
    }
    return error;
  }

  //Facebook sign out
  Future<void> signOutWithFacebook() async {
    await facebookSignIn.logOut();
    print('Signed out.');
  }

  Future<void> resetPassword(String email) async {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
