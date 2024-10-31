import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  String address;
  List<Category> categories;
  Menu? menus;
  List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      address: json['address'] ?? "",
      categories: (json['categories'] as List<dynamic>?)
          ?.map((category) => Category.fromJson(category))
          .toList() ?? [],
      menus: Menu.fromJson(json['menus']),
      customerReviews: (json['customerReviews'] as List<dynamic>?)
          ?.map((review) => CustomerReview.fromJson(review))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'address': address,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      pictureId: map['pictureId'],
      city: map['city'],
      rating: map['rating'],
      address: map['address'],
      categories: [],
      menus: null,
      customerReviews: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'address': address,
    };
  }
}