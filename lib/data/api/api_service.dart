import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/customer_review.dart';
import '../model/restaurant.dart';
import '../model/restaurant_result.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}list'));
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } on SocketException {
        throw Exception('Failed to load, please check your internet connection.');
    }
  }

  Future<Restaurant> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> restaurantData = data['restaurant'];
        return Restaurant.fromJson(restaurantData);
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } on SocketException {
      throw Exception('Failed to load, please check your internet connection.');
    }
  }

  Future<RestaurantResult> searchRestaurants(String query) async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'));
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to search restaurants');
      }
    } on SocketException {
      throw Exception('Failed to load, please check your internet connection.');
    }
  }

  Future<List<CustomerReview>> addReview(String id, String name, String review) async {
    try {
      final response = await http.post(Uri.parse('${_baseUrl}review'),
          headers: {'Content-Type' : 'application/json'},
          body: json.encode({
            'id' : id,
            'name': name,
            'review' : review
          }),
      );
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> reviewsData = data['customerReviews'];
        return reviewsData.map((review) => CustomerReview.fromJson(review)).toList();
      } else {
        print('Failed to add review - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to add review - Status Code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Failed to load, please check your internet connection.');
    }
  }
}