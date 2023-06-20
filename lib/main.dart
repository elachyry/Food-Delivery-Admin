import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_admin/firebase_options.dart';
import 'package:get/get.dart';
import 'controllers/controllers.dart';
import 'screens/screen.dart';
import 'style/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(LoginController());
    Get.put(RestaurantController());
    Get.put(OrdersController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xFFEC121D,
            <int, Color>{
              50: Color(0x1AEC121D),
              100: Color(0x33EC121D),
              200: Color(0x4DEC121D),
              300: Color(0x66EC121D),
              400: Color(0x80EC121D),
              500: Color(0xFFEC121D),
              600: Color(0x99EC121D),
              700: Color(0xB3EC121D),
              800: Color(0xCCEC121D),
              900: Color(0xE6EC121D),
            },
          ),
          scaffoldBackgroundColor: AppColors.primaryBg),
      initialBinding: BindingsBuilder(() {
        Get.put(OrdersController());
        // Other controllers or dependencies
      }),
      initialRoute: SplashScreen.appRoute,
      routes: {
        Dashboard.appRoute: (context) => Dashboard(),
        SplashScreen.appRoute: (context) => const SplashScreen(),
        SignInScreen.appRoute: (context) => const SignInScreen(),
        OrdersScreen.appRoute: (context) => OrdersScreen(),
        RestaurantsScreen.appRoute: (p0) => RestaurantsScreen(),
      },
    );
  }
}
