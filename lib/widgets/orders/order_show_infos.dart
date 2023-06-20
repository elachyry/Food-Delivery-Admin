import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../widgets.dart';

class OrderShowInfos extends StatelessWidget {
  OrderShowInfos({
    super.key,
    required this.order,
  });

  final Order order;
  final OrdersController ordersController = Get.put(OrdersController());

  Container costumContainer({required Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final String status = getStatusValue(order.status);
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
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom:
                    Radius.elliptical(MediaQuery.of(context).size.width, 100),
              ),
              color: color),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              status,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order Id',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              order.id,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        const Divider(),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order Date :',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              DateFormat('dd MMM yyyy hh:mm a').format(
                DateTime.parse(order.addedAt),
              ),
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),

        costumContainer(
          child: Column(
            children: [
              Text(
                'Order Items ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              SizedBox(
                height:
                    SizeConfig.screenHeight * 0.2 * order.menuItems.keys.length,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: order.menuItems.keys.length,
                  itemBuilder: (context, index) => OrderMenuItem(
                    menuItem: order.menuItems.keys.elementAt(index),
                    quantity: order.menuItems.values.elementAt(index),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        costumContainer(
          child: Column(children: [
            Text(
              'Delivery To ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Full Name',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      ordersController.users[order.consumerId]['fullName'],
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone Number',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      ordersController.users[order.consumerId]['phoneNumber'],
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Address',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      order.address,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Method',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      order.paymentMathode,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          order.total.toStringAsFixed(2),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        Text(
                          'Dh',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
          ]),
        ),
        // columnBuilder('Customer FullName:',
        //     ordersController.users[order.consumerId]['fullName']),
        // columnBuilder('Customer Address :', order.address.toUpperCase()),
        // columnBuilder('Order Id', order.id),
        // columnBuilder('Order Id', order.id),
      ],
    );
  }
}
