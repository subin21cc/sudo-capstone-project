import 'package:oncare/features/schedule/domain/entities/schedule_event.dart';
import 'package:oncare/features/schedule/domain/repositories/schedule_repository.dart';

class MockScheduleRepository implements ScheduleRepository {
  const MockScheduleRepository();

  @override
  Future<List<ScheduleEvent>> fetchByDate(String date) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return <ScheduleEvent>[
      ScheduleEvent(
        id: 'mock-hospital',
        date: date,
        time: '10:00',
        title: '병원 정기검진',
        category: ScheduleCategory.hospital,
        emoji: '🏥',
        colorHex: '#FEE2E2',
      ),
      ScheduleEvent(
        id: 'mock-gym',
        date: date,
        time: '18:00',
        title: '헬스장 운동',
        category: ScheduleCategory.exercise,
        emoji: '💪',
        colorHex: '#DCFCE7',
      ),
    ];
  }
}
