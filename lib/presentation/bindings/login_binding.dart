import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/login_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<AuthController>();
    
    if (!Get.isRegistered<LanguageController>()) {
      Get.put(LanguageController(), permanent: true);
    }
     Get.lazyPut<LoginController>(
      () => LoginController(
        authController: Get.find(),
      ),
      fenix: true, 
    );
  }
}
