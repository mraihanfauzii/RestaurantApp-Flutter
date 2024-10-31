import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/widgets/card_restaurant.dart';

void main() {
  testWidgets('Menampilkan data Restaurant pada CardRestaurant', (WidgetTester tester) async {
    final restaurant = Restaurant(
      id: '1',
      name: 'Test Restaurant',
      description: 'Test Description',
      pictureId: 'test_picture',
      city: 'Test City',
      rating: 4.5,
      address: 'Test Address',
      categories: [],
      menus: null,
      customerReviews: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CardRestaurant(restaurant: restaurant),
        ),
      ),
    );

    expect(find.text('Test Restaurant'), findsOneWidget);
    expect(find.text('Test City'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
  });
}
