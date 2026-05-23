import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Shared application logger. Override in [ProviderScope] from
/// `bootstrap.dart` so the level reflects the resolved environment.
final appLoggerProvider = Provider<Logger>(
  (ref) => throw UnimplementedError(
    'appLoggerProvider must be overridden in ProviderScope.',
  ),
  name: 'appLogger',
);
