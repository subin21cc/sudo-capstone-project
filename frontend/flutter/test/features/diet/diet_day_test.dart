import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/diet/domain/entities/diet_day.dart';

void main() {
  test('Mock DietDay constructs with non-empty entries', () {
    const day = DietDay(
      entries: <DietEntry>[
        DietEntry(
          mealType: MealType.breakfast,
          timeLabel: '08:00',
          totalCalories: 300,
          foods: <FoodItem>[FoodItem(name: 'oat', calories: 300)],
        ),
      ],
      totalCalories: 300,
      macros: DietMacros(carbsPct: 60, proteinPct: 20, fatPct: 20),
    );
    expect(day.entries.first.mealType, MealType.breakfast);
    expect(day.totalCalories, 300);
    expect(day.macros.proteinPct, 20);
  });
}
