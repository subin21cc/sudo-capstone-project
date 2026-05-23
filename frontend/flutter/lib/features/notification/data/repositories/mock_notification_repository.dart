import 'package:oncare/features/notification/domain/entities/alert_item.dart';
import 'package:oncare/features/notification/domain/repositories/notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  const MockNotificationRepository();

  @override
  Future<List<AlertItem>> fetchAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return const <AlertItem>[
      AlertItem(
        id: 'a1',
        title: '식단 입력 알림',
        body: '오늘 점심 입력이 비어있어요.',
        timeAgo: '10분 전',
        category: AlertCategory.reminder,
      ),
      AlertItem(
        id: 'a2',
        title: '운동 목표 달성',
        body: '주간 운동 240분 달성!',
        timeAgo: '1시간 전',
        category: AlertCategory.achievement,
      ),
      AlertItem(
        id: 'a3',
        title: '체중 측정 권장',
        body: '오늘 체중을 기록해 보세요.',
        timeAgo: '3시간 전',
        category: AlertCategory.healthCheck,
        read: true,
      ),
      AlertItem(
        id: 'a4',
        title: '서비스 점검 안내',
        body: '내일 02:00~03:00 점검 예정입니다.',
        timeAgo: '어제',
        category: AlertCategory.system,
        read: true,
      ),
    ];
  }
}
