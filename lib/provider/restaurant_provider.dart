import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_result.dart';
import '../utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late RestaurantResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  RestaurantResult get result => _restaurantsResult;
  ResultState get state => _state;
  String get message => _message;

  Future<void> fetchAllRestaurants() async {
    _state = ResultState.Loading;
    notifyListeners();
    try {
      final restaurants = await apiService.getRestaurantList();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'No Data Available';
      } else {
        _state = ResultState.HasData;
        _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Failed to fetch restaurants';
      notifyListeners();
    }
    notifyListeners();
  }

  void searchRestaurants(String query) async {
    _state = ResultState.Loading;
    notifyListeners();
    try {
      final restaurants = await apiService.searchRestaurants(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'No Data Found';
      } else {
        _state = ResultState.HasData;
        _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Failed to search restaurants';
    }
    notifyListeners();
  }
}