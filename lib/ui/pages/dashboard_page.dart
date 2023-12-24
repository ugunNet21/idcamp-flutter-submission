import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/shared/themes.dart';
import 'package:flutter_subm_1/ui/widgets/home_carousel.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';

class HomeDashboardPage extends StatefulWidget {
  HomeDashboardPage({Key? key}) : super(key: key);

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  List<CustomerReview>? _updatedReviews;
  final RestaurantService _restaurantService = RestaurantService();
  late RestaurantDetail restaurantDetail;
  final RestaurantService restaurantService = RestaurantService();
  // Fungsi untuk mereset state dan memanggil kembali data
  // Future<void> _refreshData() async {
  //   setState(() {});
  // }
  Future<void> _refreshData() async {
    try {
      final Map<String, dynamic>? args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (args != null && args['restaurantDetail'] is RestaurantDetail) {
        final String restaurantId = args['restaurantDetail'].id;
        final RestaurantDetail updatedRestaurantDetail =
            await _restaurantService.fetchRestaurantDetail(restaurantId);

        print('Start refreshing data...');
        setState(() {
          restaurantDetail = updatedRestaurantDetail;
        });
        print('Data successfully refreshed.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data successfully refreshed.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('Error: Invalid or null restaurant detail.');
      }
    } catch (e) {
      print('Error refreshing data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error refreshing data: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Restaurant>>(
          future: restaurantService.fetchRestaurants(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Restaurant> restaurants = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  children: [
                    buildProfile(context),
                    buildSearchButton(context),
                    buildCarousel(),
                    buildRestaurantList(context, restaurants),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
            }
            // Menampilkan indikator loading jika data masih diambil
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget buildSearchButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke halaman pencarian
          Navigator.pushNamed(context, '/restaurant-search');
        },
        child: Text(
          'Search Restaurants',
          style: orangeTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}

Widget buildProfile(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(
      top: 40,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo,',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Gugun Gunawan',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/account-page');
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'assets/img_friend4.png',
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    color: greenColor,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCarousel() {
  return Container(
    margin: const EdgeInsets.only(
      top: 20,
    ),
    child: CarouselSlider(
      options: CarouselOptions(
        height: 120.0, // Tinggi carousel
        autoPlay: true, // Menyalakan autoplay
        autoPlayInterval: Duration(seconds: 3), // Interval pergeseran
      ),
      items: const [
        HomeCarousel(
          imageUrl: 'assets/ic_resto.png',
          title: 'Promo Akhir Tahun Resto Mang Ugun',
        ),
        HomeCarousel(
          imageUrl: 'assets/ic_resto.png',
          title: 'Promo Makan Enak B',
        ),
        // Tambahkan item-carousel lainnya
      ],
    ),
  );
}

Widget buildRestaurantList(BuildContext context, List<Restaurant> restaurants) {
  final RestaurantService _restaurantService = RestaurantService();

  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List of Restaurants',
          style: blackTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        // Gunakan ListView.builder untuk membuat daftar restoran
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            // Gunakan data dari API untuk mengisi informasi restoran
            Restaurant restaurant = restaurants[index];
            return GestureDetector(
              onTap: () async {
                try {
                  RestaurantDetail restaurantDetail = await _restaurantService
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
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ClipRRect untuk membuat gambar berbentuk rounded
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                        height: 80,
                        width: 120,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semibold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Tampilkan ikon lokasi
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: blackColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.city,
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Tampilkan Rating menggunakan RatingBar
                        RatingBar.builder(
                          initialRating: restaurant.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 16,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Rating yang diupdate
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
