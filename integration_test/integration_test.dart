import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance.signOut();
  });

  testWidgets("Create Account Flow", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TikTokApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text("Sign up for TikTok"), findsOneWidget);
    expect(find.text("Log in sir"), findsOneWidget);

    await tester.tap(find.text("Log in sir"));
    await tester.pumpAndSettle();

    expect(find.text("Log in for TikTok"), findsOneWidget);
    expect(find.text("Use email and password"), findsOneWidget);

    await tester.tap(find.text("Sign up"));
    await tester.pumpAndSettle();

    expect(find.text("Use email and password"), findsOneWidget);

    await tester.tap(find.text("Use email and password"));
    await tester.pumpAndSettle();

    final usernameInput = find.byType(TextField).first;
    await tester.enterText(usernameInput, "test999");
    await tester.pumpAndSettle();

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    final emailInput = find.byType(TextField).first;
    await tester.enterText(emailInput, "test999@gmail.com");
    await tester.pumpAndSettle();

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    final passwordInput = find.byType(TextField).first;
    await tester.enterText(passwordInput, "!Q2w3e4r5t");
    await tester.pumpAndSettle();

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // birthday_screen
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle(const Duration(seconds: 10));
  });
}
