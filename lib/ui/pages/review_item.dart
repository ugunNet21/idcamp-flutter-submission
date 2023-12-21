import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/review.dart';


class ReviewItem extends StatelessWidget {
  final Review review;

  ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(review.name),
      subtitle: Text('${review.review} - ${review.date}'),
    );
  }
}
