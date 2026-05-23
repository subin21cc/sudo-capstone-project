import 'package:flutter/material.dart';

import 'package:oncare/core/errors/app_error.dart';

/// Generic error placeholder for any page that needs to show an
/// [AppError]. Pages should prefer this over re-implementing their
/// own.
class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, this.onRetry, super.key});

  final AppError error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = switch (error) {
      NetworkError() => 'Network problem',
      UnauthorizedError() => 'Sign in required',
      NotFoundError() => 'Not found',
      ServerError() => 'Server error',
      CancelledError() => 'Cancelled',
      UnknownError() => 'Something went wrong',
    };
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleMedium),
            if (error.message != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(error.message!, textAlign: TextAlign.center),
            ],
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
