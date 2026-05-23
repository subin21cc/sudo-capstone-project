import 'package:flutter/material.dart';

import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/spacing.dart';

/// Sticky top header that mirrors the React `Header.tsx`:
/// h1 title on the left, a bell and a calendar circular icon button on
/// the right. The bell shows a small orange dot when there are unread
/// notifications.
class OncareHeader extends StatelessWidget implements PreferredSizeWidget {
  const OncareHeader({
    required this.title,
    this.hasUnreadNotifications = true,
    this.onNotificationTap,
    this.onCalendarTap,
    this.trailingExtras = const <Widget>[],
    super.key,
  });

  final String title;
  final bool hasUnreadNotifications;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCalendarTap;
  final List<Widget> trailingExtras;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: AppColors.background,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          bottom: false,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 672),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ...trailingExtras,
                  _CircleIconButton(
                    tooltip: '알림',
                    icon: Icons.notifications_none,
                    showBadge: hasUnreadNotifications,
                    onTap: onNotificationTap,
                  ),
                  const SizedBox(width: 4),
                  _CircleIconButton(
                    tooltip: '일정',
                    icon: Icons.calendar_today_outlined,
                    onTap: onCalendarTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    this.showBadge = false,
    this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final bool showBadge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onTap,
                  child: Center(
                    child: Icon(icon, size: 22, color: AppColors.foreground),
                  ),
                ),
              ),
            ),
            if (showBadge)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
