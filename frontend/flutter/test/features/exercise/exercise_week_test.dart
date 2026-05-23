import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/exercise/domain/entities/exercise_week.dart';

void main() {
  test('averageMinutes is 0 when dailyMinutes is empty', () {
    const week = ExerciseWeek(
      sessions: <ExerciseSession>[],
      dailyMinutes: <double>[],
      dayLabels: <String>[],
      totalMinutes: 0,
    );
    expect(week.averageMinutes, 0);
  });

  test('averageMinutes is the arithmetic mean of dailyMinutes', () {
    const week = ExerciseWeek(
      sessions: <ExerciseSession>[],
      dailyMinutes: <double>[10, 20, 30],
      dayLabels: <String>['a', 'b', 'c'],
      totalMinutes: 60,
    );
    expect(week.averageMinutes, 20);
  });
}
