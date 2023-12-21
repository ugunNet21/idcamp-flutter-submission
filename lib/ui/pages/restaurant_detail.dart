import 'package:flutter/material.dart';
// import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';

class RestaurantDetailPage extends StatelessWidget {
  final RestaurantService restaurantService = RestaurantService();

   RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan FutureBuilder untuk mendapatkan data asinkron
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchRestaurantDetail(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            RestaurantDetail restaurantDetail = snapshot.data!['restaurantDetail'];
            return Scaffold(
              appBar: AppBar(
                title: Text(restaurantDetail.name),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ... (bagian lain dari RestaurantDetailPage)
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _fetchRestaurantDetail(BuildContext context) async {
    try {
      final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String restaurantId = args['restaurantId'];

      // Menggunakan restaurantService untuk mengambil detail restoran
      RestaurantDetail restaurantDetail = await restaurantService.fetchRestaurantDetail(restaurantId);

      return {'restaurantDetail': restaurantDetail};
    } catch (e) {
      throw Exception('Error fetching restaurant detail: $e');
    }
  }
}
