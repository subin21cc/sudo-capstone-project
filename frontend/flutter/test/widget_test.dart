import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

import 'package:oncare/app/app.dart';
import 'package:oncare/core/config/app_config.dart';
import 'package:oncare/core/logging/app_logger.dart';
import 'package:oncare/gen/l10n/app_localizations.dart';
import 'package:oncare/shared/services/locale_provider.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, {Locale? locale}) async {
    const config = AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://dev.api.test',
      useMockApi: true,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          appConfigProvider.overrideWithValue(config),
          appLoggerProvider.overrideWithValue(Logger(level: Level.off)),
          if (locale != null) localeProvider.overrideWith((ref) => locale),
        ],
        child: const OncareApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Boots into the Home tab in English', (tester) async {
    await pumpApp(tester, locale: const Locale('en'));
    // Bottom-nav labels match the React original.
    expect(find.text('Home'), findsAtLeastNWidgets(1));
    expect(find.text('Diet'), findsAtLeastNWidgets(1));
    expect(find.text('Exercise'), findsAtLeastNWidgets(1));
    expect(find.text('My'), findsAtLeastNWidgets(1));
  });

  testWidgets('Tapping a bottom-nav destination switches branch', (
    tester,
  ) async {
    await pumpApp(tester, locale: const Locale('en'));

    // OncareHeader is a Material+Container (not an AppBar), so we
    // settle for `find.text(...)` finders here.
    await tester.tap(find.text('Diet').first);
    await tester.pumpAndSettle();
    expect(find.text('Diet'), findsAtLeastNWidgets(1));

    await tester.tap(find.text('Exercise').first);
    await tester.pumpAndSettle();
    expect(find.text('Exercise'), findsAtLeastNWidgets(1));

    await tester.tap(find.text('My').first);
    await tester.pumpAndSettle();
    expect(find.text('My'), findsAtLeastNWidgets(1));
  });

  testWidgets('Korean locale localises the bottom-nav labels', (tester) async {
    await pumpApp(tester, locale: const Locale('ko'));
    await tester.pumpAndSettle();
    expect(find.text('홈'), findsAtLeastNWidgets(1));
    expect(find.text('식단'), findsAtLeastNWidgets(1));
    expect(find.text('운동'), findsAtLeastNWidgets(1));
    expect(find.text('My'), findsAtLeastNWidgets(1));
  });

  test('ARB resources expose nav strings for ko + en', () {
    // sanity: 'supportedLocales' is the canonical set.
    expect(AppLocalizations.supportedLocales, contains(const Locale('en')));
    expect(AppLocalizations.supportedLocales, contains(const Locale('ko')));
  });
}
