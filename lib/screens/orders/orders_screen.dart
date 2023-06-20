import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/responsive.dart';
import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../models/order.dart';
import '../../style/colors.dart';
import '../../style/style.dart';
import '../../widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  static const String appRoute = '/orders';
  final OrdersController ordersController = Get.put(OrdersController());

  OrdersScreen({super.key});

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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  PrimaryText(
                                      text: 'Orders',
                                      size: 30,
                                      fontWeight: FontWeight.w800),
                                ]),
                          ),
                          const Spacer(
                            flex: 3,
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
                        if (ordersController.orders.isEmpty) {
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
                                mainAxisExtent: 340,
                                maxCrossAxisExtent: 400,
                                childAspectRatio: Responsive.isMobile(context)
                                    ? 1
                                    : Responsive.isTablet(context)
                                        ? 1
                                        : 1.3,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 10,
                                // crossAxisCount:
                                //     Responsive.isMobile(context)
                                //         ? 1
                                //         : Responsive.isTablet(context)
                                //             ? 2
                                //             : 2
                              ),
                              itemCount: ordersController.orders.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 250,
                                  child: OrderItem(
                                    order: ordersController.orders[index],
                                  ),
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
                        color: ordersController.orderInfos.value == null
                            ? AppColors.secondaryBg
                            : Colors.white,
                      ),
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                        child: ordersController.orderInfos.value == null
                            ? Container()
                            : Column(
                                children: [
                                  // AppBarActionItems(),
                                  OrderShowInfos(
                                      order: ordersController.orderInfos.value
                                          as Order)
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
