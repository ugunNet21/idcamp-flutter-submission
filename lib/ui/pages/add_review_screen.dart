
import 'package:flutter/material.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';


class AddReviewScreen extends StatefulWidget {
  final String restaurantId;

  AddReviewScreen({required this.restaurantId});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final RestaurantService _restaurantService = RestaurantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Review'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _submitReview();
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    final name = _nameController.text;
    final review = _reviewController.text;

    if (name.isNotEmpty && review.isNotEmpty) {
      try {
        final updatedReviews = await _restaurantService.addReview(widget.restaurantId, name, review);
        // Update UI with the new reviews
        // You can implement UI update logic here
        Navigator.pop(context);
      } catch (e) {
        print('Error submitting review: $e');
        // Handle error
      }
    } else {
      // Show error message or handle empty fields
    }
  }
}
