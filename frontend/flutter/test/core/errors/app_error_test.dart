import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/core/errors/app_error.dart';
import 'package:oncare/core/errors/result.dart';

void main() {
  RequestOptions opts() => RequestOptions(path: '/ping');

  group('AppError.fromDio', () {
    test('timeouts → NetworkError', () {
      final e = AppError.fromDio(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      expect(e, isA<NetworkError>());
    });

    test('cancel → CancelledError', () {
      final e = AppError.fromDio(
        DioException(requestOptions: opts(), type: DioExceptionType.cancel),
      );
      expect(e, isA<CancelledError>());
    });

    test('401 → UnauthorizedError', () {
      final e = AppError.fromDio(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response<void>(requestOptions: opts(), statusCode: 401),
        ),
      );
      expect(e, isA<UnauthorizedError>());
    });

    test('404 → NotFoundError', () {
      final e = AppError.fromDio(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response<void>(requestOptions: opts(), statusCode: 404),
        ),
      );
      expect(e, isA<NotFoundError>());
    });

    test('500 → ServerError carrying status code', () {
      final e = AppError.fromDio(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response<void>(requestOptions: opts(), statusCode: 502),
        ),
      );
      expect(e, isA<ServerError>());
      expect((e as ServerError).statusCode, 502);
    });
  });

  group('Result<T>', () {
    test('ok branches through fold', () {
      final r = Result<int>.ok(42);
      expect(r.isOk, isTrue);
      expect(r.valueOrNull, 42);
      expect(r.errorOrNull, isNull);
      expect(r.fold(ok: (v) => 'ok($v)', err: (_) => 'err'), 'ok(42)');
    });

    test('err branches through fold', () {
      const err = NetworkError(message: 'down');
      final r = Result<int>.err(err);
      expect(r.isError, isTrue);
      expect(r.valueOrNull, isNull);
      expect(r.errorOrNull, same(err));
      expect(
        r.fold(ok: (_) => 'ok', err: (e) => e.runtimeType.toString()),
        'NetworkError',
      );
    });
  });
}
