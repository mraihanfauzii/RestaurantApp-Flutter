import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/card_restaurant.dart';
import '../provider/database_provider.dart';
import '../utils/result_state.dart';

class BookmarksPage extends StatelessWidget {
  static const routeName = '/bookmarks';

  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.HasData) {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                var restaurant = provider.favorites[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          } else if (provider.state == ResultState.NoData) {
            return Center(child: Text(provider.message));
          } else if (provider.state == ResultState.Error) {
            return Center(child: Text(provider.message));
          } else {
            return const Center(child: Text(''));
          }
        }
      ),
    );
  }
}