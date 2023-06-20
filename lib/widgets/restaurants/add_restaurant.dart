import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_admin/models/models.dart';
import 'package:food_delivery_admin/screens/restaurants/restaurant_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart' as mime;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../config/size_config.dart';
import '../../controllers/controllers.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  final restaurantController = Get.put(RestaurantController());

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final lngController = TextEditingController();
  final latController = TextEditingController();
  final deliveryTimeController = TextEditingController();
  final deliveryFeesController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RegExp regExp = RegExp(r"^[0-9]+(\.[0-9]+)?$");

  File? _pickedImage;

  Uint8List _webImage = Uint8List(8);

  File? _pickedImageLogo;

  Uint8List _webImageLogo = Uint8List(8);
  Future<void> pickImageCover() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image != null) {
        // var selected = File(image.path);
        setState(() {
          // restaurantController.pickedImage.value = selected;
        });
      } else {}
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          _webImage = f;
          _pickedImage = File('a');
        });
      } else {}
    } else {}
  }

  Future<void> pickImageLogo() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image != null) {
        // var selected = File(image.path);
        setState(() {
          // restaurantController.pickedImageLogo.value = selected;
        });
      } else {}
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      print('image : $image == null');
      if (image != null) {
        print('image : ttest');

        var f = await image.readAsBytes();
        setState(() {
          _webImageLogo = f;
          _pickedImageLogo = File('a');
        });
      } else {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 300,
              child: FadeInImage(
                placeholder: const AssetImage(
                  'assets/restaurant.png',
                ),
                image: _pickedImage == null
                    ? const AssetImage(
                        'assets/restaurant.png',
                      )
                    : kIsWeb
                        ? MemoryImage(_webImage) as ImageProvider
                        : FileImage(_pickedImage as File),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage(
                          placeholder: const AssetImage(
                            'assets/logo-place.png',
                          ),
                          image: _pickedImageLogo == null
                              ? const AssetImage(
                                  'assets/logo-place.png',
                                )
                              : kIsWeb
                                  ? MemoryImage(_webImageLogo) as ImageProvider
                                  : FileImage(_pickedImageLogo as File),
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/restaurant.png');
                          },
                        )),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColorDark),
                child: IconButton(
                  onPressed: () async {
                    await pickImageCover();
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              left: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColorDark),
                  child: IconButton(
                    onPressed: () async {
                      await pickImageLogo();
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  children: <Widget>[
                    costumContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                        onChanged: (value) {
                          if (nameController.text.isNotEmpty) {
                            restaurantController.isCleanName.value = false;
                          } else {
                            restaurantController.isCleanName.value = true;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Name",
                          suffixIcon: restaurantController.isCleanName.value
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    nameController.clear();
                                    restaurantController.isCleanName.value =
                                        true;
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The restaurant name field can\'t be empty';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    costumContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                        controller: descriptionController,
                        onChanged: (value) {
                          if (descriptionController.text.isNotEmpty) {
                            restaurantController.isCleanDescription.value =
                                false;
                          } else {
                            restaurantController.isCleanDescription.value =
                                true;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Description",
                          suffixIcon: restaurantController
                                  .isCleanDescription.value
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    descriptionController.clear();
                                    restaurantController
                                        .isCleanDescription.value = true;
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The restaurant description number field can\'t be empty';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    costumContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: phoneController,
                        onChanged: (value) {
                          if (phoneController.text.isNotEmpty) {
                            restaurantController.isCleanPhone.value = false;
                          } else {
                            restaurantController.isCleanPhone.value = true;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Phone Number",
                          suffixIcon: restaurantController.isCleanPhone.value
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    phoneController.clear();
                                    restaurantController.isCleanPhone.value =
                                        true;
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The restaurant phone number field can\'t be empty';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    costumContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: addressController,
                        onChanged: (value) {
                          if (addressController.text.isNotEmpty) {
                            restaurantController.isCleanAddress.value = false;
                          } else {
                            restaurantController.isCleanAddress.value = true;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Address",
                          suffixIcon: restaurantController.isCleanAddress.value
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    addressController.clear();
                                    restaurantController.isCleanAddress.value =
                                        true;
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The restaurant address field can\'t be empty';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: costumContainer(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: latController,
                              onChanged: (value) {
                                if (latController.text.isNotEmpty) {
                                  restaurantController.isCleanlat.value = false;
                                } else {
                                  restaurantController.isCleanlat.value = true;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Latitude",
                                suffixIcon:
                                    restaurantController.isCleanlat.value
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              latController.clear();
                                              restaurantController
                                                  .isCleanlat.value = true;
                                            },
                                            icon: Icon(
                                              Icons.clear_rounded,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'The restaurant latitude field can\'t be empty';
                                }
                                if (!regExp.hasMatch(value)) {
                                  return 'Only numbers.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 2,
                        ),
                        Expanded(
                          flex: 6,
                          child: costumContainer(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: lngController,
                              onChanged: (value) {
                                if (lngController.text.isNotEmpty) {
                                  restaurantController.isCleanlng.value = false;
                                } else {
                                  restaurantController.isCleanlng.value = true;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Longitude",
                                suffixIcon:
                                    restaurantController.isCleanlng.value
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              lngController.clear();
                                              restaurantController
                                                  .isCleanlng.value = true;
                                            },
                                            icon: Icon(
                                              Icons.clear_rounded,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'The restaurant longitude field can\'t be empty';
                                }
                                if (!regExp.hasMatch(value)) {
                                  return 'OThe entered longitude must contains only numbers.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: costumContainer(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: deliveryTimeController,
                              onChanged: (value) {
                                if (deliveryTimeController.text.isNotEmpty) {
                                  restaurantController
                                      .isCleanDeliveryTime.value = false;
                                } else {
                                  restaurantController
                                      .isCleanDeliveryTime.value = true;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Delivery Time",
                                suffixIcon: restaurantController
                                        .isCleanDeliveryTime.value
                                    ? null
                                    : IconButton(
                                        onPressed: () {
                                          deliveryTimeController.clear();
                                          restaurantController
                                              .isCleanDeliveryTime.value = true;
                                        },
                                        icon: Icon(
                                          Icons.clear_rounded,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'The restaurant delivery time field can\'t be empty';
                                }
                                if (!regExp.hasMatch(value)) {
                                  return 'Only numbers.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 2,
                        ),
                        Expanded(
                          child: costumContainer(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: deliveryFeesController,
                              onChanged: (value) {
                                if (deliveryFeesController.text.isNotEmpty) {
                                  restaurantController
                                      .isCleanDeliveryFees.value = false;
                                } else {
                                  restaurantController
                                      .isCleanDeliveryFees.value = true;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Delivery Fees",
                                suffixIcon: restaurantController
                                        .isCleanDeliveryFees.value
                                    ? null
                                    : IconButton(
                                        onPressed: () {
                                          deliveryFeesController.clear();
                                          restaurantController
                                              .isCleanDeliveryFees.value = true;
                                        },
                                        icon: Icon(
                                          Icons.clear_rounded,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'The restaurant delivery fees field can\'t be empty';
                                }
                                if (!regExp.hasMatch(value)) {
                                  return 'Only numbers.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    costumContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        onChanged: (value) {
                          if (emailController.text.isNotEmpty) {
                            restaurantController.isCleanEmail.value = false;
                          } else {
                            restaurantController.isCleanEmail.value = true;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Email",
                          suffixIcon: restaurantController.isCleanEmail.value
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    emailController.clear();
                                    restaurantController.isCleanEmail.value =
                                        true;
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The restaurant email field can\'t be empty';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    costumContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        onChanged: (value) {
                          if (passwordController.text.isNotEmpty) {
                            restaurantController.isCleanPassword.value = false;
                          } else {
                            restaurantController.isCleanPassword.value = true;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Password",
                          suffixIcon: restaurantController.isCleanPassword.value
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    passwordController.clear();
                                    restaurantController.isCleanPassword.value =
                                        true;
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The restaurant password field can\'t be empty';
                          }
                          if (value.length < 6) {
                            return 'The  password must be more that 6 charachters';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Row(children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 4,
                            ),
                          ),
                          onPressed: restaurantController.isLoading.value
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    restaurantController.isLoading.value = true;

                                    if (_pickedImage == null) {
                                      restaurantController.isLoading.value =
                                          false;
                                      showSnackBar(
                                          'Error',
                                          'Please select the restaurant cover image',
                                          Colors.red.shade400);
                                      return;
                                    }
                                    if (_pickedImageLogo == null) {
                                      restaurantController.isLoading.value =
                                          false;
                                      showSnackBar(
                                          'Error',
                                          'Please select the restaurant logo image',
                                          Colors.red.shade400);
                                      return;
                                    }
                                    String logoExtension = 'jpg';
                                    String coverExtenion = 'jpg';
                                    if (!kIsWeb) {
                                      String logoFileName =
                                          path.basename(_pickedImageLogo!.path);
                                      logoExtension = path
                                          .extension(logoFileName)
                                          .toLowerCase();
                                    } else {
                                      String mimeType = mime.lookupMimeType(
                                          '.bin',
                                          headerBytes: _webImageLogo) as String;
                                      logoExtension =
                                          mime.extensionFromMime(mimeType);
                                    }

                                    if (!kIsWeb) {
                                      String coverFileName =
                                          path.basename(_pickedImage!.path);
                                      logoExtension = path
                                          .extension(coverFileName)
                                          .toLowerCase();
                                    } else {
                                      String mimeType = mime.lookupMimeType(
                                          '.bin',
                                          headerBytes: _webImage) as String;
                                      logoExtension =
                                          mime.extensionFromMime(mimeType);
                                    }
                                    final id = const Uuid().v4();
                                    final ref = FirebaseStorage.instance
                                        .ref()
                                        .child('restaurants')
                                        .child('restaurants-covers')
                                        .child('${id}cover.$coverExtenion');
                                    final ref2 = FirebaseStorage.instance
                                        .ref()
                                        .child('restaurants')
                                        .child('restaurants-logos')
                                        .child('${id}logo.$logoExtension');

                                    if (!kIsWeb) {
                                      if (_pickedImage != null) {
                                        await ref.putFile(_pickedImage as File);
                                      }
                                      if (_pickedImageLogo != null) {
                                        await ref2
                                            .putFile(_pickedImageLogo as File);
                                      }
                                    } else {
                                      if (_pickedImage != null) {
                                        await ref.putData(_webImage);
                                      }
                                      if (_pickedImageLogo != null) {
                                        await ref2.putData(_webImageLogo);
                                      }
                                    }
                                    var coverUrl = await ref.getDownloadURL();
                                    var logoUrl = await ref2.getDownloadURL();

                                    try {
                                      // Create the user account using Firebase Authentication
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      final restaurant = Restaurant(
                                        id: userCredential.user!.uid,
                                        name: nameController.text,
                                        description: descriptionController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        logoUrl: logoUrl,
                                        imageUrl: coverUrl,
                                        tags: const [],
                                        menuItemsId: const [],
                                        deliveryTime: int.parse(
                                            deliveryTimeController.text),
                                        deliveryFee: double.parse(
                                            deliveryFeesController.text),
                                        distance: 0,
                                        ratingsId: const [],
                                        priceCategory: 'Low',
                                        location: Place(
                                            lat: double.parse(
                                                latController.text),
                                            lng: double.parse(
                                                lngController.text),
                                            name: addressController.text),
                                        addedAt:
                                            DateTime.now().toIso8601String(),
                                      );
                                      restaurantController
                                          .addRestaurant(restaurant);
                                      // print(
                                      //     'User account created successfully!');
                                    } catch (error) {
                                      // print(
                                      //     'Failed to create user account: $error');
                                    }
                                    var isCleanName = true.obs;
                                    restaurantController
                                        .isCleanDescription.value = true;
                                    restaurantController.isCleanPhone.value =
                                        true;
                                    restaurantController.isCleanEmail.value =
                                        true;
                                    restaurantController
                                        .isCleanDeliveryTime.value = true;
                                    restaurantController
                                        .isCleanDeliveryFees.value = true;
                                    restaurantController.isCleanAddress.value =
                                        true;
                                    restaurantController.isCleanlat.value =
                                        true;
                                    restaurantController.isCleanlng.value =
                                        true;
                                    restaurantController.isCleanPassword.value =
                                        true;

                                    Navigator.of(context)
                                        .pushNamed(RestaurantsScreen.appRoute);
                                  }
                                },
                          child: restaurantController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  'Add Restaurant',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 2000));
  }

  Container costumContainer({required Widget child}) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: child);
  }
}
