import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/gen/l10n/app_localizations.dart';

/// Persistent `Scaffold` hosting the bottom navigation bar. Icons and
/// labels mirror the original React `BottomNav.tsx` (Home / 식단 /
/// 운동 / My).
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _Destination(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: l.navDashboard,
                    selected: navigationShell.currentIndex == 0,
                    onTap: () => _onTap(0),
                  ),
                  _Destination(
                    icon: Icons.restaurant_outlined,
                    activeIcon: Icons.restaurant,
                    label: l.navDiet,
                    selected: navigationShell.currentIndex == 1,
                    onTap: () => _onTap(1),
                  ),
                  _Destination(
                    icon: Icons.fitness_center_outlined,
                    activeIcon: Icons.fitness_center,
                    label: l.navExercise,
                    selected: navigationShell.currentIndex == 2,
                    onTap: () => _onTap(2),
                  ),
                  _Destination(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: l.navMyHealth,
                    selected: navigationShell.currentIndex == 3,
                    onTap: () => _onTap(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.mutedForeground;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(selected ? activeIcon : icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
