import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      {String email, String password}) {
    return Future.delayed(Duration(seconds: 1), () => _mockUserCredential);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {String email, String password}) {
    return Future.delayed(Duration(seconds: 1), () => _mockUserCredential);
  }
}

final MockUserCredential _mockUserCredential = MockUserCredential();

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  var _mockFirebaseAuth = MockFirebaseAuth();
  group('login', () {
    test('able to login with email and password', () async {
      MockUserCredential response = await _mockFirebaseAuth
          .signInWithEmailAndPassword(email: "", password: "");
      expect(response, _mockUserCredential);
    });
  });

  group('register', () {
    test('able to create user and password', () async {
      MockUserCredential response =
          await _mockFirebaseAuth.createUserWithEmailAndPassword(
              email: "test@gmail.com", password: "32342423");
      expect(response, _mockUserCredential);
    });
  });
}
