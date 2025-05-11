import 'package:get/get.dart';
import 'package:service_booking_app/data/repositories/auth_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/auth_repository.dart';
import 'package:service_booking_app/domain/usecases/get_current_user.dart';
import 'package:service_booking_app/domain/usecases/is_logged_in.dart';
import 'package:service_booking_app/domain/usecases/login.dart';
import 'package:service_booking_app/domain/usecases/logout.dart';
import 'package:service_booking_app/domain/usecases/register.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Auth repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      fenix: true,
    );
    
    // Auth use cases
    Get.lazyPut(() => Login(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => Register(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => Logout(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => GetCurrentUser(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(() => IsLoggedIn(Get.find<AuthRepository>()), fenix: true);
    
    // Change this to put permanent instead of lazyPut
    Get.put(
      AuthController(
        login: Get.find<Login>(),
        register: Get.find<Register>(),
        logout: Get.find<Logout>(),
        getCurrentUser: Get.find<GetCurrentUser>(),
        isLoggedIn: Get.find<IsLoggedIn>(),
      ),
      permanent: true, // This keeps the controller alive
    );
  }
}