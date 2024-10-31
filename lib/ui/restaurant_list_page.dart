import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_provider.dart';
import '../widgets/card_restaurant.dart';
import '../utils/result_state.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context, listen: false);
    final TextEditingController _searchController = TextEditingController();

    _searchController.addListener(() {
      provider.searchRestaurants(_searchController.text);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: const Text('Tempat Anda Mencari Restaurant'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Cari Restaurant ...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  return ListView.builder(
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.result.restaurants[index];
                      return  CardRestaurant(restaurant: restaurant);
                    },
                  );
                } else if (state.state == ResultState.NoData) {
                  return Center(child: Text(state.message));
                } else if (state.state == ResultState.Error) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text(''));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}