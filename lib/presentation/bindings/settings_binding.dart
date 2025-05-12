import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';
import 'package:service_booking_app/presentation/controllers/theme_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<AuthController>();
    Get.find<LanguageController>();
    Get.find<ThemeController>();
    
    Get.lazyPut(
      () => SettingsController(
        authController: Get.find<AuthController>(),
        languageController: Get.find<LanguageController>(),
        themeController: Get.find<ThemeController>(),
      ),
    );
  }
}
