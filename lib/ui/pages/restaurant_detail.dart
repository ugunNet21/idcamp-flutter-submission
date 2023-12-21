import 'package:flutter/material.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';

class RestaurantDetailPage extends StatelessWidget {
  final RestaurantService restaurantService = RestaurantService();

  RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RestaurantDetail restaurantDetail = args['restaurantDetail'];

    return FutureBuilder<RestaurantDetail>(
      future: restaurantService.fetchRestaurantDetail(restaurantDetail.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
           if (snapshot.hasData) {
  RestaurantDetail restaurantDetail = snapshot.data!;

  return Scaffold(
    appBar: AppBar(
      title: Text(restaurantDetail.name),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            'Description:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            restaurantDetail.description,
            style: TextStyle(fontSize: 16),
          ),
          // ... (lanjutkan menambahkan widget sesuai dengan kebutuhan)
        ],
      ),
    ),
  );
} else if (snapshot.hasError) {
  return Center(
    child: Text('Error: ${snapshot.error}'),
  );
}

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
}
