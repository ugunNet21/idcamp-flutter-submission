import 'package:flutter/material.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';
import 'package:flutter_subm_1/shared/themes.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  List<CustomerReview>? _updatedReviews;
  final RestaurantService _restaurantService = RestaurantService();
  late RestaurantDetail restaurantDetail;

  Future<void> _refreshData() async {
    try {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String restaurantId = args['restaurantDetail'].id;
      final RestaurantDetail updatedRestaurantDetail =
          await _restaurantService.fetchRestaurantDetail(restaurantId);
      debugPrint('Start refreshing data...');
      setState(() {
        restaurantDetail = updatedRestaurantDetail;
        _updatedReviews = updatedRestaurantDetail.customerReviews;
      });
      debugPrint('Data successfully refreshed.');
    } catch (e) {
      debugPrint('Erro refreshing data. $e');
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      restaurantDetail = args['restaurantDetail'];
    } catch (e) {
      debugPrint('Error initializing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RestaurantDetail restaurantDetail = args['restaurantDetail'];

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantDetail.name),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                const Icon(Icons.location_city),
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
                const Icon(Icons.location_on),
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
                const Icon(Icons.star),
                const SizedBox(width: 8),
                Text('Rating: ${restaurantDetail.rating}',
                    style: blackTextStyle.copyWith(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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
            ElevatedButton(
              onPressed: () async {
                try {
                  final BuildContext currentContext = context;
                  final RestaurantDetail updatedRestaurantDetail =
                      await _restaurantService
                          .fetchRestaurantDetail(restaurantDetail.id);
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(
                    currentContext,
                    '/add-review',
                    arguments: {'restaurantId': updatedRestaurantDetail.id},
                  );
                } catch (e) {
                  debugPrint('Error fetching restaurant detail: $e');
                }
              },
              child: Text(
                'Add Review',
                style: orangeTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ratings :',
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star),
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
                  children: [
                    Text(
                      'Customer Reviews:',
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _updatedReviews?.length ?? 0,
                      itemBuilder: (context, index) {
                        CustomerReview review = _updatedReviews![index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              '${review.name} (${review.date})',
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: bold),
                            ),
                            subtitle: Text(
                              review.review,
                              style: blackTextStyle.copyWith(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
