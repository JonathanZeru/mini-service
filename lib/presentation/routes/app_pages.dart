import 'package:get/get.dart';
import 'package:service_booking_app/presentation/bindings/auth_binding.dart';
import 'package:service_booking_app/presentation/bindings/categories_binding.dart';
import 'package:service_booking_app/presentation/bindings/category_binding.dart';
import 'package:service_booking_app/presentation/bindings/category_form_binding.dart';
import 'package:service_booking_app/presentation/bindings/home_binding.dart';
import 'package:service_booking_app/presentation/bindings/login_binding.dart';
import 'package:service_booking_app/presentation/bindings/register_binding.dart';
import 'package:service_booking_app/presentation/bindings/service_binding.dart';
import 'package:service_booking_app/presentation/bindings/service_form_binding.dart';
import 'package:service_booking_app/presentation/bindings/settings_binding.dart';
import 'package:service_booking_app/presentation/bindings/splash_binding.dart';
import 'package:service_booking_app/presentation/pages/auth/login_page.dart';
import 'package:service_booking_app/presentation/pages/auth/register_page.dart';
import 'package:service_booking_app/presentation/pages/categories/category_details_page.dart';
import 'package:service_booking_app/presentation/pages/categories/category_form_page.dart';
import 'package:service_booking_app/presentation/pages/main_layout.dart';
import 'package:service_booking_app/presentation/pages/service/service_details_page.dart';
import 'package:service_booking_app/presentation/pages/service/service_form_page.dart';
import 'package:service_booking_app/presentation/pages/splash/splash_page.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.home,
      page: () => const MainLayoutPage(),
      bindings: [AuthBinding(), HomeBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.serviceDetails,
      page: () => const ServiceDetailsPage(),
      binding: ServiceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.createService,
      page: () => ServiceFormPage(isEditing: false),
      binding: ServiceFormBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.editService,
      page: () => ServiceFormPage(isEditing: true),
      binding: ServiceFormBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.categoryDetails,
      page: () => const CategoryDetailsPage(),
      binding: CategoryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.createCategory,
      page: () => CategoryFormPage(isEditing: false),
      binding: CategoryFormBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.editCategory,
      page: () => CategoryFormPage(isEditing: true),
      binding: CategoryFormBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
