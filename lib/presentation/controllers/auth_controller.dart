import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/user_model.dart';
import 'package:service_booking_app/domain/usecases/auth/get_current_user.dart';
import 'package:service_booking_app/domain/usecases/auth/is_logged_in.dart';
import 'package:service_booking_app/domain/usecases/auth/login.dart';
import 'package:service_booking_app/domain/usecases/auth/logout.dart';
import 'package:service_booking_app/domain/usecases/auth/register.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class AuthController extends GetxController {
  final Login login;
  final Register register;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final IsLoggedIn isLoggedIn;

  AuthController({
    required this.login,
    required this.register,
    required this.logout,
    required this.getCurrentUser,
    required this.isLoggedIn,
  });

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<bool> checkAuthStatus() async {
    isLoading.value = true;

    final loggedInResult = await isLoggedIn();

    bool result = false;

    if (loggedInResult.isRight()) {
      final isLoggedInValue = loggedInResult.getOrElse(() => false);
      isAuthenticated.value = isLoggedInValue;
      result = isLoggedInValue;

      if (isLoggedInValue) {
        Get.offAllNamed(Routes.home);
        _loadCurrentUser();
      } else {
        user.value = null;
        Get.offAllNamed(Routes.login);
      }
    } else {
      isAuthenticated.value = false;
      user.value = null;
    }

    isLoading.value = false;
    return result;
  }

  Future<void> _loadCurrentUser() async {
    final userResult = await getCurrentUser();
    userResult.fold(
      (failure) {
        user.value = null;
      },
      (currentUser) {
        user.value = currentUser;
      },
    );
  }

  Future<bool> loginUser(String username, String password) async {
    isLoading.value = true;

    final result = await login(username, password);

    return result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
        isLoading.value = false;
        return false;
      },
      (loggedInUser) {
        user.value = loggedInUser;
        isAuthenticated.value = true;
        UIHelpers.showSnackbar(
          title: 'success'.tr,
          message: 'login_success'.tr,
          isError: false,
        );
        Get.put(
          AuthController(
            login: Get.find<Login>(),
            register: Get.find<Register>(),
            logout: Get.find<Logout>(),
            getCurrentUser: Get.find<GetCurrentUser>(),
            isLoggedIn: Get.find<IsLoggedIn>(),
          ),
          permanent: true,
        );

        Future.delayed(Duration.zero, () {
          Get.offAllNamed(Routes.home);
        });

        isLoading.value = false;
        return true;
      },
    );
  }

  Future<bool> registerUser(
    String username,
    String email,
    String password,
  ) async {
    isLoading.value = true;

    final result = await register(username, email, password);

    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
        isAuthenticated.value = false;
        user.value = null;
      },
      (registeredUser) {
        UIHelpers.showSnackbar(
          title: 'success'.tr,
          message: 'register_success'.tr,
          isError: false,
        );
        isAuthenticated.value = true;
        user.value = registeredUser;
        Get.offAllNamed(Routes.login);
      },
    );

    isLoading.value = false;
    return isAuthenticated.value;
  }

  Future<void> logoutUser() async {
    isLoading.value = true;

    final result = await logout();

    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (_) {
        UIHelpers.showSnackbar(
          title: 'success'.tr,
          message: 'logout_success'.tr,
          isError: false,
        );
        isAuthenticated.value = false;
        user.value = null;
        Get.offAllNamed(Routes.login);
      },
    );

    isLoading.value = false;
  }

  bool get isAdmin => user.value?.isAdmin ?? false;
}
