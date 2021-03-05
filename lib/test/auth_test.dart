import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:return_med/src/services/auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockFacebookLogin extends Mock implements FacebookLogin {}

class MockFacebookLoginResult extends Mock implements FacebookLoginResult {
  FacebookLoginStatus status;
  MockFacebookLoginResult() {
    this.status = FacebookLoginStatus.error;
  }
}

//TODO tests not working right

void main() {
  final _mockFirebaseAuth = MockFirebaseAuth();
  final _googleAuth = MockGoogleSignIn();
  final _facebookAuth = MockFacebookLogin();
  TestWidgetsFlutterBinding.ensureInitialized();
  Auth _auth;

  setUp(() {
    _auth = Auth(_mockFirebaseAuth);
  });

  group('login with email and password', () {
    test('able to login with email and password', () async {
      when(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: "test@returnmeds.com", password: "12345"))
          .thenAnswer((realInvocation) => null);
      await _auth.signIn("test@returnmeds.com", "12345");
      expect(_auth.response, null);
    });

    test('able to show exception when email is invalid', () async {
      when(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: "testgmail.com", password: "12345"))
          .thenAnswer((realInvocation) {
        throw FirebaseAuthException(
            message: "invalid-email", code: "invalid-email");
      });
      await _auth.signIn("testgmail.com", "12345");
      expect(_auth.response, 'Please check your email address and try again.');
    });
  });

  group('social login', () {
    test('with google working properly', () async {
      when(_googleAuth.signIn()).thenAnswer((_) => Future.delayed(
          Duration(seconds: 1), () => MockGoogleSignInAccount()));
      await _googleAuth.signOut();
      await _auth.signInWithGoogle();
      expectLater(_auth.response, null);
      await _auth.signOut();
    }, skip: true);

    test('with google shows exception when something goes wrong', () async {
      when(_googleAuth.signIn())
          .thenThrow(PlatformException(code: GoogleSignIn.kSignInFailedError));
      await _auth.signInWithGoogle();
      expectLater(_auth.response, "Sign in failed");
      await _auth.signOut();
    }, skip: true);

    test('with facebook working properly', () async {
      await _auth.signInWithFacebook();
      expect(_auth.response, null);
    }, skip: true);

    test('with facebook shows exception when something goes wrong', () async {
      when(_facebookAuth.logIn(['email'])).thenReturn(Future.delayed(
          Duration(seconds: 1), () => MockFacebookLoginResult()));
      await _facebookAuth.logIn(['email']);
      // expect(_auth.response, 'Login cancelled.');
    }, skip: true);
  });

  group('register', () {
    when(_mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "test@returnmeds.com", password: "12345"))
        .thenAnswer((realInvocation) => null);
    when(_mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "", password: ""))
        .thenAnswer((realInvocation) =>
            throw FirebaseAuthException(code: "unknown", message: "no idea"));
    test('able to create user with email and password', () async {
      await _auth.createUser("test@gmail.com", "12345");
      expect(_auth.response, null);
    });

    test('show exception when email or password is blank', () async {
      await _auth.createUser("", "");
      expect(_auth.response, 'Email and password cannot be blank');
    });
  });

  group('sign out', () {
    test('able to log user out properly', () {});
  });
}
