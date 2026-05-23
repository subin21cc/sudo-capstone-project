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

  test('ExerciseWeek.fromJson parses the LocalApi shape', () {
    final week = ExerciseWeek.fromJson(<String, Object?>{
      'sessions': <Object?>[
        <String, Object?>{
          'id': 's-1',
          'day_label': '월',
          'type': 'cardio',
          'minutes': 30,
          'calories': 250,
        },
      ],
      'daily_minutes': <Object?>[30, 0, 45, 0, 60, 0, 0],
      'day_labels': <Object?>['월', '화', '수', '목', '금', '토', '일'],
      'total_minutes': 135,
      'total_calories': 1050,
      'streak_days': 3,
      'ai_coach_message': 'hi',
    });
    expect(week.sessions.length, 1);
    expect(week.sessions.first.id, 's-1');
    expect(week.sessions.first.type, ExerciseType.cardio);
    expect(week.dailyMinutes, <double>[30, 0, 45, 0, 60, 0, 0]);
    expect(week.streakDays, 3);
  });
}
