import 'package:oncare/features/diet/domain/entities/diet_day.dart';
import 'package:oncare/features/diet/domain/repositories/diet_repository.dart';

class MockDietRepository implements DietRepository {
  const MockDietRepository();

  @override
  Future<DietDay> fetchToday() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return const DietDay(
      entries: <DietEntry>[
        DietEntry(
          mealType: MealType.breakfast,
          timeLabel: '08:20',
          totalCalories: 315,
          sodiumMg: 380,
          sugarG: 18,
          foods: <FoodItem>[
            FoodItem(name: '오트밀', calories: 220),
            FoodItem(name: '바나나 1개', calories: 90),
            FoodItem(name: '아메리카노', calories: 5),
          ],
        ),
        DietEntry(
          mealType: MealType.lunch,
          timeLabel: '12:40',
          totalCalories: 530,
          sodiumMg: 1120,
          sugarG: 14,
          foods: <FoodItem>[
            FoodItem(name: '닭가슴살 샐러드', calories: 380),
            FoodItem(name: '현미밥 반공기', calories: 150),
          ],
        ),
        DietEntry(
          mealType: MealType.dinner,
          timeLabel: '19:00',
          totalCalories: 575,
          sodiumMg: 600,
          sugarG: 13,
          foods: <FoodItem>[
            FoodItem(name: '연어 스테이크', calories: 420),
            FoodItem(name: '구운 야채', calories: 155),
          ],
        ),
      ],
      totalCalories: 1420,
      totalSodiumMg: 2100,
      totalSugarG: 45,
      macros: DietMacros(carbsPct: 50, proteinPct: 30, fatPct: 20),
      aiCoachMessage: '오늘 점심에 나트륨이 많았어요. 저녁은 담백한 구이/샐러드로 균형을 맞춰봐요!',
    );
  }
}
