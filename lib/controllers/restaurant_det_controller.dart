// import 'package:flutter_subm_1/services/restaurant_service.dart';
// import 'package:get/get.dart';

// class RestaurantDetailController extends GetxController {
//   final RestaurantService _restaurantService = RestaurantService();
//   var restaurantDetail = RestaurantDetail(
//     id: '',
//     name: '',
//     description: '',
//     city: '',
//     address: '',
//     pictureId: '',
//     categories: [],
//     menus: MenuList(foods: [], drinks: []),
//     rating: 0.0,
//     customerReviews: [],
//   ).obs;

//   Future<void> fetchRestaurantDetail(String restaurantId) async {
//     try {
//       final RestaurantDetail updatedRestaurantDetail =
//           await _restaurantService.fetchRestaurantDetail(restaurantId);
//       restaurantDetail.value = updatedRestaurantDetail;
//     } catch (e) {
//       print('Error fetching restaurant detail: $e');
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
//     if (args != null && args['restaurantDetail'] != null) {
//       restaurantDetail.value = args['restaurantDetail'];
//     }
//   }
// }
