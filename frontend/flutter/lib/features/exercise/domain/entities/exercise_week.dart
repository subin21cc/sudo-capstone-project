enum ExerciseType { cardio, strength, yoga, walking }

class ExerciseSession {
  const ExerciseSession({
    required this.dayLabel,
    required this.type,
    required this.minutes,
    required this.calories,
  });

  final String dayLabel;
  final ExerciseType type;
  final int minutes;
  final int calories;
}

class ExerciseWeek {
  const ExerciseWeek({
    required this.sessions,
    required this.dailyMinutes,
    required this.dayLabels,
    required this.totalMinutes,
    required this.totalCalories,
    required this.streakDays,
    required this.aiCoachMessage,
  });

  final List<ExerciseSession> sessions;
  final List<double> dailyMinutes;
  final List<String> dayLabels;
  final int totalMinutes;
  final int totalCalories;
  final int streakDays;
  final String aiCoachMessage;

  int get workoutCount => sessions.length;
}
