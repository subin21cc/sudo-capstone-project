import 'package:dio/dio.dart';

import 'package:oncare/features/diet/domain/entities/diet_day.dart';
import 'package:oncare/features/diet/domain/repositories/diet_repository.dart';

/// Real-network implementation of [DietRepository]. Issues HTTP
/// requests via [Dio]; the dev/local build serves them out of
/// `LocalApiInterceptor` (drift-backed). FastAPI takes over once
/// `USE_MOCK_API=false`.
class DioDietRepository implements DietRepository {
  DioDietRepository(this._dio);
  final Dio _dio;

  @override
  Future<DietDay> fetchToday() async {
    final res = await _dio.get<Map<String, Object?>>('/diet/days/today');
    return DietDay.fromJson(res.data!);
  }
}
