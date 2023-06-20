import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../config/size_config.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../widgets.dart';

class RestaurantShowInfos extends StatelessWidget {
  RestaurantShowInfos({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;
  final RestaurantController restaurantController =
      Get.put(RestaurantController());
  final MenuItemsController menuItemsController =
      Get.put(MenuItemsController());
  final ratingController = Get.put(RatingController());

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
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      restaurant.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  )),
              // child: ClipRRect(
              //   borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(15),
              //       topRight: Radius.circular(15)),
              //   child: FadeInImage(
              //       image: NetworkImage(
              //         restaurant.imageUrl,
              //       ),
              //       imageErrorBuilder: (context, error, stackTrace) =>
              //           Image.asset('assets/restaurant.png'),
              //       placeholder: const AssetImage('assets/restaurant.png'),
              //       width: double.infinity,
              //       height: 180,
              //       fit: BoxFit.cover),
              // ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage(
                        placeholder: const AssetImage('logo-place.png'),
                        image: NetworkImage(restaurant.logoUrl),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/logo-place.png'),
                        width: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ))
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        Obx(() {
          if (ratingController.ratings.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var rating = 0.0;
          ratingController.fetchRatings();
          List<Rating> ratings = [];
          if (ratingController.ratings.isNotEmpty) {
            for (var element in ratingController.ratings) {
              if (element.restaurantId == restaurant.id) {
                ratings.add(element);
                rating += element.rate;
              }
            }
          }

          rating = rating / ratings.length;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RatingBar.builder(
                  initialRating: rating.isNaN
                      ? 0.0
                      : double.parse(rating.toStringAsFixed(1)),
                  direction: Axis.horizontal,
                  itemSize: 30,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (rating) {},
                ),
              ),
              Row(
                children: [
                  Text(
                    rating.isNaN || ratings.isEmpty
                        ? 'No ratings'
                        : '$rating  ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '(${ratings.length})',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  )
                ],
              )
            ],
          );
        }),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Restaurant Id',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeVertical * 2,
            ),
            Expanded(
              flex: 10,
              child: Text(
                restaurant.id,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
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
              'Joined Date :',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeVertical * 2,
            ),
            Expanded(
              flex: 10,
              child: Text(
                DateFormat('dd MMM yyyy hh:mm a').format(
                  DateTime.parse(restaurant.addedAt),
                ),
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        const Divider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Name  ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: Text(
                restaurant.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),

        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Phone Number  ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: Text(
                restaurant.phone,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Address  ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: Text(
                restaurant.location.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Time  ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: Text(
                '${restaurant.deliveryTime.toString()} min',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const Divider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Fees  ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: Text(
                '${restaurant.deliveryFee.toStringAsFixed(2)} Dh',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const Divider(),
        Column(
          children: [
            Text(
              'Description  ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text(
              restaurant.description,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20),
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
        const Divider(),
        costumContainer(
          child: Column(
            children: [
              Text(
                'Menu Items ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Obx(() {
                if (menuItemsController.menuItems.isEmpty) {
                  return SizedBox(
                    height: SizeConfig.screenHeight / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SizedBox(
                  height: SizeConfig.screenHeight,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: restaurant.menuItemsId.length,
                    itemBuilder: (context, index) => RestaurantMenuItem(
                      menuItem: menuItemsController.menuItems.firstWhere(
                          (element) =>
                              element.id == restaurant.menuItemsId[index]),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        // costumContainer(
        //   child: Column(children: [
        //     Text(
        //       'Delivery To ',
        //       style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //           color: Theme.of(context).primaryColorDark),
        //     ),
        //     SizedBox(
        //       height: SizeConfig.blockSizeVertical * 3,
        //     ),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Full Name',
        //               style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //             ),
        //             Text(
        //               ordersController.users[order.consumerId]['fullName'],
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .titleMedium!
        //                   .copyWith(fontSize: 15),
        //             ),
        //           ],
        //         ),
        //         const Divider(),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Phone Number',
        //               style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //             ),
        //             Text(
        //               ordersController.users[order.consumerId]['phoneNumber'],
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .titleMedium!
        //                   .copyWith(fontSize: 15),
        //             ),
        //           ],
        //         ),
        //         const Divider(),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Address',
        //               style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //             ),
        //             Text(
        //               order.address,
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .titleMedium!
        //                   .copyWith(fontSize: 15),
        //             ),
        //           ],
        //         ),
        //         const Divider(),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Payment Method',
        //               style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //             ),
        //             Text(
        //               order.paymentMathode,
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .titleMedium!
        //                   .copyWith(fontSize: 15),
        //             ),
        //           ],
        //         ),
        //         const Divider(),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Total',
        //               style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //             ),
        //             Row(
        //               children: [
        //                 Text(
        //                   order.total.toStringAsFixed(2),
        //                   style:
        //                       Theme.of(context).textTheme.titleMedium!.copyWith(
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 18,
        //                             color: Theme.of(context).primaryColor,
        //                           ),
        //                 ),
        //                 Text(
        //                   'Dh',
        //                   style:
        //                       Theme.of(context).textTheme.titleMedium!.copyWith(
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 10,
        //                             color: Theme.of(context).primaryColorDark,
        //                           ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //     SizedBox(
        //       height: SizeConfig.blockSizeVertical * 3,
        //     ),
        //   ]),
        // ),

        // columnBuilder('Customer FullName:',
        //     ordersController.users[order.consumerId]['fullName']),
        // columnBuilder('Customer Address :', order.address.toUpperCase()),
        // columnBuilder('Order Id', order.id),
        // columnBuilder('Order Id', order.id),
      ],
    );
  }
}
