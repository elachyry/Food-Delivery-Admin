import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../screens/screen.dart';
import '../../style/colors.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    super.key,
  });

  final menuItemsController = Get.put(MenuItemsController());
  final ratingController = Get.put(RatingController());
  final restaurantController = Get.put(RestaurantController());
  final ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/delevry-outline.gif',
                    width: 40,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 40,
                  ),
                ],
              ),
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20),
                child: const SizedBox(
                  width: 35,
                  height: 20,
                  // child: SvgPicture.asset('assets/mac-action.svg'),
                ),
              ),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: const Icon(
                    Icons.home,
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    Get.toNamed(Dashboard.appRoute);
                  }),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/clipboard.png',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    ordersController.fetchOrders();
                    Get.toNamed(OrdersScreen.appRoute);
                  }),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/restaurant-2.png',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    restaurantController.loadRedtaurants();
                    Get.toNamed(RestaurantsScreen.appRoute);
                  }),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    final loginController = Get.put(LoginController());
                    loginController.signOut();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
