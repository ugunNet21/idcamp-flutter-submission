import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/restaurant.dart';
import 'package:flutter_subm_1/shared/themes.dart';
import 'package:flutter_subm_1/ui/widgets/home_carousel.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_subm_1/services/restaurant_service.dart';

class HomeDashboardPage extends StatelessWidget {
  HomeDashboardPage({Key? key}) : super(key: key);
  final RestaurantService restaurantService = RestaurantService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Restaurant>>(
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
                  buildCarousel(),
                  buildServices(context),
                  buildTips(),
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
    );
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
                'Idan Abdul Rohman',
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
                    'assets/pa_idan.png',
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
            title: 'Resto A',
          ),
          HomeCarousel(
            imageUrl: 'assets/ic_resto.png',
            title: 'Resto B',
          ),
          // Tambahkan item-carousel lainnya sesuai kebutuhan Anda
        ],
      ),
    );
  }

  Widget buildServices(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Restaurant',
            style: blackTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }

  Widget buildTips() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/ic_resto.png',
                height: 60,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resto Bandung :',
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                  ),
                  SizedBox(
                    width: 240,
                    child: Text(
                      'Resto Bandung terkenal nikmat',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

Widget buildRestaurantList(BuildContext context, List<Restaurant> restaurants) {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Restoran',
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
              onTap: () {
                // Navigasi ke halaman detail restoran
               Navigator.pushNamed(context, '/restaurant-detail', arguments: restaurant.id);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      height: 80,
                      width: 60,
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semibold,
                          ),
                        ),
                        SizedBox(
                          width: 240,
                          child: Text(
                            restaurant.description,
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
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
