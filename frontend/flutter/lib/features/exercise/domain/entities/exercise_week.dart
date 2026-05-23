enum ExerciseType { cardio, strength, yoga, walking }

ExerciseType _exerciseTypeFromString(String s) =>
    ExerciseType.values.firstWhere((t) => t.name == s);

class ExerciseSession {
  const ExerciseSession({
    this.id,
    required this.dayLabel,
    required this.type,
    required this.minutes,
    required this.calories,
  });

  final String? id;
  final String dayLabel;
  final ExerciseType type;
  final int minutes;
  final int calories;

  factory ExerciseSession.fromJson(Map<String, Object?> json) =>
      ExerciseSession(
        id: json['id'] as String?,
        dayLabel: json['day_label']! as String,
        type: _exerciseTypeFromString(json['type']! as String),
        minutes: (json['minutes']! as num).toInt(),
        calories: (json['calories']! as num).toInt(),
      );
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

  factory ExerciseWeek.fromJson(Map<String, Object?> json) => ExerciseWeek(
    sessions: (json['sessions']! as List<Object?>)
        .cast<Map<String, Object?>>()
        .map(ExerciseSession.fromJson)
        .toList(),
    dailyMinutes: (json['daily_minutes']! as List<Object?>)
        .map((v) => (v! as num).toDouble())
        .toList(),
    dayLabels: (json['day_labels']! as List<Object?>).cast<String>().toList(),
    totalMinutes: (json['total_minutes']! as num).toInt(),
    totalCalories: (json['total_calories']! as num).toInt(),
    streakDays: (json['streak_days']! as num).toInt(),
    aiCoachMessage: json['ai_coach_message']! as String,
  );
}
