import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.sentryDsn,
  });

  final Environment environment;
  final String apiBaseUrl;
  final String? sentryDsn;

  bool get isProd => environment == Environment.prod;

  factory AppConfig.fromEnvironment() {
    const envStr = String.fromEnvironment('ENV', defaultValue: 'dev');
    final env = switch (envStr) {
      'prod' => Environment.prod,
      'staging' => Environment.staging,
      _ => Environment.dev,
    };
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://dev.api.oncare.example.com',
    );
    const sentryDsn = String.fromEnvironment('SENTRY_DSN');
    return AppConfig(
      environment: env,
      apiBaseUrl: apiBaseUrl,
      sentryDsn: sentryDsn.isEmpty ? null : sentryDsn,
    );
  }
}

/// Override in [ProviderScope] at app startup with the value resolved
/// from [AppConfig.fromEnvironment]. Reading it before override throws.
final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError(
    'appConfigProvider must be overridden in ProviderScope before use.',
  );
});
