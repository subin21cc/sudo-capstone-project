import 'package:oncare/features/my_health/domain/entities/health_history.dart';
import 'package:oncare/features/my_health/domain/repositories/my_health_repository.dart';

class MockMyHealthRepository implements MyHealthRepository {
  const MockMyHealthRepository();

  @override
  Future<MyHealthState> fetchState() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const MyHealthState(
      profile: UserProfile(name: '김민수', email: 'minsu@oncare.com'),
      risk: RiskAlert(
        title: '고혈압·당뇨 위험 주의',
        body: '최근 혈압과 혈당 추세가 다소 높습니다. 식단·운동 관리에 신경 써주세요.',
        level: RiskLevel.medium,
      ),
      indicators: <IndicatorTrend>[
        IndicatorTrend(
          kind: IndicatorKind.weight,
          label: '체중',
          latestValue: '68.2',
          unit: 'kg',
          deltaText: '-1.2kg (지난주 대비)',
          improving: true,
          last7Days: <double>[0.95, 0.92, 0.90, 0.86, 0.83, 0.80, 0.76],
        ),
        IndicatorTrend(
          kind: IndicatorKind.bloodPressure,
          label: '혈압',
          latestValue: '124/82',
          unit: 'mmHg',
          deltaText: '+4 (지난주 대비)',
          improving: false,
          last7Days: <double>[0.60, 0.62, 0.65, 0.70, 0.74, 0.78, 0.80],
        ),
        IndicatorTrend(
          kind: IndicatorKind.bloodSugar,
          label: '혈당',
          latestValue: '95',
          unit: 'mg/dL',
          deltaText: '-3 (지난주 대비)',
          improving: true,
          last7Days: <double>[0.75, 0.74, 0.72, 0.71, 0.70, 0.69, 0.65],
        ),
      ],
      activityPoints: 1240,
      activityRank: 14,
      settings: <SettingsItem>[
        SettingsItem(label: '개인 정보', icon: '👤'),
        SettingsItem(label: '건강 데이터', icon: '📊'),
        SettingsItem(label: '알림 설정', icon: '🔔'),
        SettingsItem(label: '고객 지원', icon: '💬'),
      ],
    );
  }
}
