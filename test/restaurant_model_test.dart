import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/data/model/restaurant.dart';

void main() {
  group('Restaurant Model Test', () {
    test('Parsing dari JSON ke objek Restaurant', () {
      // Contoh JSON data untuk satu restoran
      const restaurantJson = '''
      {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      }
      ''';

      final Map<String, dynamic> jsonMap = json.decode(restaurantJson);
      final restaurant = Restaurant.fromJson(jsonMap);

      expect(restaurant.id, 'rqdv5juczeskfw1e867');
      expect(restaurant.name, 'Melting Pot');
      expect(restaurant.description, 'Lorem ipsum dolor sit amet...');
      expect(restaurant.pictureId, '14');
      expect(restaurant.city, 'Medan');
      expect(restaurant.rating, 4.2);
    });

    test('Konversi objek Restaurant ke Map', () {
      final restaurant = Restaurant(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description: 'Lorem ipsum dolor sit amet...',
        pictureId: '14',
        city: 'Medan',
        rating: 4.2,
        address: 'Jalan Menuju Kenangan',
        categories: [],
        menus: null,
        customerReviews: [],
      );

      final restaurantMap = restaurant.toMap();

      expect(restaurantMap['id'], 'rqdv5juczeskfw1e867');
      expect(restaurantMap['name'], 'Melting Pot');
      expect(restaurantMap['description'], 'Lorem ipsum dolor sit amet...');
      expect(restaurantMap['pictureId'], '14');
      expect(restaurantMap['city'], 'Medan');
      expect(restaurantMap['rating'], 4.2);
      expect(restaurantMap['address'], 'Jalan Menuju Kenangan');
    });
  });
}
