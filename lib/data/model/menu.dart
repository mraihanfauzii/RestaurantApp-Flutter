import 'drink.dart';
import 'food.dart';

class Menu {
  final List<Food>? foods;
  final List<Drink>? drinks;

  Menu({this.foods, this.drinks});

  factory Menu.fromJson(Map<String, dynamic>? json) {
    return Menu(
      foods: (json?['foods'] as List<dynamic>?)?.map((x) => Food.fromJson(x)).toList(),
      drinks: (json?['drinks'] as List<dynamic>?)?.map((x) => Drink.fromJson(x)).toList(),
    );
  }
}