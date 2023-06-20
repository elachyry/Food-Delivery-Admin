import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';

class MenuItemsRepository extends GetxService {
  late FirebaseFirestore _firestore;

  final userController = Get.put(LoginController());
  final categoryController = Get.put(CategoryController());

  List<MenuItem> menuItems = [];

  Future<void> init() async {
    _firestore = FirebaseFirestore.instance;
  }

  List<String> restaurantId = [];

  Future<List<MenuItem>> getMenuItems() async {
    List<MenuItem> menuItems = [];

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();
      restaurantId = querySnapshot.docs.map((doc) {
        return doc.id;
      }).toList();

      for (var element in restaurantId) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('menuItems')
            .doc(element)
            .collection('items')
            .get();

        menuItems.addAll(
          querySnapshot.docs.map((doc) => MenuItem.fromFirestore(doc)),
        );
      }
      // print('test $orders');
      return menuItems;
    } catch (error) {
      // Handle the error
      rethrow;
    }
  }

  // Stream<List<MenuItem>> getMenuItems() {

  //   return FirebaseFirestore.instance
  //       .collection('menuItems')
  //       .doc(userController.firebaseUser.value!.uid)
  //       .collection('items')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return MenuItem.fromFirestore(doc);
  //     }).toList();
  //   });
  // }
}
