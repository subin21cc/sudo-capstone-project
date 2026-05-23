import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/app/app.dart';
import 'package:oncare/core/config/app_config.dart';

void main() {
  testWidgets('OncareApp builds with injected AppConfig', (tester) async {
    const config = AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://dev.api.test',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[appConfigProvider.overrideWithValue(config)],
        child: const OncareApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Oncare'), findsAtLeastNWidgets(1));
    expect(find.text('Bootstrap successful'), findsOneWidget);
    expect(find.text('env: dev'), findsOneWidget);
    expect(find.text('api: https://dev.api.test'), findsOneWidget);
  });
}
