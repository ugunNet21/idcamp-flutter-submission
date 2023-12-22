
import 'package:flutter/material.dart';
import 'package:flutter_subm_1/services/restaurant_service.dart';


class AddReviewPage extends StatefulWidget {
  final String restaurantId;

  AddReviewPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final RestaurantService _restaurantService = RestaurantService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reviewController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Your Review'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<CustomerReview> updatedReviews = await _restaurantService.addReview(
                    widget.restaurantId,
                    _nameController.text,
                    _reviewController.text,
                  );
                  // You can handle the updated reviews as needed
                  Navigator.pop(context); // Close the AddReviewPage
                } catch (e) {
                  print('Error adding review: $e');
                }
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}