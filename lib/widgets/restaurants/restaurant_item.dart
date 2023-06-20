import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controllers.dart';
import '../../models/models.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantItem({
    super.key,
    required this.restaurant,
  });

  final ratingController = Get.put(RatingController());
  final menuItemsController = Get.put(MenuItemsController());
  final RestaurantController restaurantController =
      Get.put(RestaurantController());
  @override
  Widget build(BuildContext context) {
    // var rating = 0.0;

    // for (var e in restaurant.ratings) {
    //   rating += e.rate;
    // }
    // rating = rating / restaurant.ratings.length;

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
    return InkWell(
      onTap: () {
        restaurantController.restaurantInfos.value = restaurant;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: FadeInImage(
                        image: NetworkImage(
                          restaurant.imageUrl,
                        ),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/restaurant.png'),
                        placeholder: const AssetImage('assets/restaurant.png'),
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            rating.isNaN || ratings.isEmpty
                                ? 'No ratings'
                                : '$rating (${ratings.length})',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
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
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: ListView.builder(
                    itemCount: restaurant.tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        index == restaurant.tags.length - 1
                            ? Text(
                                restaurant.tags[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                '${restaurant.tags[index]}, ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        restaurant.location.name,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
