import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:return_med/src/models/user.dart';
import 'package:return_med/src/dashboard/pages/profile.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

final appUser = AppUser();

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
      data: MediaQueryData(),
      child: Provider<AppUser>(
        create: (BuildContext context) => AppUser(
          uid: "12345",
          username: 'test',
          firstName: 'test',
          lastName: 'test',
          email: 'test@returnmeds.com',
          address1: 'test',
          address2: 'test',
          state: 'test',
          postcode: 'test',
        ),
        lazy: false,
        child: MaterialApp(
          home: widget,
        ),
      ),
    );
  }

  testWidgets('profile page working properly', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestableWidget(Profile()), Duration(seconds: 3));

    expectLater(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.text("12345"), findsNothing);
    expect(find.text('test'), findsNWidgets(3));
    expect(find.text('test\ntest\ntest test'), findsOneWidget);
    expect(find.text('Point(s): 0'), findsOneWidget);
    expect(find.text('test@returnmeds.com'), findsOneWidget);
    expect(find.text("Update Information"), findsOneWidget);
  });
}
