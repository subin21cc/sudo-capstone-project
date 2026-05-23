import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// User-controlled app locale. `null` follows the system locale.
/// A future settings page mutates this; persistence to `AppPrefs`
/// lands together with that page.
final localeProvider = StateProvider<Locale?>((ref) => null, name: 'locale');
