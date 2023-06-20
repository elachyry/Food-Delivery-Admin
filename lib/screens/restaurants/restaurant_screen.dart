import 'package:flutter/material.dart';
import 'package:food_delivery_admin/models/models.dart';
import 'package:get/get.dart';

import '../../config/responsive.dart';
import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../models/order.dart';
import '../../style/colors.dart';
import '../../style/style.dart';
import '../../widgets/widgets.dart';

class RestaurantsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  static const String appRoute = '/restaurants';
  final RestaurantController restaurantController =
      Get.put(RestaurantController());

  RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: AppColors.black)),
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
              flex: 10,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PrimaryText(
                              text: 'Restaurants',
                              size: 30,
                              fontWeight: FontWeight.w800),
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Theme.of(context).primaryColorDark,
                                size: 50,
                              ),
                              onPressed: () {
                                restaurantController.restaurantInfos.value =
                                    null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      Obx(() {
                        if (restaurantController.restaurants.isEmpty) {
                          return SizedBox(
                            height: SizeConfig.screenHeight / 2,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: SizeConfig.screenHeight,
                            child: GridView.builder(
                              padding: const EdgeInsets.all(20),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 310,
                                maxCrossAxisExtent: 400,
                                childAspectRatio: Responsive.isMobile(context)
                                    ? 1
                                    : Responsive.isTablet(context)
                                        ? 1
                                        : 1.4,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 10,
                              ),
                              itemCount:
                                  restaurantController.restaurants.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 250,
                                  child: RestaurantItem(
                                      restaurant: restaurantController
                                          .restaurants[index]),
                                );
                              },
                            ),
                          );
                        }
                      }),
                      // if (!Responsive.isDesktop(context))
                      // AddProduct(
                      //   categoriesController: categoriesController,
                      //   descriptionController: descriptionController,
                      //   ingrediantsController: ingrediantsController,
                      //   nameController: nameController,
                      //   priceController: priceController,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            if (Responsive.isDesktop(context))
              Obx(
                () => Expanded(
                  flex: 4,
                  child: SafeArea(
                    child: Container(
                      width: double.infinity,
                      height: SizeConfig.screenHeight,
                      decoration: BoxDecoration(
                        color:
                            restaurantController.restaurantInfos.value == null
                                ? AppColors.secondaryBg
                                : Colors.white,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 10),
                        child:
                            restaurantController.restaurantInfos.value == null
                                ? AddRestaurant()
                                : Column(
                                    children: [
                                      RestaurantShowInfos(
                                          restaurant: restaurantController
                                              .restaurantInfos
                                              .value as Restaurant)
                                    ],
                                  ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
