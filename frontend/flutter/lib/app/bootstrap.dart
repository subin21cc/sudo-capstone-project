import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:oncare/app/app.dart';
import 'package:oncare/core/config/app_config.dart';

/// Single entry point used by `main.dart`. Initializes binding,
/// resolves `AppConfig` from `--dart-define`s, installs a top-level
/// error handler, and starts the app inside a `ProviderScope`.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  final logger = Logger();
  logger.i(
    'oncare boot env=${config.environment.name} api=${config.apiBaseUrl}',
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    logger.e(
      'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  runZonedGuarded<void>(
    () {
      runApp(
        ProviderScope(
          overrides: <Override>[appConfigProvider.overrideWithValue(config)],
          child: const OncareApp(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      logger.e('Uncaught zone error', error: error, stackTrace: stack);
    },
  );
}
