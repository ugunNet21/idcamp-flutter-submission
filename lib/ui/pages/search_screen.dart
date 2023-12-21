
import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RestaurantService _restaurantService = RestaurantService();
  late List<Restaurant> _searchResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurants'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                _searchRestaurants(query);
              },
            ),
          ),
          Expanded(
            child: _searchResults != null
                ? ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_searchResults[index].name),
                        subtitle: Text(_searchResults[index].city),
                        onTap: () {
                          // Navigate to restaurant detail screen
                          // You can implement navigation logic here
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('No results'),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchRestaurants(String query) async {
    try {
      final searchResults = await _restaurantService.searchRestaurants(query);
      setState(() {
        _searchResults = searchResults;
      });
    } catch (e) {
      print('Error searching restaurants: $e');
      // Handle error
    }
  }
}
