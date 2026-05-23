import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/core/network/dio_client.dart';
import 'package:oncare/features/diet/data/repositories/dio_diet_repository.dart';
import 'package:oncare/features/diet/domain/entities/diet_day.dart';
import 'package:oncare/features/diet/domain/repositories/diet_repository.dart';

final dietRepositoryProvider = Provider<DietRepository>(
  (ref) => DioDietRepository(ref.watch(dioProvider)),
  name: 'dietRepository',
);

final dietTodayProvider = FutureProvider<DietDay>((ref) {
  return ref.watch(dietRepositoryProvider).fetchToday();
}, name: 'dietToday');
