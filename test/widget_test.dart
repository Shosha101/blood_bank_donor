import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart'; // ✅ Required for testWidgets, WidgetTester, etc.

import 'package:blood_bank_donor/core/routing/app_router.dart';
import 'package:blood_bank_donor/donor_app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(DonorApp(appRouter: AppRouter()));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
