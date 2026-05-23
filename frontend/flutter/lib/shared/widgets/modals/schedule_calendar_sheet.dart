import 'package:flutter/material.dart';

import 'package:oncare/design_system/tokens/colors.dart';
import 'package:oncare/design_system/tokens/radius.dart';
import 'package:oncare/design_system/tokens/spacing.dart';
import 'package:oncare/shared/widgets/modals/add_event_dialog.dart';

class CalendarEvent {
  const CalendarEvent({
    required this.title,
    required this.time,
    required this.color,
  });
  final String title;
  final String time;
  final Color color;
}

/// Bottom sheet that mirrors the React Dashboard "일정 관리" modal.
/// The grid is rendered for the supplied [initialDate] month with the
/// React mock events injected via [events] (keyed by day-of-month).
Future<void> showScheduleCalendarSheet(
  BuildContext context, {
  DateTime? initialDate,
  Map<int, List<CalendarEvent>> events = _defaultEvents,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    barrierColor: Colors.black54,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: AppRadius.card),
    ),
    builder: (BuildContext ctx) {
      return _CalendarBody(
        initialDate: initialDate ?? DateTime(2026, 5, 14),
        events: events,
      );
    },
  );
}

const Map<int, List<CalendarEvent>> _defaultEvents = <int, List<CalendarEvent>>{
  10: <CalendarEvent>[
    CalendarEvent(title: '건강검진', time: '09:00', color: Color(0xFFDBEAFE)),
  ],
  14: <CalendarEvent>[
    CalendarEvent(title: '병원 정기검진', time: '10:00', color: Color(0xFFFEE2E2)),
    CalendarEvent(title: '헬스장 운동', time: '18:00', color: Color(0xFFDCFCE7)),
  ],
  18: <CalendarEvent>[
    CalendarEvent(title: '영양 상담', time: '14:00', color: Color(0xFFEDE9FE)),
  ],
  20: <CalendarEvent>[
    CalendarEvent(title: '요가 수업', time: '10:00', color: Color(0xFFFCE7F3)),
    CalendarEvent(title: '저녁 식사', time: '19:00', color: Color(0xFFFFEDD5)),
  ],
};

class _CalendarBody extends StatefulWidget {
  const _CalendarBody({required this.initialDate, required this.events});
  final DateTime initialDate;
  final Map<int, List<CalendarEvent>> events;

  @override
  State<_CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<_CalendarBody> {
  late DateTime _month = DateTime(
    widget.initialDate.year,
    widget.initialDate.month,
  );

  static const List<String> _weekdays = <String>[
    '일',
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = _daysInGrid(_month);
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: <Widget>[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '일정 관리',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _CircleClose(onTap: () => Navigator.of(context).pop()),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => setState(
                    () => _month = DateTime(_month.year, _month.month - 1),
                  ),
                ),
                Text(
                  '${_month.year}년 ${_month.month}월',
                  style: theme.textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => setState(
                    () => _month = DateTime(_month.year, _month.month + 1),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => showAddEventDialog(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(AppRadius.md),
                    ),
                  ),
                  child: const Text('일정 추가'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            // Weekday header row.
            Row(
              children: <Widget>[
                for (final w in _weekdays)
                  Expanded(
                    child: Container(
                      color: AppColors.accent,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        w,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.mutedForeground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Calendar grid.
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.75,
                ),
                itemCount: days.length,
                itemBuilder: (BuildContext _, int i) {
                  final day = days[i];
                  if (day == null) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: AppColors.border),
                          bottom: BorderSide(color: AppColors.border),
                        ),
                      ),
                    );
                  }
                  final isToday =
                      day.day == 14 && _month.month == 5 && _month.year == 2026;
                  final dayEvents = widget.events[day.day] ?? <CalendarEvent>[];
                  return Container(
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.primary.withValues(alpha: 0.05)
                          : null,
                      border: const Border(
                        right: BorderSide(color: AppColors.border),
                        bottom: BorderSide(color: AppColors.border),
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${day.day}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isToday ? AppColors.primary : null,
                          ),
                        ),
                        const SizedBox(height: 2),
                        for (final e in dayEvents)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: e.color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${e.time} ${e.title}',
                              style: const TextStyle(fontSize: 9),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  static List<DateTime?> _daysInGrid(DateTime month) {
    final first = DateTime(month.year, month.month);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final leading = first.weekday % 7; // Sunday-first
    return <DateTime?>[
      for (int i = 0; i < leading; i++) null,
      for (int d = 1; d <= lastDay.day; d++)
        DateTime(month.year, month.month, d),
    ];
  }
}

class _CircleClose extends StatelessWidget {
  const _CircleClose({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 32,
          height: 32,
          child: Icon(Icons.close, size: 18),
        ),
      ),
    );
  }
}
