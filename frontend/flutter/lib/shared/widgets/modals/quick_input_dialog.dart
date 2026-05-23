import 'package:flutter/material.dart';

import 'package:oncare/design_system/atoms/app_button.dart';
import 'package:oncare/design_system/atoms/app_input.dart';
import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/radius.dart';
import 'package:oncare/design_system/tokens/spacing.dart';

enum QuickInputKind { weight, bloodPressure, bloodSugar }

/// Centered dialog that mirrors the React Dashboard's "체중/혈압/혈당
/// 입력" modal. Saving is currently a no-op — we just close the dialog
/// since real persistence belongs to a later stage.
Future<void> showQuickInputDialog(
  BuildContext context, {
  required QuickInputKind kind,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (BuildContext ctx) {
      final title = switch (kind) {
        QuickInputKind.weight => '체중 입력',
        QuickInputKind.bloodPressure => '혈압 입력',
        QuickInputKind.bloodSugar => '혈당 입력',
      };
      return Dialog(
        backgroundColor: AppColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadius.card),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _CloseButton(onTap: () => Navigator.of(ctx).pop()),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ..._fieldsFor(kind),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: '저장하기',
                fullWidth: true,
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      );
    },
  );
}

List<Widget> _fieldsFor(QuickInputKind kind) {
  return switch (kind) {
    QuickInputKind.weight => const <Widget>[
      AppInput(
        label: '체중 (kg)',
        hint: '72.0',
        keyboardType: TextInputType.number,
      ),
    ],
    QuickInputKind.bloodPressure => const <Widget>[
      AppInput(
        label: '수축기 (mmHg)',
        hint: '120',
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: AppSpacing.sm),
      AppInput(
        label: '이완기 (mmHg)',
        hint: '80',
        keyboardType: TextInputType.number,
      ),
    ],
    QuickInputKind.bloodSugar => const <Widget>[
      AppInput(
        label: '혈당 (mg/dL)',
        hint: '95',
        keyboardType: TextInputType.number,
      ),
    ],
  };
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 32,
          height: 32,
          child: Icon(Icons.close, size: 18),
        ),
      ),
    );
  }
}
