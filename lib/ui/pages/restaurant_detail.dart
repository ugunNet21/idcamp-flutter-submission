import 'package:flutter/material.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';
import 'package:flutter_subm_1/shared/themes.dart';
// import 'package:flutter_subm_1/ui/pages/add_review_page.dart';

class RestaurantDetailPage extends StatefulWidget {
  RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final RestaurantService _restaurantService = RestaurantService();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RestaurantDetail restaurantDetail = args['restaurantDetail'];
    // final Restaurant restaurant = args['restaurant'];

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantDetail.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the rounded image with ClipRRect
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Description :',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(height: 8),
            Text(
              restaurantDetail.description,
              style: blackTextStyle.copyWith(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_city),
                const SizedBox(width: 8),
                Text(
                  'City: ${restaurantDetail.city}',
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on),
                const SizedBox(width: 8),
                Text(
                  'Address: ${restaurantDetail.address}',
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star),
                const SizedBox(width: 8),
                Text('Rating: ${restaurantDetail.rating}',
                    style: blackTextStyle.copyWith(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Display the list of categories
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: restaurantDetail.categories.map((category) {
                return Text(
                  '- ${category.name}',
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Menu:',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Foods:',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            // Display the list of food items horizontally 
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: restaurantDetail.menus.foods.map((food) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/ic_foods.png', 
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '- ${food.name}',
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Drinks:',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            // Display the list of drink items horizontally 
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: restaurantDetail.menus.drinks.map((drink) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/ic_drinks.png', 
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '- ${drink.name}',
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Add a section for user ratings and reviews
            ElevatedButton(
              onPressed: () async {
                try {
                  final BuildContext currentContext = context;
                  final RestaurantDetail updatedRestaurantDetail =
                      await _restaurantService
                          .fetchRestaurantDetail(restaurantDetail.id);
                  Navigator.pushNamed(
                    currentContext,
                    '/add-review',
                    arguments: {'restaurantId': updatedRestaurantDetail.id},
                  );
                } catch (e) {
                  print('Error fetching restaurant detail: $e');
                }
              },
              child: Text('Add Review'),
            ),
            const SizedBox(height: 16),
            Text(
              'Ratings :',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(height: 8),
            // Display the restaurant's average rating
            Row(
              children: [
                Icon(Icons.star),
                const SizedBox(width: 8),
                Text(
                  'Average Rating: ${restaurantDetail.rating}',
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Display individual customer reviews
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: restaurantDetail.customerReviews.map((review) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${review.name} (${review.date})',
                      style: blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                    ),
                    Text(
                      '${review.review}',
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // TODO: Add a form or UI for users to give ratings and reviews
          ],
        ),
      ),
    );
  }
}
            // TODO: Add a form or UI for users to give ratings and reviews
   