import 'package:flutter/material.dart';

/// "Nothing to show yet" placeholder, intended for list / detail pages
/// before the user has any data.
class EmptyState extends StatelessWidget {
  const EmptyState({required this.title, this.message, this.icon, super.key});

  final String title;
  final String? message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: 48, color: theme.colorScheme.outline),
              const SizedBox(height: 16),
            ],
            Text(title, style: theme.textTheme.titleMedium),
            if (message != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(message!, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
