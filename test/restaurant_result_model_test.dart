import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/data/model/restaurant_result.dart';

void main() {
  group('RestaurantResult Model Test', () {
    test('Parsing dari JSON ke objek RestaurantResult', () {

      const restaurantResultJson = '''
      {
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      }
      ''';

      final Map<String, dynamic> jsonMap = json.decode(restaurantResultJson);
      final restaurantResult = RestaurantResult.fromJson(jsonMap);

      expect(restaurantResult.error, false);
      expect(restaurantResult.message, 'success');
      expect(restaurantResult.count, 1);
      expect(restaurantResult.restaurants.length, 1);

      final restaurant = restaurantResult.restaurants[0];
      expect(restaurant.id, 'rqdv5juczeskfw1e867');
      expect(restaurant.name, 'Melting Pot');
      expect(restaurant.description, 'Lorem ipsum dolor sit amet...');
      expect(restaurant.pictureId, '14');
      expect(restaurant.city, 'Medan');
      expect(restaurant.rating, 4.2);
    });
  });
}
