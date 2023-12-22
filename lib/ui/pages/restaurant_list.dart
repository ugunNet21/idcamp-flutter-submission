import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});
  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final RestaurantService _restaurantService = RestaurantService();
  late List<Restaurant> _restaurants;

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    try {
      final restaurants = await _restaurantService.fetchRestaurants();
      setState(() {
        _restaurants = restaurants;
      });
    } catch (e) {
      print('Error loading restaurants: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),
      ),
      body: _restaurants != null
          ? ListView.builder(
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = _restaurants[index];
                return ListTile(
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.city),
                  onTap: () async {
                    try {
                      RestaurantDetail restaurantDetail =
                          await _restaurantService
                              .fetchRestaurantDetail(restaurant.id);
                      Navigator.pushNamed(
                        context,
                        '/restaurant-detail',
                        arguments: {'restaurantDetail': restaurantDetail},
                      );
                    } catch (e) {
                      print('Error fetching restaurant detail: $e');
                    }
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
