class VitalsReading {
  const VitalsReading({
    required this.dayLabel,
    required this.weightKg,
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
  });

  final String dayLabel;
  final double weightKg;
  final int systolic;
  final int diastolic;
  final int heartRate;
}

class HealthHistory {
  const HealthHistory({required this.readings, required this.goalWeight});

  /// Oldest → newest.
  final List<VitalsReading> readings;
  final double goalWeight;

  VitalsReading get latest => readings.last;
  double get weightDelta => readings.last.weightKg - readings.first.weightKg;
}
