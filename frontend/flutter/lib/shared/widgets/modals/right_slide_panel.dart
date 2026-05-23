import 'package:flutter/material.dart';

/// Helper that pushes [content] as a full-height panel sliding in from
/// the right (matches the React Notification/AI-Coach modals). Width
/// is capped at 420dp on tablet/desktop; on phones it occupies the
/// whole viewport.
Future<T?> showRightSlidePanel<T>(
  BuildContext context, {
  required Widget content,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '닫기',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (BuildContext ctx, _, _) {
      return SafeArea(
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Material(
              color: Theme.of(ctx).colorScheme.surface,
              child: SizedBox.expand(child: content),
            ),
          ),
        ),
      );
    },
    transitionBuilder:
        (BuildContext _, Animation<double> anim, _, Widget child) {
          final tween = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(position: anim.drive(tween), child: child);
        },
  );
}
