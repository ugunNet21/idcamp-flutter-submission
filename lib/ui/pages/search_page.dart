import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final RestaurantService _restaurantService = RestaurantService();
  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Search Restaurants'),
              onChanged: _onSearchTextChanged,
            ),
          const  SizedBox(height: 16),
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
      debugPrint('Error searching restaurants: $e');
    }
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
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
          onTap: () async {
            try {
              RestaurantDetail restaurantDetail =
                  await _restaurantService.fetchRestaurantDetail(restaurant.id);
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(
                context,
                '/restaurant-detail',
                arguments: {'restaurantDetail': restaurantDetail},
              );
            } catch (e) {
              debugPrint('Error fetching restaurant detail: $e');
            }
          },
        );
      },
    );
  }
}
