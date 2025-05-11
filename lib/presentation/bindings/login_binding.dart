import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/login_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure AuthBinding is initialized
    Get.find<AuthController>();
    
    // Make sure LanguageController is available
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
