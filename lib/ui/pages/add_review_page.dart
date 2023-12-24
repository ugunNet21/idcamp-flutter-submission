import 'package:flutter/material.dart';
import 'package:flutter_subm_1/controllers/review_controller.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';
import 'package:flutter_subm_1/shared/themes.dart';
import 'package:get/get.dart';

class AddReviewPage extends StatelessWidget {
  final String restaurantId;
  final RestaurantService _restaurantService = RestaurantService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  var updatedReviews = <CustomerReview>[].obs;
  final AddReviewController controller = Get.put(AddReviewController());

  AddReviewPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  hintStyle: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Your Review',
                  hintStyle: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await controller.addReview(restaurantId);

                  // Setelah review ditambahkan, kosongkan input fields
                  controller.nameController.clear();
                  controller.reviewController.clear();
                },
                child: Text(
                  'Submit Review',
                  style:
                      orangeTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
              ),

              // Menampilkan hasil review di bawah tombol
              Obx(() {
                if (controller.updatedReviews.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Customer Reviews:',
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.updatedReviews.length,
                        itemBuilder: (context, index) {
                          CustomerReview review =
                              controller.updatedReviews[index];
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                review.name,
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
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
