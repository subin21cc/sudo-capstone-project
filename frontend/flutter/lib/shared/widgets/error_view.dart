import 'package:flutter/material.dart';

import 'package:oncare/core/errors/app_error.dart';
import 'package:oncare/gen/l10n/app_localizations.dart';

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
    final l = AppLocalizations.of(context);
    final title = switch (error) {
      NetworkError() => l.errorNetwork,
      UnauthorizedError() => l.errorUnauthorized,
      NotFoundError() => l.errorNotFound,
      ServerError() => l.errorServer,
      CancelledError() => l.errorCancelled,
      UnknownError() => l.errorUnknown,
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
                label: Text(l.actionRetry),
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
