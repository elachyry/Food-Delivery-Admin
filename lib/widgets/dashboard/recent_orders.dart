import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../../style/style.dart';
import '../widgets.dart';

class RecenOrders extends StatelessWidget {
  RecenOrders({
    super.key,
  });
  final restaurantController = Get.put(RestaurantController());
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PrimaryText(
                text: 'Recent Orders', size: 18, fontWeight: FontWeight.w800),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Obx(() {
          if (ordersController.orders.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: List.generate(
              ordersController.orders.length < 10
                  ? ordersController.orders.length
                  : 10,
              (index) {
                final String status =
                    getStatusValue(ordersController.orders[index].status);
                final Color color;

                switch (status) {
                  case 'Pending':
                    color = Colors.blue.shade400;
                    break;
                  case 'Accepted':
                    color = Colors.green.shade400;
                    break;
                  case 'Cancelled':
                    color = Colors.orange.shade400;
                    break;
                  case 'Delivered':
                    color = Colors.grey.shade400;
                    break;
                  case 'Denied':
                    color = Colors.red.shade400;
                    break;
                  default:
                    color = Colors.blue.shade400;
                    break;
                }
                return RecentOrdersListTile(
                  status: status,
                  label: ordersController
                          .users[ordersController.orders[index].consumerId]
                      ['fullName'] as String,
                  amount:
                      '${ordersController.orders[index].total.toStringAsFixed(2)} Dh',
                  address: ordersController.orders[index].address,
                  color: color,
                  order: ordersController.orders[index],
                );
              },
            ),
          );
        }),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 5,
        ),
      ],
    );
  }
}
