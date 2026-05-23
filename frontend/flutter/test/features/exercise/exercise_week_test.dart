import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/exercise/domain/entities/exercise_week.dart';

void main() {
  test('ExerciseWeek exposes workoutCount and stays const-constructible', () {
    const week = ExerciseWeek(
      sessions: <ExerciseSession>[],
      dailyMinutes: <double>[10, 20, 30],
      dayLabels: <String>['a', 'b', 'c'],
      totalMinutes: 60,
      totalCalories: 400,
      streakDays: 3,
      aiCoachMessage: 'hi',
    );
    expect(week.totalMinutes, 60);
    expect(week.totalCalories, 400);
    expect(week.streakDays, 3);
    expect(week.workoutCount, 0);
  });
}
