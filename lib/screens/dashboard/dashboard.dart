import 'package:flutter/material.dart';
import 'package:food_delivery_admin/style/colors.dart';
import 'package:get/get.dart';

import '../../config/responsive.dart';
import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class Dashboard extends StatelessWidget {
  static const String appRoute = '/';
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final OrdersController ordersController = Get.put(OrdersController());
  final menuItemsController = Get.put(MenuItemsController());
  final restaurantController = Get.put(RestaurantController());
  final costumerController = Get.put(CostumerController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double totaleTransactions = 0;
    for (var order in ordersController.orders) {
      if (getStatusValue(order.status) == 'Delivered') {
        totaleTransactions += order.total;
      }
      // print('totaleTransactions $totaleTransactions');
    }
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.black)),
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
                      // Header(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                      Obx(() {
                        if (ordersController.orders.isEmpty ||
                            menuItemsController.menuItems.isEmpty ||
                            restaurantController.restaurants.isEmpty ||
                            costumerController.costumers.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              InfoCard(
                                  icon: 'assets/clipboard.png',
                                  label: 'Orders',
                                  amount: ordersController.orders.length
                                      .toString()),
                              InfoCard(
                                  icon: 'assets/economy.png',
                                  label: 'Total transactions',
                                  amount:
                                      '${totaleTransactions.toStringAsFixed(2)} Dh'),
                              InfoCard(
                                  icon: 'assets/food.png',
                                  label: 'Product',
                                  amount: menuItemsController.menuItems.length
                                      .toString()),
                              InfoCard(
                                  icon: 'assets/restaurant-2.png',
                                  label: 'Restaurant',
                                  amount: restaurantController
                                      .restaurants.length
                                      .toString()),
                              InfoCard(
                                  icon: 'assets/multiple-users-silhouette.png',
                                  label: 'Users',
                                  amount: costumerController.costumers.length
                                      .toString()),
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),

                      if (Responsive.isDesktop(context))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(() {
                              if (menuItemsController.menuItems.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.white,
                                  ),
                                  height: 250,
                                  child: CategoryPieChart(),
                                ),
                              );
                            }),
                            SizedBox(
                              width: SizeConfig.blockSizeVertical * 5,
                            ),
                            Obx(() {
                              if (ordersController.orders.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Expanded(
                                flex: 7,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.white,
                                  ),
                                  height: 250,
                                  child: OrderDounatChart(),
                                ),
                              );
                            }),
                          ],
                        ),
                      if (!Responsive.isDesktop(context))
                        SizedBox(
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Obx(() {
                                if (menuItemsController.menuItems.isEmpty) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Expanded(
                                  flex: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.white,
                                    ),
                                    height: 250,
                                    child: CategoryPieChart(),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              ),
                              Obx(() {
                                if (ordersController.orders.isEmpty) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Expanded(
                                  flex: 7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.white,
                                    ),
                                    height: 250,
                                    child: OrderDounatChart(),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      Obx(
                        () {
                          if (ordersController.orders.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white,
                            ),
                            height: 250,
                            child: OrdersBarChart(),
                          );
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      Obx(
                        () {
                          if (ordersController.orders.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white,
                            ),
                            height: 250,
                            child: OrdersLineChart(),
                          );
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      if (!Responsive.isDesktop(context)) RecenOrders()
                    ],
                  ),
                ),
              ),
            ),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                      child: Column(
                        children: [
                          // AppBarActionItems(),
                          RecenOrders(),
                        ],
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
