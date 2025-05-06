import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking/presentation/controllers/login_controller.dart';
import 'package:mini_service_booking/presentation/controllers/navigation_controller.dart';

import 'package:mini_service_booking/presentation/controllers/profile_controller.dart';
import 'package:mini_service_booking/presentation/controllers/signup_controller.dart';

class AppBindings extends Bindings {
  final bool isLoggedIn;
  final List<ConnectivityResult> connectivityResult;

  AppBindings({required this.isLoggedIn, required this.connectivityResult});

  @override
  void dependencies() {
    // Initialize login and sign-up controllers for authentication
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);

    // If the user is logged in, initialize other controllers

    if (isLoggedIn && connectivityResult.contains(ConnectivityResult.none)) {
      Get.lazyPut(() => NavigationController(), fenix: true);
      Get.lazyPut(() => ProfileController(), fenix: true);
    }
  }
}
