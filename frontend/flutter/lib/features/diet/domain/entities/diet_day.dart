enum MealType { breakfast, lunch, dinner, snack }

MealType _mealFromString(String s) =>
    MealType.values.firstWhere((m) => m.name == s);

class FoodItem {
  const FoodItem({required this.name, required this.calories});
  final String name;
  final int calories;

  factory FoodItem.fromJson(Map<String, Object?> json) => FoodItem(
    name: json['name']! as String,
    calories: (json['calories']! as num).toInt(),
  );
}

class DietEntry {
  const DietEntry({
    this.id,
    required this.mealType,
    required this.timeLabel,
    required this.foods,
    required this.totalCalories,
    this.sodiumMg = 0,
    this.sugarG = 0,
  });

  final String? id;
  final MealType mealType;
  final String timeLabel;
  final List<FoodItem> foods;
  final int totalCalories;
  final int sodiumMg;
  final int sugarG;

  factory DietEntry.fromJson(Map<String, Object?> json) => DietEntry(
    id: json['id'] as String?,
    mealType: _mealFromString(json['meal_type']! as String),
    timeLabel: json['time_label']! as String,
    foods: (json['foods']! as List<Object?>)
        .cast<Map<String, Object?>>()
        .map(FoodItem.fromJson)
        .toList(),
    totalCalories: (json['total_calories']! as num).toInt(),
    sodiumMg: (json['sodium_mg'] as num?)?.toInt() ?? 0,
    sugarG: (json['sugar_g'] as num?)?.toInt() ?? 0,
  );
}

class DietMacros {
  const DietMacros({
    required this.carbsPct,
    required this.proteinPct,
    required this.fatPct,
  });

  final int carbsPct;
  final int proteinPct;
  final int fatPct;

  factory DietMacros.fromJson(Map<String, Object?> json) => DietMacros(
    carbsPct: (json['carbs_pct']! as num).toInt(),
    proteinPct: (json['protein_pct']! as num).toInt(),
    fatPct: (json['fat_pct']! as num).toInt(),
  );
}

class DietDay {
  const DietDay({
    required this.entries,
    required this.totalCalories,
    required this.macros,
    required this.totalSodiumMg,
    required this.totalSugarG,
    required this.aiCoachMessage,
  });

  final List<DietEntry> entries;
  final int totalCalories;
  final DietMacros macros;
  final int totalSodiumMg;
  final int totalSugarG;
  final String aiCoachMessage;

  factory DietDay.fromJson(Map<String, Object?> json) => DietDay(
    entries: (json['entries']! as List<Object?>)
        .cast<Map<String, Object?>>()
        .map(DietEntry.fromJson)
        .toList(),
    totalCalories: (json['total_calories']! as num).toInt(),
    totalSodiumMg: (json['total_sodium_mg']! as num).toInt(),
    totalSugarG: (json['total_sugar_g']! as num).toInt(),
    macros: DietMacros.fromJson(json['macros']! as Map<String, Object?>),
    aiCoachMessage: json['ai_coach_message']! as String,
  );
}
