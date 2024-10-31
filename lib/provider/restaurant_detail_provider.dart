import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    fetchRestaurantDetail();
  }

  late Restaurant _restaurant;
  ResultState _state = ResultState.Loading;
  String _message = '';

  Restaurant get restaurant => _restaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<void> fetchRestaurantDetail({bool showLoading = true}) async {
    if (showLoading) {
      _state = ResultState.Loading;
      notifyListeners();
    }
    try {
      final restaurant = await apiService.getRestaurantDetail(id);
      _restaurant = restaurant;
      _state = ResultState.HasData;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Failed to fetch restaurant detail';
    }
    notifyListeners();
  }

  Future<void> addReview(String name, String review) async {
    try {
      await apiService.addReview(id, name, review);
      await fetchRestaurantDetail(showLoading: false);
      _state = ResultState.HasData;
    } catch (e) {
      print('Error during addReview: $e');
      _message = 'Failed to add review';
      _state = ResultState.Error;
    }
    notifyListeners();
  }
}