import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class RestaurantService {
 Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['restaurants'];
      return data.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    final Uri uri = Uri.parse('https://restaurant-api.dicoding.dev/detail/$id');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> restaurant = data['restaurant'];
      return RestaurantDetail.fromJson(restaurant);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final Uri uri =
        Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> restaurants = data['restaurants'];
      return restaurants.map((item) => Restaurant.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<List<CustomerReview>> addReview(
      String id, String name, String review) async {
    final Uri uri = Uri.parse('https://restaurant-api.dicoding.dev/review');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id, 'name': name, 'review': review}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> customerReviews = data['customerReviews'];
      return customerReviews
          .map((item) => CustomerReview.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to add review');
    }
  }
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final MenuList menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: (json['categories'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
      menus: MenuList.fromJson(json['menus']),
      rating: json['rating'].toDouble(),
      customerReviews: (json['customerReviews'] as List)
          .map((item) => CustomerReview.fromJson(item))
          .toList(),
    );
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
}

class MenuList {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  MenuList({required this.foods, required this.drinks});

  factory MenuList.fromJson(Map<String, dynamic> json) {
    return MenuList(
      foods: (json['foods'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
      drinks: (json['drinks'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
    );
  }
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
    );
  }
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview(
      {required this.name, required this.review, required this.date});

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }
}
