import 'package:oncare/app/bootstrap.dart';
import 'package:oncare/core/utils/web_url_strategy_stub.dart'
    if (dart.library.js_interop) 'package:oncare/core/utils/web_url_strategy_web.dart';

void main() {
  useHashUrlStrategy();
  bootstrap();
}
