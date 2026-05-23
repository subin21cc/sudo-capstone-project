import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:oncare/app/router/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(AppRoutes.notification),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Dashboard (placeholder)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              icon: const Icon(Icons.smart_toy_outlined),
              label: const Text('Open AI Coach'),
              onPressed: () => context.push(AppRoutes.aiCoach),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.place_outlined),
              label: const Text('Find a place'),
              onPressed: () => context.push(AppRoutes.place),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Sign in (placeholder)'),
              onPressed: () => context.push(AppRoutes.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
