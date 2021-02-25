import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/Services/auth.dart';
import 'package:return_med/src/homepage.dart';
import 'package:mockito/mockito.dart';

class MockAuthProvider extends Mock implements Auth {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  MockFirebaseAuth auth = MockFirebaseAuth();
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: MediaQueryData(),
        child: ChangeNotifierProvider<Auth>(
            create: (_) => Auth(auth), child: MaterialApp(home: widget)));
  }

  group('Login', () {
    testWidgets(
        'Login form show correctly when user pressed on the get started button',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(HomePage()));

      final button = find.text("Get started");

      expect(find.text('Return Med'), findsOneWidget);
      expect(button, findsOneWidget);

      await tester.tap(button.first);
      await tester.pump();

      expect(find.text("Login").first, findsOneWidget);
    });
  });
}
