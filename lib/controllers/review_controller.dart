
import 'package:flutter/material.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';
import 'package:get/get.dart';

class AddReviewController extends GetxController {
  final RestaurantService _restaurantService = RestaurantService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  var updatedReviews = <CustomerReview>[].obs;

  // Getter untuk _nameController
  TextEditingController get nameController => _nameController;

  // Getter untuk _reviewController
  TextEditingController get reviewController => _reviewController;

  Future<void> addReview(String restaurantId) async {
    try {
      List<CustomerReview> reviews = await _restaurantService.addReview(
        restaurantId,
        _nameController.text,
        _reviewController.text,
      );
      updatedReviews.value = reviews;
    } catch (e) {
      print('Error adding review: $e');
    }
  }

  @override
  void onClose() {
    // Clean up controllers when the controller is closed
    _nameController.dispose();
    _reviewController.dispose();
    super.onClose();
  }
}