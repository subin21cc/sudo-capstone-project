import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/core/errors/app_error.dart';
import 'package:oncare/design_system/atoms/app_badge.dart';
import 'package:oncare/design_system/atoms/app_card.dart';
import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/spacing.dart';
import 'package:oncare/features/ai_coach/domain/entities/ai_coach_state.dart';
import 'package:oncare/features/ai_coach/presentation/controllers/ai_coach_controller.dart';
import 'package:oncare/shared/widgets/error_view.dart';

class AiCoachPanelBody extends ConsumerWidget {
  const AiCoachPanelBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final async = ref.watch(aiCoachStateProvider);
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.psychology_outlined,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '온이의 피드백',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Material(
                  color: AppColors.accent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.of(context).pop(),
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(Icons.close, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: async.when(
            data: (AiCoachState s) => _Body(state: s),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (Object e, _) => ErrorView(
              error: e is AppError ? e : UnknownError(message: e.toString()),
              onRetry: () => ref.invalidate(aiCoachStateProvider),
            ),
          ),
        ),
      ],
    );
  }
}

({String label, AppBadgeTone tone}) _tagDisplay(AiSuggestionTag t) =>
    switch (t) {
      AiSuggestionTag.diet => (label: '식단', tone: AppBadgeTone.warning),
      AiSuggestionTag.exercise => (label: '운동', tone: AppBadgeTone.success),
      AiSuggestionTag.sleep => (label: '수면', tone: AppBadgeTone.info),
      AiSuggestionTag.hydration => (label: '수분', tone: AppBadgeTone.info),
    };

class _Body extends StatelessWidget {
  const _Body({required this.state});
  final AiCoachState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: <Widget>[
        AppCard(
          color: AppColors.primary.withValues(alpha: 0.10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.smart_toy_outlined, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(state.greeting, style: theme.textTheme.bodyLarge),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final s in state.suggestions) ...<Widget>[
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppBadge(
                      label: _tagDisplay(s.tag).label,
                      tone: _tagDisplay(s.tag).tone,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(s.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(s.body, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}
