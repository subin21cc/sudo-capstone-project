import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/core/config/app_config.dart';

class OncareApp extends ConsumerWidget {
  const OncareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final base = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3F8EFC),
    );
    final dark = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3F8EFC),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'Oncare',
      debugShowCheckedModeBanner: false,
      theme: base,
      darkTheme: dark,
      home: const BootstrapPlaceholder(),
    );
  }
}

/// Temporary landing page until the router & feature pages land
/// (Stage 2.1 / Stage 4). Confirms config injection works.
class BootstrapPlaceholder extends ConsumerWidget {
  const BootstrapPlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Oncare')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bootstrap successful',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              _kv(theme, 'env', config.environment.name),
              _kv(theme, 'api', config.apiBaseUrl),
              _kv(theme, 'sentry', config.sentryDsn ?? '(none)'),
              const SizedBox(height: 24),
              Text(
                'Router & feature pages land in Stage 2.1 / Stage 4.',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kv(ThemeData theme, String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$k: $v', style: theme.textTheme.bodyMedium),
    );
  }
}
