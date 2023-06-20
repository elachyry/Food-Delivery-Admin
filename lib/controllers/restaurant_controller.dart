import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

class RestaurantController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final RestaurantRepository _restaurantRepo = Get.put(RestaurantRepository());

  Stream<List<Restaurant>> get restaurantStream =>
      _restaurantRepo.getRestaurants();

  RxList<Restaurant> restaurants = <Restaurant>[].obs;
  var isLoading = false.obs;

  var restaurantInfos = Rxn<Restaurant>();

  var isCleanName = true.obs;
  var isCleanDescription = true.obs;
  var isCleanPhone = true.obs;
  var isCleanEmail = true.obs;
  var isCleanDeliveryTime = true.obs;
  var isCleanDeliveryFees = true.obs;
  var isCleanAddress = true.obs;
  var isCleanlat = true.obs;
  var isCleanlng = true.obs;
  var isCleanPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadRedtaurants();
  }

  void loadRedtaurants() {
    restaurantStream.listen((restaurantList) {
      restaurants.value = restaurantList;
    });
  }

  void addRestaurant(Restaurant restaurant) async {
    isLoading.value = true;
    await _restaurantRepo.createRestaurant(restaurant);
    
    loadRedtaurants();
    isLoading.value = false;
  }

  
}
