import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/controllers/splash_controller.dart';
import 'package:service_booking_app/presentation/controllers/theme_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<AuthController>();
    
    Get.lazyPut(() => LanguageController(), fenix: true);
    
    Get.lazyPut(() => ThemeController(), fenix: true);
    
    Get.lazyPut(
      () => SplashController(
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
