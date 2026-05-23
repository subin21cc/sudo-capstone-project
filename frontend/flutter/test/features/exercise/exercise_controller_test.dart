import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/exercise/presentation/controllers/exercise_controller.dart';

void main() {
  test('exerciseWeekProvider provides 7 days, sane totals', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final week = await container.read(exerciseWeekProvider.future);
    expect(week.dailyMinutes.length, 7);
    expect(week.dayLabels.length, 7);
    expect(week.totalMinutes, 240);
    expect(week.totalCalories, 1690);
    expect(week.streakDays, 5);
    expect(week.aiCoachMessage, isNotEmpty);
    expect(week.sessions, isNotEmpty);
  });
}
