import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Injected once in `bootstrap.dart` (after `SharedPreferences.getInstance()`).
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope.',
  ),
  name: 'sharedPreferences',
);

/// Convenience wrapper exposing typed accessors for the keys the app uses.
class AppPrefs {
  AppPrefs(this._prefs);

  final SharedPreferences _prefs;

  static const String _kLocaleCode = 'locale_code';
  static const String _kOnboardingDone = 'onboarding_done';

  String? get localeCode => _prefs.getString(_kLocaleCode);
  Future<void> setLocaleCode(String? value) {
    if (value == null) return _prefs.remove(_kLocaleCode);
    return _prefs.setString(_kLocaleCode, value);
  }

  bool get onboardingDone => _prefs.getBool(_kOnboardingDone) ?? false;
  Future<void> setOnboardingDone(bool value) =>
      _prefs.setBool(_kOnboardingDone, value);
}

final appPrefsProvider = Provider<AppPrefs>(
  (ref) => AppPrefs(ref.watch(sharedPreferencesProvider)),
  name: 'appPrefs',
);
