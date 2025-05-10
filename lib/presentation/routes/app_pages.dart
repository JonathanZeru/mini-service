import 'package:get/get.dart';
import 'package:service_booking_app/presentation/bindings/categories_binding.dart';
import 'package:service_booking_app/presentation/bindings/category_binding.dart';
import 'package:service_booking_app/presentation/bindings/category_form_binding.dart';
import 'package:service_booking_app/presentation/bindings/home_binding.dart';
import 'package:service_booking_app/presentation/bindings/login_binding.dart';
import 'package:service_booking_app/presentation/bindings/service_binding.dart';
import 'package:service_booking_app/presentation/bindings/service_form_binding.dart';
import 'package:service_booking_app/presentation/pages/categories/categories_page.dart';
import 'package:service_booking_app/presentation/pages/categories/category_details_page.dart';
import 'package:service_booking_app/presentation/pages/categories/category_form_page.dart';
import 'package:service_booking_app/presentation/pages/home/home_page.dart';
import 'package:service_booking_app/presentation/pages/login/login_page.dart';
import 'package:service_booking_app/presentation/pages/service/service_details_page.dart';
import 'package:service_booking_app/presentation/pages/service/service_form_page.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.serviceDetails,
      page: () => const ServiceDetailsPage(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: Routes.createService,
      page: () => ServiceFormPage(isEditing: false),
      binding: ServiceFormBinding(),
    ),
    GetPage(
      name: Routes.editService,
      page: () => ServiceFormPage(isEditing: true),
      binding: ServiceFormBinding(),
    ),
    GetPage(
      name: Routes.categories,
      page: () => const CategoriesPage(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.categoryDetails,
      page: () => const CategoryDetailsPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.createCategory,
      page: () => CategoryFormPage(isEditing: false),
      binding: CategoryFormBinding(),
    ),
    GetPage(
      name: Routes.editCategory,
      page: () => CategoryFormPage(isEditing: true),
      binding: CategoryFormBinding(),
    ),
  ];
}
