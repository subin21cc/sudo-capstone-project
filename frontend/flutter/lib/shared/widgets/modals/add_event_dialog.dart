import 'package:flutter/material.dart';

import 'package:oncare/design_system/atoms/app_button.dart';
import 'package:oncare/design_system/atoms/app_input.dart';
import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/radius.dart';
import 'package:oncare/design_system/tokens/spacing.dart';

const List<String> _categories = <String>['병원', '운동', '식사', '약 복용', '기타'];

Future<void> showAddEventDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (BuildContext ctx) => const _AddEventDialog(),
  );
}

class _AddEventDialog extends StatefulWidget {
  const _AddEventDialog();
  @override
  State<_AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<_AddEventDialog> {
  String _category = _categories.first;

  @override
  Widget build(BuildContext context) {
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
                    '일정 추가',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
            const SizedBox(height: AppSpacing.md),
            const AppInput(label: '일정 제목', hint: '예: 병원 정기검진'),
            const SizedBox(height: AppSpacing.sm),
            const AppInput(label: '날짜', hint: '2026-05-14'),
            const SizedBox(height: AppSpacing.sm),
            const AppInput(label: '시간', hint: '10:00'),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: const BorderRadius.all(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  onChanged: (String? value) {
                    if (value != null) setState(() => _category = value);
                  },
                  items: <DropdownMenuItem<String>>[
                    for (final c in _categories)
                      DropdownMenuItem<String>(value: c, child: Text(c)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: '추가하기',
              fullWidth: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
