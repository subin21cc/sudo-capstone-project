enum PlaceCategory { medical, fitness, healthyFood, pharmacy }

class Place {
  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.distanceMeters,
    required this.lat,
    required this.lng,
  });

  final String id;
  final String name;
  final PlaceCategory category;
  final String address;
  final int distanceMeters;
  final double lat;
  final double lng;
}
