import 'package:flutter/widgets.dart';
import '../data/db/database_helper.dart';
import '../data/model/restaurant.dart';
import '../utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _state = ResultState.Loading;
    _getFavorites();
  }

  ResultState _state = ResultState.Loading;
  String _message = '';
  List<Restaurant> _favorites = [];

  String get message => _message;
  List<Restaurant> get favorites => _favorites;
  ResultState get state => _state;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'No Favorite Restaurants';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  bool isFavorited(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}