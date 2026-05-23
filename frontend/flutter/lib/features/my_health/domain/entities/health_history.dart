class UserProfile {
  const UserProfile({required this.name, required this.email});
  final String name;
  final String email;
}

enum RiskLevel { low, medium, high }

class RiskAlert {
  const RiskAlert({
    required this.title,
    required this.body,
    required this.level,
  });
  final String title;
  final String body;
  final RiskLevel level;
}

enum IndicatorKind { weight, bloodPressure, bloodSugar }

class IndicatorTrend {
  const IndicatorTrend({
    required this.kind,
    required this.label,
    required this.latestValue,
    required this.unit,
    required this.deltaText,
    required this.improving,
    required this.last7Days,
  });

  final IndicatorKind kind;
  final String label;
  final String latestValue;
  final String unit;
  final String deltaText;
  final bool improving;

  /// Normalised series (0..1) used to paint the small inline sparkline.
  final List<double> last7Days;
}

class SettingsItem {
  const SettingsItem({required this.label, required this.icon});
  final String label;
  final String icon; // emoji
}

class MyHealthState {
  const MyHealthState({
    required this.profile,
    required this.risk,
    required this.indicators,
    required this.activityPoints,
    required this.activityRank,
    required this.settings,
  });

  final UserProfile profile;
  final RiskAlert risk;
  final List<IndicatorTrend> indicators;
  final int activityPoints;
  final int activityRank;
  final List<SettingsItem> settings;
}
