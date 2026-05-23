import 'package:dio/dio.dart';

import 'package:oncare/features/schedule/domain/entities/schedule_event.dart';
import 'package:oncare/features/schedule/domain/repositories/schedule_repository.dart';

/// Network-side [ScheduleRepository]. dev/local builds get served by
/// `LocalApiInterceptor`; prod hits FastAPI's `GET /schedule/events`.
class DioScheduleRepository implements ScheduleRepository {
  DioScheduleRepository(this._dio);
  final Dio _dio;

  @override
  Future<List<ScheduleEvent>> fetchByDate(String date) async {
    final res = await _dio.get<List<Object?>>(
      '/schedule/events',
      queryParameters: <String, Object?>{'date': date},
    );
    final rows = res.data ?? const <Object?>[];
    return rows
        .cast<Map<String, Object?>>()
        .map(ScheduleEvent.fromJson)
        .toList();
  }
}
