import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Attaches the current bearer token to outgoing requests. Token
/// storage lands in Stage 4 (auth feature) — for now this is a stub
/// that simply forwards the request unchanged.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref);

  // Reserved for future use, e.g. ref.read(authTokenProvider).
  // ignore: unused_field
  final Ref _ref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO(stage-4): attach `Authorization: Bearer ${token}` when present.
    handler.next(options);
  }
}
