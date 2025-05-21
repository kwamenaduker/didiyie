import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_splash.dart';
import 'package:didiyie/didiyie_theme/didiyie_theme.dart';
import 'package:didiyie/didiyie_theme/didiyie_themecontroller.dart';
import 'package:didiyie/didiyie_translation/stringtranslation.dart';
import 'package:didiyie/didiyie_controller/auth_controller.dart';
import 'package:didiyie/didiyie_controllers/food_controller.dart';
import 'package:didiyie/didiyie_controllers/notification_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize controllers
  Get.put(AuthController());
  Get.put(FoodController());
  Get.put(NotificationController());
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themedata = Get.put(didiyieThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themedata.isDarkTheme.value ? didiyieThemes.darkTheme : didiyieThemes.lightTheme,
      fallbackLocale: const Locale('en', 'US'),
      translations: didiyieTranslation(),
      locale: const Locale('en', 'US'),
      defaultTransition: Transition.fade,
      home: const didiyieSplash(),
    );
  }

}
