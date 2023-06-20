import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class RestaurantRepository extends GetxController {
  final CollectionReference _restaurantCollection =
      FirebaseFirestore.instance.collection('restaurants');

  Stream<List<Restaurant>> getRestaurants() {
    return _restaurantCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Restaurant.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> createRestaurant(Restaurant restaurant) async {
    try {
      await _restaurantCollection.doc(restaurant.id).set(restaurant.toMap());
      showSnackBar('Succes', 'The restaurant Added successfully ',
          Colors.green.shade400);
    } catch (error) {
      showSnackBar('Error', 'An error occurred, please try again later.',
          Colors.red.shade400);
    }
  }

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 2000));
  }
}
