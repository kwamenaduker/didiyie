import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../didiyie_gloableclass/didiyie_prefsname.dart';

class didiyieThemeController extends GetxController {
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    getThemeStatus();
  }

  void setDarkTheme(bool value) async {
    isDarkTheme.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(didiyieDarkMode, value);
    update();
  }

  Future<void> getThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = prefs.getBool(didiyieDarkMode) ?? false;
    update();
  }
}