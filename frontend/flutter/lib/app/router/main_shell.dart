import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

/// The persistent `Scaffold` that hosts the bottom navigation bar and
/// renders whichever branch (Dashboard / Diet / Exercise / MyHealth)
/// the user has selected.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: l.navDashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.restaurant_outlined),
            selectedIcon: const Icon(Icons.restaurant),
            label: l.navDiet,
          ),
          NavigationDestination(
            icon: const Icon(Icons.fitness_center_outlined),
            selectedIcon: const Icon(Icons.fitness_center),
            label: l.navExercise,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline),
            selectedIcon: const Icon(Icons.favorite),
            label: l.navMyHealth,
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    // Tap the already-selected tab → pop to that branch's root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
