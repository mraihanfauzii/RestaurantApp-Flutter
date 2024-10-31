import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Menambahkan restoran ke favorit dan memverifikasi di halaman Bookmarks', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Restaurant App'), findsOneWidget);

    final Finder restaurantItem = find.byType(ListTile).first;

    await tester.tap(restaurantItem);
    await tester.pumpAndSettle();

    expect(find.textContaining('Foods:'), findsOneWidget);

    final Finder favoriteButton = find.byIcon(Icons.favorite_border);
    await tester.tap(favoriteButton);
    await tester.pumpAndSettle();

    final Finder backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    final Finder favoritesTab = find.byIcon(Icons.favorite);
    await tester.tap(favoritesTab);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsWidgets);
  });
}
