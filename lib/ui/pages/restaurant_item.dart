import 'package:flutter/material.dart';
import 'package:flutter_subm_1/models/restaurant.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  RestaurantItem({required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      onTap: onTap,
    );
  }
}
