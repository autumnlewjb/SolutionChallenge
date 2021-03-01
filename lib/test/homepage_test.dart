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

  group('Login form', () {
    _getToLogin(WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(HomePage()));

      final button = find.text("Get started");

      expect(find.text('Return Med'), findsOneWidget);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pump();
    }

    testWidgets('show correctly when user pressed on the get started button',
        (WidgetTester tester) async {
      await _getToLogin(tester);

      expect(find.text("Login").first, findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets("Swiping works right", (WidgetTester tester) async {
      await _getToLogin(tester);

      await tester.pump();
      expect(find.text("Swipe Up for Full View"), findsOneWidget);
      expect(find.text("Swipe Down for Better View"), findsNothing);

      await tester.pumpAndSettle();
      await tester.drag(find.text("Swipe Up for Full View"), Offset(0, -10.0));
      await tester.pumpAndSettle();

      expect(find.text("Swipe Up for Full View"), findsNothing);
      expect(find.text("Swipe Down for Better View"), findsOneWidget);
    });

    testWidgets("show appropriate validation message with empty textfield",
        (WidgetTester tester) async {
      await _getToLogin(tester);

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text("Enter an email"), findsOneWidget);
      expect(find.text("Enter a password"), findsOneWidget);

      await tester.enterText(find.byKey(ValueKey("password-field")), "123456");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text("Enter a password"), findsNothing);
      expect(find.text("Enter an email"), findsOneWidget);

      await tester.enterText(find.byKey(ValueKey("password-field")), "");
      await tester.enterText(
          find.byKey(ValueKey("email-field")), "test@returnmeds.com");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text("Enter a password"), findsOneWidget);
      expect(find.text("Enter an email"), findsNothing);
    });
  });
}
