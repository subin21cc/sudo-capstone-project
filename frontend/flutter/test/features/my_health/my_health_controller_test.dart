import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/features/my_health/presentation/controllers/my_health_controller.dart';

void main() {
  test('healthHistoryProvider returns 7 readings, downward weight', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final h = await container.read(healthHistoryProvider.future);
    expect(h.readings.length, 7);
    expect(h.latest.weightKg, 68.2);
    expect(h.weightDelta, lessThan(0));
    expect(h.goalWeight, 65.0);
  });
}
