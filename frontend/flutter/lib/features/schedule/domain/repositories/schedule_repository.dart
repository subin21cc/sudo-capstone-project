import 'package:oncare/features/schedule/domain/entities/schedule_event.dart';

abstract class ScheduleRepository {
  /// Events whose `date` matches the given `YYYY-MM-DD` string.
  Future<List<ScheduleEvent>> fetchByDate(String date);
}
