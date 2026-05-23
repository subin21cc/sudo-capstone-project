import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

import 'package:oncare/core/network/interceptors/mock_api_interceptor.dart';

void main() {
  // Silence the logger so test output stays clean.
  final logger = Logger(level: Level.off);

  Dio buildDio() {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(MockApiInterceptor(logger));
    return dio;
  }

  test('GET /ping returns canned pong payload', () async {
    final dio = buildDio();
    final res = await dio.get<Map<String, Object?>>('/ping');
    expect(res.statusCode, 200);
    expect(res.data?['message'], 'pong (mock)');
  });

  test('Unknown path falls through to the next interceptor', () async {
    final dio = buildDio();
    // No HttpClient is reachable here, so a real fetch must error out.
    await expectLater(
      dio.get<dynamic>('/does-not-exist'),
      throwsA(isA<DioException>()),
    );
  });
}
