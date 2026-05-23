import 'package:oncare/features/place/domain/entities/place.dart';
import 'package:oncare/features/place/domain/repositories/place_repository.dart';

class MockPlaceRepository implements PlaceRepository {
  const MockPlaceRepository();

  @override
  Future<List<Place>> nearbyPlaces() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Coordinates centred on 강남역 area for the demo.
    return const <Place>[
      Place(
        id: 'p1',
        name: '강남세브란스 가정의학과',
        category: PlaceCategory.medical,
        address: '서울특별시 강남구 테헤란로 123',
        distanceMeters: 420,
        lat: 37.4979,
        lng: 127.0276,
      ),
      Place(
        id: 'p2',
        name: '온케어 피트니스',
        category: PlaceCategory.fitness,
        address: '서울특별시 강남구 역삼로 55',
        distanceMeters: 680,
        lat: 37.5005,
        lng: 127.0319,
      ),
      Place(
        id: 'p3',
        name: '그린 샐러드 바',
        category: PlaceCategory.healthyFood,
        address: '서울특별시 강남구 강남대로 311',
        distanceMeters: 250,
        lat: 37.4970,
        lng: 127.0270,
      ),
      Place(
        id: 'p4',
        name: '24시간 메디팜약국',
        category: PlaceCategory.pharmacy,
        address: '서울특별시 강남구 테헤란로 99',
        distanceMeters: 800,
        lat: 37.4995,
        lng: 127.0263,
      ),
    ];
  }
}
