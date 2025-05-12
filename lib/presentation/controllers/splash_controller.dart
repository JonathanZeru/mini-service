import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthController authController;

  SplashController({required this.authController});

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await authController.checkAuthStatus();

    if (isLoggedIn) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
