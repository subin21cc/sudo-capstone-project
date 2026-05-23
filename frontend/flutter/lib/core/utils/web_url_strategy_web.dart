import 'package:flutter_web_plugins/url_strategy.dart';

/// Switch URL routing to hash-based (`#/path`) so GitHub Pages hosts
/// the SPA without a 404 fallback (Q10 decision).
void useHashUrlStrategy() {
  setUrlStrategy(const HashUrlStrategy());
}
