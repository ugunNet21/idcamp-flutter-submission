import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';

class RestaurantSearchPage extends StatefulWidget {
  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final RestaurantService _restaurantService = RestaurantService();
  TextEditingController _searchController = TextEditingController();
  List<Restaurant> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search Restaurants'),
              onChanged: _onSearchTextChanged,
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchTextChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    try {
      final results = await _restaurantService.searchRestaurants(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Error searching restaurants: $e');
    }
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found.'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        Restaurant restaurant = _searchResults[index];
        return ListTile(
          title: Text(restaurant.name),
          subtitle: Text(restaurant.city),
          onTap: () {
            // Navigate to restaurant detail page
            Navigator.pushNamed(
              context,
              '/restaurant-detail',
              arguments: {'restaurant': restaurant},
            );
          },
        );
      },
    );
  }
}
