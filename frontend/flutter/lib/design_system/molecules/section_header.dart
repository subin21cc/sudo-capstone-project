import 'package:flutter/material.dart';

import 'package:oncare/design_system/tokens/spacing.dart';

/// Title row used to group sections inside a page. Optional trailing
/// action (e.g. "See all" button) renders on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {this.action, super.key});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ?action,
        ],
      ),
    );
  }
}
