import 'package:oncare/features/notification/domain/entities/alert_item.dart';

abstract class NotificationRepository {
  /// All notifications, newest first.
  Future<List<AlertItem>> fetchAll();
}
