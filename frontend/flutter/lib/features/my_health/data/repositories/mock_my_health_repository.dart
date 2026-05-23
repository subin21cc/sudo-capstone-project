import 'package:oncare/features/my_health/domain/entities/health_history.dart';
import 'package:oncare/features/my_health/domain/repositories/my_health_repository.dart';

class MockMyHealthRepository implements MyHealthRepository {
  const MockMyHealthRepository();

  @override
  Future<HealthHistory> fetchHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const HealthHistory(
      goalWeight: 65.0,
      readings: <VitalsReading>[
        VitalsReading(
          dayLabel: '월',
          weightKg: 70.4,
          systolic: 118,
          diastolic: 76,
          heartRate: 72,
        ),
        VitalsReading(
          dayLabel: '화',
          weightKg: 70.1,
          systolic: 116,
          diastolic: 75,
          heartRate: 70,
        ),
        VitalsReading(
          dayLabel: '수',
          weightKg: 69.8,
          systolic: 119,
          diastolic: 78,
          heartRate: 74,
        ),
        VitalsReading(
          dayLabel: '목',
          weightKg: 69.4,
          systolic: 117,
          diastolic: 75,
          heartRate: 71,
        ),
        VitalsReading(
          dayLabel: '금',
          weightKg: 69.0,
          systolic: 115,
          diastolic: 74,
          heartRate: 69,
        ),
        VitalsReading(
          dayLabel: '토',
          weightKg: 68.6,
          systolic: 116,
          diastolic: 73,
          heartRate: 68,
        ),
        VitalsReading(
          dayLabel: '일',
          weightKg: 68.2,
          systolic: 114,
          diastolic: 72,
          heartRate: 67,
        ),
      ],
    );
  }
}
