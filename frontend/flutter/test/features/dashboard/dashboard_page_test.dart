import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

import 'package:oncare/app/app.dart';
import 'package:oncare/core/config/app_config.dart';
import 'package:oncare/core/logging/app_logger.dart';
import 'package:oncare/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:oncare/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:oncare/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:oncare/shared/services/locale_provider.dart';

class _StubDashboardRepository implements DashboardRepository {
  const _StubDashboardRepository();
  @override
  Future<DashboardSummary> fetchSummary() async => const DashboardSummary(
    caloriesToday: 1200,
    caloriesGoal: 2000,
    exerciseMinutesToday: 25,
    weightKg: 70.0,
    weeklyWeight: <double>[72, 71.8, 71.5, 71.2, 70.9, 70.4, 70.0],
  );
}

class _FailingDashboardRepository implements DashboardRepository {
  const _FailingDashboardRepository();
  @override
  Future<DashboardSummary> fetchSummary() async {
    throw StateError('boom');
  }
}

void main() {
  Future<void> pumpApp(WidgetTester tester, DashboardRepository repo) async {
    const config = AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://dev.api.test',
      useMockApi: true,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          appConfigProvider.overrideWithValue(config),
          appLoggerProvider.overrideWithValue(Logger(level: Level.off)),
          localeProvider.overrideWith((ref) => const Locale('en')),
          dashboardRepositoryProvider.overrideWithValue(repo),
        ],
        child: const OncareApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Dashboard data path renders metric cards', (tester) async {
    await pumpApp(tester, const _StubDashboardRepository());
    expect(find.text('1200'), findsOneWidget); // calories value
    expect(find.text('25'), findsOneWidget); // exercise minutes
    expect(find.text('70.0'), findsOneWidget); // weight (one decimal)
  });

  testWidgets('Dashboard error path shows ErrorView retry button', (
    tester,
  ) async {
    await pumpApp(tester, const _FailingDashboardRepository());
    expect(find.text('Retry'), findsOneWidget);
  });
}
