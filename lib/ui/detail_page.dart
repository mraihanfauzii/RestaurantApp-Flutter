import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faker/faker.dart' as faker;
import '../provider/restaurant_detail_provider.dart';
import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';
import '../widgets/review_form.dart';
import '../utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = 'restaurant_detail';
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final fakeImage = faker.Faker().image;

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        id: restaurantId,
      ),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, restaurantDetailState, _) {
            if (restaurantDetailState.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (restaurantDetailState.state == ResultState.HasData) {
              return Stack(
                children: [
              SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: restaurantDetailState.restaurant.pictureId,
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurantDetailState.restaurant.pictureId}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.0,
                        right: 8.0,
                        child: Consumer<DatabaseProvider>(
                          builder: (context, provider, child) {
                            var isFavorited = provider.isFavorited(restaurantId);
                            return CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: IconButton(
                                icon: Icon(
                                  isFavorited ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  if (isFavorited) {
                                    provider.removeFavorite(restaurantId);
                                  } else {
                                    provider.addFavorite(restaurantDetailState.restaurant);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantDetailState.restaurant.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 35,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetailState.restaurant.categories.length,
                            itemBuilder: (_, index) {
                              final category = restaurantDetailState.restaurant.categories[index];
                              return Container(
                                width: 80,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    category.name,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16.0),
                            const SizedBox(width: 4.0),
                            Text('${restaurantDetailState.restaurant.address}, ${restaurantDetailState.restaurant.city}'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16.0),
                            const SizedBox(width: 4.0),
                            Text(restaurantDetailState.restaurant.rating.toString()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(restaurantDetailState.restaurant.description, textAlign: TextAlign.justify),
                        const SizedBox(height: 10),
                        const Text(
                          'Foods:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetailState.restaurant.menus?.foods?.length ?? 0,
                            itemBuilder: (context, index) {
                              final food = restaurantDetailState.restaurant.menus?.foods?[index];
                              final imageUrl = fakeImage.image(
                                width: 640,
                                height: 480,
                                keywords: [food?.name ?? 'food'],
                              );
                              return Container(
                                width: 180,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        food?.name ?? "",
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'IDR 35.000',
                                        style: TextStyle(fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Drinks:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetailState.restaurant.menus?.drinks?.length ?? 0,
                            itemBuilder: (context, index) {
                              final drink = restaurantDetailState.restaurant.menus?.drinks?[index];
                              final imageUrl = fakeImage.image( // Use food images for drinks
                                width: 640,
                                height: 480,
                                keywords: [drink?.name ?? 'drink'],
                              );
                              return Container(
                                width: 180,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        drink?.name ?? "",
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'IDR 20.000',
                                        style: TextStyle(fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Reviews:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (restaurantDetailState.restaurant.customerReviews.isEmpty)
                          const Text('No reviews available')
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurantDetailState.restaurant.customerReviews.length,
                            itemBuilder: (context, index) {
                              final review = restaurantDetailState.restaurant.customerReviews[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(review.review),
                                  Text(review.date),
                                  const SizedBox(height: 8),
                                ],
                              );
                            },
                          ),
                        const SizedBox(height: 16),
                        ReviewForm(restaurantId: restaurantDetailState.restaurant.id),
                      ],
                    ),
                  ),
                ],
              ),
            ),
                ],
              );
            } else if (restaurantDetailState.state == ResultState.Error) {
              return Center(child: Text(restaurantDetailState.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}