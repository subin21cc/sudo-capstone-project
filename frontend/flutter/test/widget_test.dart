import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/app/app.dart';
import 'package:oncare/core/config/app_config.dart';

void main() {
  testWidgets('OncareApp boots into the dashboard tab', (tester) async {
    const config = AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://dev.api.test',
      useMockApi: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[appConfigProvider.overrideWithValue(config)],
        child: const OncareApp(),
      ),
    );
    await tester.pumpAndSettle();

    // App bar title for the initial tab.
    expect(find.widgetWithText(AppBar, 'Dashboard'), findsOneWidget);

    // BottomNav with 4 destinations.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Diet'), findsOneWidget);
    expect(find.text('Exercise'), findsOneWidget);
    expect(find.text('My Health'), findsOneWidget);
  });

  testWidgets('Tapping a bottom-nav destination switches branch', (
    tester,
  ) async {
    const config = AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://dev.api.test',
      useMockApi: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[appConfigProvider.overrideWithValue(config)],
        child: const OncareApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Diet'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Diet Record'), findsOneWidget);

    await tester.tap(find.text('Exercise'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Exercise'), findsOneWidget);

    await tester.tap(find.text('My Health'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'My Health'), findsOneWidget);
  });
}
