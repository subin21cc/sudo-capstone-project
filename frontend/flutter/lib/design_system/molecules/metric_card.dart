import 'package:flutter/material.dart';

import 'package:oncare/design_system/atoms/app_card.dart';
import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/radius.dart';
import 'package:oncare/design_system/tokens/spacing.dart';

enum MetricDeltaTone { positive, negative, neutral }

/// Single-metric card: title + big value + optional unit + optional
/// trend delta. Used on the dashboard and on each main tab summary.
class MetricCard extends StatelessWidget {
  const MetricCard({
    required this.title,
    required this.value,
    this.unit,
    this.delta,
    this.deltaTone = MetricDeltaTone.neutral,
    this.icon,
    this.accentColor,
    this.onTap,
    super.key,
  });

  final String title;
  final String value;
  final String? unit;
  final String? delta;
  final MetricDeltaTone deltaTone;
  final IconData? icon;
  final Color? accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = accentColor ?? theme.colorScheme.primary;
    final deltaColor = switch (deltaTone) {
      MetricDeltaTone.positive => AppColors.success,
      MetricDeltaTone.negative => AppColors.error,
      MetricDeltaTone.neutral => theme.colorScheme.onSurfaceVariant,
    };

    final semanticLabel = <String?>[
      title,
      value,
      unit,
      delta,
    ].whereType<String>().where((String s) => s.isNotEmpty).join(' ');

    return Semantics(
      container: true,
      label: semanticLabel,
      button: onTap != null,
      child: AppCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: const BorderRadius.all(AppRadius.sm),
                    ),
                    child: Icon(icon, color: accent, size: 18),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Expanded(child: Text(title, style: theme.textTheme.bodyMedium)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(value, style: theme.textTheme.displaySmall),
                if (unit != null) ...<Widget>[
                  const SizedBox(width: 4),
                  Text(unit!, style: theme.textTheme.bodyMedium),
                ],
              ],
            ),
            if (delta != null) ...<Widget>[
              const SizedBox(height: AppSpacing.xs),
              Text(
                delta!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: deltaColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
