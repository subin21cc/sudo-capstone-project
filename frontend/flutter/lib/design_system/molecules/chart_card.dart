import 'package:flutter/material.dart';

import 'package:oncare/design_system/atoms/app_card.dart';
import 'package:oncare/design_system/tokens/spacing.dart';

/// Wraps a chart with a title row and a fixed-height plotting area
/// so feature pages don't reinvent the same scaffold.
class ChartCard extends StatelessWidget {
  const ChartCard({
    required this.title,
    required this.child,
    this.action,
    this.height = 200,
    super.key,
  });

  final String title;
  final Widget child;
  final Widget? action;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ?action,
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(height: height, child: child),
        ],
      ),
    );
  }
}
