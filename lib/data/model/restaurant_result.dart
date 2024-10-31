import 'restaurant.dart';

class RestaurantResult {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResult.fromJson(Map<String, dynamic> json) {
    return RestaurantResult(
      error: json["error"] ?? true,
      message: json["message"] ?? '',
      count: json["count"] ?? 0,
      restaurants: List<Restaurant>.from(json["restaurants"]
          .map((x) => Restaurant.fromJson(x))
          .where((restaurant) =>
      restaurant.rating != null &&
          restaurant.description != null &&
          restaurant.pictureId != null &&
          restaurant.city != null
      )
      ),
    );
  }
}