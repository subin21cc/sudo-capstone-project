import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:oncare/app/app.dart';
import 'package:oncare/core/config/app_config.dart';
import 'package:oncare/core/logging/app_logger.dart';
import 'package:oncare/core/logging/logging_provider_observer.dart';

/// Single entry point used by `main.dart`. Initializes binding,
/// resolves [AppConfig] from `--dart-define`s, installs a top-level
/// error handler, and starts the app inside a [ProviderScope].
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  final logger = Logger(level: config.isProd ? Level.info : Level.debug);
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

  // Provider observers — log lifecycle events outside prod.
  final observers = <ProviderObserver>[
    if (!config.isProd) LoggingProviderObserver(logger),
  ];

  runZonedGuarded<void>(
    () {
      runApp(
        ProviderScope(
          observers: observers,
          overrides: <Override>[
            appConfigProvider.overrideWithValue(config),
            appLoggerProvider.overrideWithValue(logger),
          ],
          child: const OncareApp(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      logger.e('Uncaught zone error', error: error, stackTrace: stack);
    },
  );
}
