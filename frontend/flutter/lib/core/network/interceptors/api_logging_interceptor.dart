import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// One-line request/response/error logger. Enabled outside prod via
/// `dioProvider`.
class ApiLoggingInterceptor extends Interceptor {
  ApiLoggingInterceptor(this._logger);
  final Logger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('[api>] ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.d('[api<] ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.w('[api!] ${err.type} ${err.requestOptions.uri} :: ${err.message}');
    handler.next(err);
  }
}
