import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

/// Logs every push/pop/replace done by go_router. Attached in
/// non-prod builds only.
class NavLoggerObserver extends NavigatorObserver {
  NavLoggerObserver(this._logger);
  final Logger _logger;

  String _name(Route<dynamic>? route) =>
      route?.settings.name ?? route?.runtimeType.toString() ?? 'unknown';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.d('[nav>] push ${_name(route)} (from ${_name(previousRoute)})');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.d('[nav<] pop ${_name(route)} (to ${_name(previousRoute)})');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger.d('[nav~] replace ${_name(oldRoute)} → ${_name(newRoute)}');
  }
}
