import 'package:oncare/features/place/domain/entities/place.dart';

abstract class PlaceRepository {
  Future<List<Place>> nearbyPlaces();
}
