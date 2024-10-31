import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';
import '../ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: SizedBox(
            width: 150,
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                  restaurant.name,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 16.0),
                const SizedBox(width: 4.0),
                Text(restaurant.city),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star, size: 16.0),
                const SizedBox(width: 4.0),
                Text(restaurant.rating.toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            RestaurantDetailPage.routeName,
            arguments: restaurant.id
          );
        },
      ),
    );
  }
}