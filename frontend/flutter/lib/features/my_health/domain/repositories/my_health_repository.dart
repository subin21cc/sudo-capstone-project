import 'package:oncare/features/my_health/domain/entities/health_history.dart';

abstract class MyHealthRepository {
  Future<MyHealthState> fetchState();
}
