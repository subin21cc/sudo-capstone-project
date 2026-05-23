import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/core/errors/app_error.dart';
import 'package:oncare/design_system/atoms/app_card.dart';
import 'package:oncare/design_system/charts/app_bar_chart.dart';
import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/radius.dart';
import 'package:oncare/design_system/tokens/spacing.dart';
import 'package:oncare/features/exercise/domain/entities/exercise_week.dart';
import 'package:oncare/features/exercise/presentation/controllers/exercise_controller.dart';
import 'package:oncare/gen/l10n/app_localizations.dart';
import 'package:oncare/shared/widgets/ai_coach_card.dart';
import 'package:oncare/shared/widgets/error_view.dart';
import 'package:oncare/shared/widgets/oncare_header.dart';

String _typeLabel(ExerciseType t) => switch (t) {
  ExerciseType.cardio => '유산소',
  ExerciseType.strength => '근력',
  ExerciseType.yoga => '요가',
  ExerciseType.walking => '걷기',
};

IconData _typeIcon(ExerciseType t) => switch (t) {
  ExerciseType.cardio => Icons.directions_run,
  ExerciseType.strength => Icons.fitness_center,
  ExerciseType.yoga => Icons.self_improvement,
  ExerciseType.walking => Icons.directions_walk,
};

class ExercisePage extends ConsumerWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final async = ref.watch(exerciseWeekProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: <Widget>[
          OncareHeader(title: l.pageExerciseTitle),
          Expanded(
            child: async.when(
              data: (w) => _Body(week: w),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object e, _) => ErrorView(
                error: e is AppError ? e : UnknownError(message: e.toString()),
                onRetry: () => ref.invalidate(exerciseWeekProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.week});
  final ExerciseWeek week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 672),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: <Widget>[
            // Four stat cards (running / time / cal / streak).
            Row(
              children: <Widget>[
                Expanded(
                  child: _StatCard(
                    icon: Icons.flag_outlined,
                    label: '운동 횟수',
                    value: week.workoutCount.toString(),
                    unit: '회',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _StatCard(
                    icon: Icons.timer_outlined,
                    label: '총 시간',
                    value: week.totalMinutes.toString(),
                    unit: '분',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: <Widget>[
                Expanded(
                  child: _StatCard(
                    icon: Icons.local_fire_department_outlined,
                    label: '소모 칼로리',
                    value: week.totalCalories.toString(),
                    unit: 'kcal',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _StatCard(
                    icon: Icons.bolt_outlined,
                    label: '연속 일수',
                    value: week.streakDays.toString(),
                    unit: '일',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Weekly chart.
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '주간 운동 시간',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 180,
                    child: AppBarChart(
                      color: AppColors.primary,
                      values: week.dailyMinutes,
                      labels: week.dayLabels,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            AiCoachCard(message: week.aiCoachMessage),
            const SizedBox(height: AppSpacing.lg),

            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                '운동 기록',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            for (final s in week.sessions) ...<Widget>[
              AppCard(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: const BorderRadius.all(AppRadius.lg),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        _typeIcon(s.type),
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _typeLabel(s.type),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${s.dayLabel}요일',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${s.minutes}분',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      '${s.calories} kcal',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.mutedForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
