import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Riverpod observer that emits a debug log on every provider lifecycle
/// event. Enable in dev/staging via `ProviderScope.observers`; leave out
/// in prod to keep logs quiet.
class LoggingProviderObserver extends ProviderObserver {
  LoggingProviderObserver(this._logger);

  final Logger _logger;

  String _name(ProviderBase<Object?> provider) =>
      provider.name ?? provider.runtimeType.toString();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    _logger.d('[provider+] ${_name(provider)} = $value');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    _logger.d('[provider~] ${_name(provider)}: $previousValue -> $newValue');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    _logger.d('[provider-] ${_name(provider)}');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    _logger.e(
      '[provider!] ${_name(provider)}',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
