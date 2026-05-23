import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/core/errors/app_error.dart';
import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/spacing.dart';
import 'package:oncare/features/diet/presentation/controllers/diet_controller.dart';
import 'package:oncare/features/diet/presentation/widgets/diet_summary_card.dart';
import 'package:oncare/features/diet/presentation/widgets/meal_card.dart';
import 'package:oncare/gen/l10n/app_localizations.dart';
import 'package:oncare/shared/widgets/ai_coach_card.dart';
import 'package:oncare/shared/widgets/error_view.dart';
import 'package:oncare/shared/widgets/oncare_header.dart';

class DietRecordPage extends ConsumerWidget {
  const DietRecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final async = ref.watch(dietTodayProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: <Widget>[
          OncareHeader(title: l.pageDietTitle),
          Expanded(
            child: async.when(
              data: (day) => Center(
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
                      DietSummaryCard(day: day),
                      const SizedBox(height: AppSpacing.lg),
                      AiCoachCard(message: day.aiCoachMessage),
                      const SizedBox(height: AppSpacing.lg),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Text(
                          '오늘의 식단',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      for (final entry in day.entries) ...<Widget>[
                        MealCard(entry: entry),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object e, _) => ErrorView(
                error: e is AppError ? e : UnknownError(message: e.toString()),
                onRetry: () => ref.invalidate(dietTodayProvider),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryForeground,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('식단 추가 — 카메라/수동 입력은 Stage 8.7'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
