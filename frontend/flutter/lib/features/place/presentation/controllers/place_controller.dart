import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/features/place/data/repositories/mock_place_repository.dart';
import 'package:oncare/features/place/domain/entities/place.dart';
import 'package:oncare/features/place/domain/repositories/place_repository.dart';

final placeRepositoryProvider = Provider<PlaceRepository>(
  (ref) => const MockPlaceRepository(),
  name: 'placeRepository',
);

final nearbyPlacesProvider = FutureProvider<List<Place>>((ref) {
  return ref.watch(placeRepositoryProvider).nearbyPlaces();
}, name: 'nearbyPlaces');
